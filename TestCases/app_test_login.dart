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

testWidgets("app login test", (tester) async {
      
  app.main();
  tester.pumpAndSettle();

final emailField = find.byKey(Key('emailfield'));
    final passwordField = find.byKey(Key("passwordfield"));
    final accpttrms = find.byKey(Key('acceptterms'));
    final signInButton = find.byKey(Key('registerbtn'));
    final homepage = find.byType(Home);
     final alertdilog = find.byType(AlertDialog);
     final okayDilog = find.byKey(Key('dialog'));
    final authPage = find.byType(Authentication);



  
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