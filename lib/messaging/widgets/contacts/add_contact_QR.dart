import 'dart:async';
import 'dart:io';

import 'package:lantern/messaging/messaging_model.dart';
import 'package:lantern/messaging/widgets/contacts/add_contactId.dart';
import 'package:lantern/messaging/widgets/message_utils.dart';
import 'package:lantern/model/protos_flutteronly/messaging.pb.dart';
import 'package:lantern/package_store.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

class AddViaQR extends StatefulWidget {
  @override
  _AddViaQRState createState() => _AddViaQRState();
}

class _AddViaQRState extends State<AddViaQR> {
  bool usingId = false;

  final _qrKey = GlobalKey(debugLabel: 'QR');

  late MessagingModel model;
  QRViewController? qrController;

  bool scanning = false;
  String? scannedContactId;
  StreamSubscription<Barcode>? subscription;

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
    } else if (Platform.isIOS) {
      qrController?.resumeCamera();
      setState(() {
        scanning = true;
      });
    }
  }

  void _onQRViewCreated(QRViewController controller, MessagingModel model) {
    qrController = controller;
    qrController?.pauseCamera();
    setState(() {
      scanning = true;
    });
    subscription = qrController?.scannedDataStream.listen((scanData) async {
      try {
        if (scannedContactId != null) {
          // we've already scanned the contact, don't bother processing again
          return;
        }
        final contactId = scanData.code;
        setState(() {
          scannedContactId = contactId;
        });
        var mostRecentHelloTs =
            await model.addProvisionalContact(scannedContactId!);
        var contactNotifier = model.contactNotifier(scannedContactId!);
        late void Function() listener;
        listener = () async {
          var updatedContact = contactNotifier.value;
          if (updatedContact != null &&
              updatedContact.mostRecentHelloTs > mostRecentHelloTs) {
            contactNotifier.removeListener(listener);
            // go back to New Message with the updatedContact info
            Navigator.pop(context, updatedContact);
          }
        };
        contactNotifier.addListener(listener);
        // immediately invoke listener in case the contactNotifier already has
        // an up-to-date contact.
        listener();
      } catch (e) {
        setState(() {
          scanning = false;
        });
        showInfoDialog(context,
            title: 'Error'.i18n,
            des: 'Something went wrong while scanning the QR code'.i18n,
            icon: ImagePaths.alert_icon,
            buttonText: 'OK'.i18n);
      } finally {
        await qrController?.pauseCamera();
      }
    });
  }

  @override
  void dispose() {
    subscription?.cancel();
    qrController?.dispose();
    if (scannedContactId != null) {
      // when exiting this screen, immediately delete any provisional contact
      model.deleteProvisionalContact(scannedContactId!);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    model = context.watch<MessagingModel>();
    return model.me((BuildContext context, Contact me, Widget? child) {
      return usingId ? AddViaContactIdBody(me) : renderQRscanner(context, me);
    });
  }

  Widget renderQRscanner(BuildContext context, Contact me) {
    return fullScreenDialogLayout(Colors.white, Colors.black, context, [
      Flexible(
        flex: 1,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Scan your Contact's QR code".i18n,
                  style: const TextStyle(
                    color: Colors.black,
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () => showInfoDialog(context,
                      title: 'Scan QR Code'.i18n,
                      des:
                          "To start a message with your friend, scan each other's QR code.  This process will verify the security and end-to-end encryption of your conversation."
                              .i18n,
                      icon: ImagePaths.qr_code,
                      buttonText: 'Got it'.i18n.toUpperCase()),
                  child: const Icon(
                    Icons.info,
                    size: 14,
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      // QR scanner for other contact
      Flexible(
        flex: 3,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Stack(
            alignment: Alignment.center,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: QRView(
                  key: _qrKey,
                  onQRViewCreated: (controller) =>
                      _onQRViewCreated(controller, model),
                ),
              ),
              if (scannedContactId != null && scanning)
                Expanded(
                  flex: 1,
                  child: LoadingBouncingGrid.square(
                    borderColor: Colors.black,
                    borderSize: 1.0,
                    size: 220.0,
                    backgroundColor: Colors.white,
                    duration: const Duration(milliseconds: 1000),
                  ),
                ),
              // const CustomAssetImage(
              //     path: ImagePaths.check_grey, size: 200),
            ],
          ),
        ),
      ),
      Flexible(
        flex: 1,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('For your Contact to scan'.i18n,
                  style: const TextStyle(
                    color: Colors.black,
                  )),
            ],
          ),
        ),
      ),
      // my own QR code
      Flexible(
        flex: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
              child: QrImage(
                data: me.contactId.id,
                errorCorrectionLevel: QrErrorCorrectLevel.H,
              ),
            ),
          ),
        ),
      ),
      Flexible(
        flex: 0,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () => setState(() {
                  usingId = true;
                }),
                child: Text('Trouble scanning?'.i18n,
                    style: const TextStyle(
                      color: Colors.black,
                    )),
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
