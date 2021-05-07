 

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group("Flutter Auth App Test", () {
    final emailField = find.byValueKey("emailfield");
    final passwordField = find.byValueKey("passwordfield");
    final cnfrmpassField = find.byValueKey("cnfrmPass");
    final accpttrms =find.byValueKey('acceptterms');
    final signInButton = find.text('authenticate');
    

    FlutterDriver driver;
    setUpAll(()async{
      driver = await FlutterDriver.connect();
    });

    tearDownAll(()async{
      if(driver != null) {
        driver.close();
      }
    });

    test("login fails with incorrect email and password,",() async{
      await driver.tap(emailField);
      await driver.enterText("test123.testmail.com");
      await driver.tap(passwordField);
      await driver.enterText("test");
      await driver.tap(accpttrms);
      await driver.setTextEntryEmulation(enabled: true);
      await driver.tap(signInButton);
      
      await driver.waitUntilNoTransientCallbacks();
      
    });

    test("logs in with correct email and password",() async {
      await driver.tap(emailField);
      await driver.enterText("test@testmail.com");
      await driver.tap(passwordField);
      await driver.enterText("testtest123456");
       await driver.tap(accpttrms);
      await driver.setTextEntryEmulation(enabled: true);
      await driver.tap(signInButton);
      await driver.waitUntilNoTransientCallbacks();
      
    });


  });
}