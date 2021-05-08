import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:task/Pages/authentication.dart';
import 'package:task/Pages/home.dart';

import 'package:task/main.dart' as app ; 

void main(){

group('App Testing', (){
IntegrationTestWidgetsFlutterBinding.ensureInitialized();

testWidgets("app Registration test", (tester) async {
      
  app.main();
  tester.pumpAndSettle();

final emailField = find.byKey(Key('emailfield'));
    final passwordField = find.byKey(Key("passwordfield"));
    final registerMode = find.byKey(Key('authenticate'));
    final cnfrmpassField = find.byKey(Key('cnfrmPass'));
    final accpttrms = find.byKey(Key('acceptterms'));
    final signInButton = find.byKey(Key('registerbtn'));
    



await tester.tap(registerMode);  
await tester.tap(emailField);
await tester.enterText(emailField, 'zz@zz.com');
await tester.pumpAndSettle();     
await tester.tap(passwordField);
await tester.enterText(passwordField, '123456'); 
await tester.tap(cnfrmpassField);
await tester.enterText(cnfrmpassField, '123456');  
await tester.pumpAndSettle();
await tester.tap(accpttrms);
await tester.tap(signInButton);
await tester.pumpAndSettle(); 
await tester.pumpWidget(Authentication());
await tester.pumpAndSettle(Duration(seconds: 2));
await tester.tap(emailField);
await tester.enterText(emailField, 'ss@ss.com');
await tester.pumpAndSettle();     
await tester.tap(passwordField);
await tester.enterText(passwordField, '123456');  
await tester.pumpAndSettle();
await tester.tap(accpttrms);
await tester.tap(signInButton);
await tester.pumpAndSettle();
await tester.pumpWidget(Home());


    
  }
  );
});
}