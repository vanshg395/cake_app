import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './screens/login_screen.dart';
import './screens/menu_screen.dart';
import './screens/catalogue_screen.dart';
import './screens/specs_screen.dart';
import './screens/details_screen.dart';
import './screens/order_copy_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Just Bake',
      theme: ThemeData(
        primaryColor: Color(0xFF1188E3),
        accentColor: Color(0xFF373737),
        unselectedWidgetColor: Colors.white,
        primaryTextTheme: TextTheme(
          // headline1: TextStyle(
          //   // fontSize: 24,
          //   color: Colors.black,
          //   // fontWeight: F
          // ),
          headline2: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w800,
          ),
          headline3: TextStyle(
            color: Colors.white,
          ),
          headline4: TextStyle(
            color: Colors.white,
          ),
          bodyText1: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ),
      home: LoginScreen(),
    );
  }
}
