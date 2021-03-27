import 'package:flutter/services.dart';
import 'package:lantern/event/Event.dart';
import 'package:lantern/event/EventManager.dart';
import 'package:lantern/package_store.dart';
import 'package:lantern/utils/hex_color.dart';

import 'vpn.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final mainMethodChannel = context.watch<MethodChannel>();
    final eventManager = context.watch<EventManager>();
    eventManager.subscribe(Event.All, (eventName, params) {
      final event = EventParsing.fromValue(eventName);
      switch (event) {
        case Event.SurveyAvailable:
          {
            final message = params["message"];
            final buttonText = params["buttonText"];
            final snackBar = SnackBar(
              backgroundColor: Colors.black,
              duration: Duration(days: 99999),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.only(left: 8, right: 8, bottom: 16), // simple way to show indefinitely
              content: Text(message),
              action: SnackBarAction(
                textColor: HexColor(secondaryPink),
                label: buttonText,
                onPressed: () {
                  mainMethodChannel.invokeMethod("showLastSurvey");
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
      }
    });
  }

  void onPageChange(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  onUpdateCurrentIndexPageView(int index) {
    _pageController.animateToPage(index,
        duration: Duration(milliseconds: 100), curve: Curves.bounceIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        onPageChanged: onPageChange,
        controller: _pageController,
        children: [
          VPNTab(),
          Center(child: Text("Need to build this")),
        ],
      ),
      bottomNavigationBar: CustomBottomBar(
        currentIndex: _currentIndex,
        updateCurrentIndexPageView: onUpdateCurrentIndexPageView,
      ),
    );
  }
}
