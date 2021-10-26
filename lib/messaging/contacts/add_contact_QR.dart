import 'package:lantern/messaging/messaging.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'qr_scanner_border_painter.dart';

class AddViaQR extends StatefulWidget {
  final Contact me;

  AddViaQR({Key? key, required this.me}) : super(key: key);

  @override
  _AddViaQRState createState() => _AddViaQRState();
}

class _AddViaQRState extends State<AddViaQR> with TickerProviderStateMixin {
  late MessagingModel model;
  String? provisionalContactId;
  int timeoutMillis = 0;
  late AnimationController countdownController;

  // bool usingId = false;
  final _qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? qrController;
  bool scanning = false;
  StreamSubscription<Barcode>? subscription;
  bool proceedWithoutProvisionals = false;
  ValueNotifier<Contact?>? contactNotifier;
  void Function()? listener;

  final closeOnce = once();

  // THIS IS ONLY FOR DEBUGGING PURPOSES
  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      qrController?.pauseCamera();
      setState(() {
        scanning = false;
      });
    }
  }

  final addProvisionalContactOnce = once<Future<void>>();

  Future<void> addProvisionalContact(
      MessagingModel model, String contactId, String source) async {
    if (provisionalContactId != null) {
      // we've already added a provisional contact
      return;
    }
    var result = await model.addProvisionalContact(contactId, source: source);

    contactNotifier = model.contactNotifier(contactId);
    listener = () async {
      var updatedContact = contactNotifier!.value;
      if (updatedContact != null &&
          updatedContact.mostRecentHelloTs >
              result['mostRecentHelloTsMillis']) {
        countdownController.stop(canceled: true);
        /* 
        * VERIFICATION SUCCESS
        */
        // TODO: go back to conversation
        // TODO: mark as verified
        // TODO: show snackbar
        // TODO: color animation for "Verified" status
        // go back to New Message with the updatedContact info
        closeOnce(() => Navigator.pop(context, updatedContact));
      }
    };
    contactNotifier!.addListener(listener!);
    // immediately invoke listener in case the contactNotifier already has
    // an up-to-date contact.
    listener!();

    final int expiresAt = result['expiresAtMillis'];
    (expiresAt > 0)
        ? _onCountdownTriggered(expiresAt, contactId)
        : _onNoCountdown();
  }

  void _onNoCountdown() {
    // we need to show something to the user to indicate that we're
    // waiting on the other person to scan the QR code, but in this case
    // there is no time limit.
    setState(() {
      proceedWithoutProvisionals = true;
    });
  }

  void _onCountdownTriggered(int expiresAt, String contactId) {
    final timeout = expiresAt - DateTime.now().millisecondsSinceEpoch;
    setState(() {
      provisionalContactId = contactId;
      timeoutMillis = timeout;
      countdownController.duration = Duration(milliseconds: timeoutMillis);
    });

    unawaited(countdownController.forward().then((value) {
      // we ran out of time before completing handshake, go back without adding
      closeOnce(() => Navigator.pop(context, null));
      countdownController.stop(canceled: true);
    }));
  }

  void _onQRViewCreated(QRViewController controller, MessagingModel model) {
    qrController = controller;
    qrController?.pauseCamera();
    setState(() {
      scanning = true;
    });
    subscription = qrController?.scannedDataStream.listen((scanData) async {
      try {
        await addProvisionalContactOnce(() {
          return addProvisionalContact(model, scanData.code, 'qr');
        });
      } catch (e, s) {
        setState(() {
          scanning = false;
        });
        showErrorDialog(context, e: e, s: s, des: 'qr_error_description'.i18n);
      } finally {
        await qrController?.pauseCamera();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    countdownController =
        AnimationController(vsync: this, duration: const Duration(hours: 24));
  }

  @override
  void dispose() {
    subscription?.cancel();
    qrController?.dispose();
    countdownController.dispose();
    if (listener != null) {
      contactNotifier?.removeListener(listener!);
    }
    if (provisionalContactId != null) {
      // when exiting this screen, immediately delete any provisional contact
      model.deleteProvisionalContact(provisionalContactId!);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    model = context.watch<MessagingModel>();
    return renderQRScanner(context);
  }

  Widget renderQRScanner(BuildContext context) {
    return showFullscreenDialog(
      context: context,
      iconColor: white,
      // icon color
      topColor: grey5,
      title: Center(
        child: CText('contact_verification'.i18n,
            style: tsHeading3.copiedWith(color: white)),
      ),
      backButton: mirrorLTR(
          context: context,
          child: CAssetImage(
            path: ImagePaths.arrow_back,
            color: white,
          )),
      onBackCallback: () => Navigator.pop(context, null),
      child: Container(
        color: grey5,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ((provisionalContactId != null && scanning))
                        ? PulseAnimation(
                            CText(
                              'qr_info_waiting_qr'.i18n,
                              style: tsBody1Color(white),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : Row(
                            children: [
                              CText(
                                'qr_info_scan'.i18n,
                                style: tsBody1Color(white),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.only(
                                    start: 4.0),
                                child: GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () => showInfoDialog(context,
                                      title: 'qr_info_title'.i18n,
                                      des: 'qr_info_description'.i18n,
                                      assetPath: ImagePaths.qr_code,
                                      buttonText: 'info_dialog_confirm'
                                          .i18n
                                          .toUpperCase()),
                                  child: Icon(
                                    Icons.info,
                                    size: 14,
                                    color: white,
                                  ),
                                ),
                              )
                            ],
                          ),
                  ],
                ),
              ),
              /* 
              * QR SCANNER
              */
              Flexible(
                child: Container(
                  padding: const EdgeInsetsDirectional.only(
                      top: 20.0, start: 70, end: 70, bottom: 20.0),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CustomPaint(
                          painter: QRScannerBorderPainter(),
                          child: Container(
                            padding: const EdgeInsetsDirectional.all(6.0),
                            child: Opacity(
                              opacity:
                                  (provisionalContactId != null && scanning)
                                      ? 0.5
                                      : 1,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: QRView(
                                  key: _qrKey,
                                  onQRViewCreated: (controller) =>
                                      _onQRViewCreated(controller, model),
                                ),
                              ),
                            ),
                          ),
                        ),
                        if ((provisionalContactId != null && scanning) ||
                            proceedWithoutProvisionals)
                          _renderWaitingUI(
                              proceedWithoutProvisionals:
                                  proceedWithoutProvisionals,
                              countdownController: countdownController,
                              timeoutMillis: timeoutMillis,
                              fontColor: white,
                              infoText: ''),
                      ],
                    ),
                  ),
                ),
              ),
              /* 
              * YOUR QR CODE
              */
              CText(
                'qr_for_your_contact'.i18n,
                style: tsBody1Color(white),
              ),
              Flexible(
                child: Container(
                  padding: const EdgeInsetsDirectional.only(
                      top: 20.0, start: 70, end: 70, bottom: 74.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: QrImage(
                      data: widget.me.contactId.id,
                      padding: const EdgeInsets.all(16),
                      backgroundColor: white,
                      foregroundColor: black,
                      errorCorrectionLevel: QrErrorCorrectLevel.H,
                    ),
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}

// TODO: get rid of this as well

class _renderWaitingUI extends StatelessWidget {
  const _renderWaitingUI(
      {Key? key,
      required this.proceedWithoutProvisionals,
      this.countdownController,
      this.timeoutMillis,
      required this.fontColor,
      required this.infoText})
      : super(key: key);

  final bool proceedWithoutProvisionals;
  final AnimationController? countdownController;
  final int? timeoutMillis;
  final Color fontColor;
  final String infoText;

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsetsDirectional.only(top: 16.0),
          child: CAssetImage(path: ImagePaths.check_green_large, size: 40),
        ),
        if (!proceedWithoutProvisionals)
          Padding(
            padding: const EdgeInsetsDirectional.only(
                start: 8.0, end: 8.0, top: 8.0),
            child: CText(
              'scan_complete'.i18n,
              style: tsBody1Color(fontColor),
            ),
          ),
        if (!proceedWithoutProvisionals)
          Padding(
            padding: const EdgeInsetsDirectional.all(8.0),
            child: Countdown.build(
              controller: countdownController!,
              textStyle: tsDisplay(fontColor),
              durationSeconds: timeoutMillis! ~/ 1000,
            ),
          ),
        if (infoText.isNotEmpty)
          PulseAnimation(
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsetsDirectional.only(
                    start: 20.0, top: 16.0, bottom: 16.0, end: 20.0),
                child: CText(
                  infoText,
                  style: tsBody1Color(fontColor),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
