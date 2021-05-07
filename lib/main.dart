import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/services.dart';

import 'package:splashscreen/splashscreen.dart';

import 'Pages/authentication.dart';
import 'Pages/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  @override
  Widget build(BuildContext context) {
    double sizeee = 120.0;
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(
        seconds: 4,
        title: Text(
          'My Task',
          style: TextStyle(
            fontSize: 45,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 3.1
              ..color = Color(0xFFFF335C),
          ),
        ),
        navigateAfterSeconds: Authentication(),
        photoSize: sizeee,
        useLoader: true,
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(),
        loadingText: Text('Loading...',
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
        loaderColor: Colors.green[700],
      ),
      routes: {
        '/home': (BuildContext context) => Home(),
        '/Auth': (BuildContext context) => Authentication()
      },
    );
  }
}
