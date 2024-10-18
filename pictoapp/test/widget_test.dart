// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pictoapp/main.dart';
import 'package:pictoapp/currentuser.dart';

// We'll at minimum want tests for navigation, messaging, drawing board, & displaying of drawings


void main() {
  // This is the test that comes with the basic flutter increment app
  testWidgets('Counter increments smoke test', (WidgetTester tester) async { 
    // Build our app and trigger a frame.
    await tester.pumpWidget(App(user: CurrentUser(displayName: "poop", color: Colors.green)));

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });

   test("Display name is correctly abbreviated", () {
      var currentUser = CurrentUser(displayName: "William",color: Colors.blue);
      expect(currentUser.abbrev(),"William");

      currentUser.displayName = "Dr. Mark Goadrich";
      expect(currentUser.abbrev(),"Dr. Mark Goadr");

   });

}
