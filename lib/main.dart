import 'package:cake_app/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import './screens/login_screen.dart';
import './screens/menu_screen.dart';
import './providers/auth.dart';
import './providers/data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Auth(),
          ),
          ChangeNotifierProvider.value(
            value: Data(),
          ),
        ],
        child: Consumer<Auth>(
          builder: (context, auth, _) => MaterialApp(
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
            home: auth.isAuth
                ? MenuScreen()
                : FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (ctx, res) {
                      if (res.connectionState == ConnectionState.waiting) {
                        return LoadingScreen();
                      } else {
                        if (res.data) {
                          return MenuScreen();
                        } else {
                          return LoginScreen();
                        }
                      }
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
