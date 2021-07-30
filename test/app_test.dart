import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lantern/package_store.dart';
import 'package:lantern/ui/app.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sizer/sizer.dart';

void main() {
  group(
    'Widget startup',
    () {
      testWidgets(
        'Check for everything being loaded on the root',
        (WidgetTester tester) async {
          print('Load the root widget without catcher');
          await tester.pumpWidget(LanternApp());
          print('Declare a variable of type [GlobalLoaderOverlay]');
          var globalLoaderOverlay = find.byType(GlobalLoaderOverlay);
          print(
              'If the root was loaded successfully it should find [GlobalLoaderOverlay]');
          expect(globalLoaderOverlay, findsOneWidget);
          print('Declare a variable of type [Sizer]');
          var sizer = find.byType(Sizer);
          print('If the root was loaded successfully it should find [Sizer]');
          expect(sizer, findsOneWidget);
          print('Declare a variable of type [MaterialApp.router]');
          var appRouter = find.byType(MaterialApp);
          print(
              'If the root was loaded successfully it should find [MaterialApp.router]');
          expect(appRouter, findsOneWidget);
        },
      );
    },
  );
}
