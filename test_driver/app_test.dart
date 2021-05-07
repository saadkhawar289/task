
import 'package:flutter_driver/flutter_driver.dart';

import 'package:test/test.dart';
// import 'dart:ui' as ui;

void main() {
  group("Flutter Auth App Test", () {
    final emailField = find.byValueKey("emailfield");
    final passwordField = find.byValueKey("passwordfield");
    final registerbtn = find.text('authenticate');
    final cnfrmpassField = find.byValueKey("cnfrmPass");
    final accpttrms = find.byValueKey('acceptterms');
    final signInButton = find.text('registerbtn');
    final homepage = find.byType('Home');
    // final alertdilog = find.byType('AlertDialog');
    // final okayDilog = find.byValueKey('dialog');
    final authPage = find.byType('Authentication');

    FlutterDriver driver;
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test("login fails with incorrect email and password,", () async {
      await driver.tap(emailField);
      await driver.enterText("test123.testmail.com");
      await driver.tap(passwordField);
      await driver.enterText("test");
      await driver.tap(accpttrms);
      await driver.tap(signInButton,);
      // await driver.waitFor(alertdilog);
      // assert(alertdilog != null);
      // await driver.tap(okayDilog);
      await driver.waitUntilNoTransientCallbacks();
      assert(homepage == null);
    });

    test("logs in with correct email and password", () async {
      await driver.tap(emailField);
      await driver.enterText("ss@ss.com");
      await driver.tap(passwordField);
      await driver.enterText("123456");
      await driver.tap(accpttrms);
      await driver.tap(signInButton);
      await driver.waitFor(homepage);
      assert(homepage != null);
      await driver.waitUntilNoTransientCallbacks();
    });

    test("Register  with incorrect/same email and password", () async {
      await driver.tap(registerbtn);
      await driver.tap(emailField);
      await driver.enterText("test1x34testmail.com");
      await driver.tap(passwordField);
      await driver.enterText("tsdr");
      await driver.tap(cnfrmpassField);
      await driver.enterText("tsdr");
      await driver.tap(accpttrms);
      await driver.tap(signInButton);
      await driver.waitUntilNoTransientCallbacks();
      assert(authPage == null);
    });

    test("Register with correct email and password", () async {
      await driver.tap(registerbtn,);
      await driver.tap(emailField);
      await driver.enterText("pp@ss.com");
      await driver.tap(passwordField);
      await driver.enterText("123456");
      await driver.tap(accpttrms);
      await driver.tap(signInButton);
      await driver.waitFor(homepage);
      assert(homepage != null);
      await driver.waitUntilNoTransientCallbacks();
    });
  });
}
