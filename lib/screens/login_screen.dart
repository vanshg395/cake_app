import 'package:cake_app/screens/menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/common_button.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isNotVisible = true;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            SvgPicture.asset(
              'assets/img/background.svg',
              fit: BoxFit.cover,
            ),
            SafeArea(
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.width < 600
                            ? MediaQuery.of(context).size.height * 0.2
                            : MediaQuery.of(context).size.height * 0.3,
                        child: SvgPicture.asset('assets/img/logo.svg'),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        width: MediaQuery.of(context).size.width * 0.7,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Welcome',
                              style: MediaQuery.of(context).size.width < 600
                                  ? Theme.of(context)
                                      .primaryTextTheme
                                      .headline4
                                      .copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700)
                                  : Theme.of(context)
                                      .primaryTextTheme
                                      .headline2,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.03,
                            ),
                            Container(
                              // margin: EdgeInsets.symmetric(
                              //   horizontal: 30,
                              // ),
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Username',
                                  focusColor: Theme.of(context).primaryColor,
                                ),
                                style: MediaQuery.of(context).size.width < 600
                                    ? Theme.of(context)
                                        .primaryTextTheme
                                        .bodyText2
                                        .copyWith(color: Colors.black)
                                    : Theme.of(context)
                                        .primaryTextTheme
                                        .bodyText1
                                        .copyWith(color: Colors.black),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.03,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: TextFormField(
                                obscureText: _isNotVisible,
                                decoration: InputDecoration(
                                  // contentPadding: EdgeInsets.only(),
                                  labelText: 'Password',
                                  focusColor: Theme.of(context).primaryColor,
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.only(right: 20.0),
                                    child: InkWell(
                                      child: SvgPicture.asset(
                                        _isNotVisible
                                            ? 'assets/svg/obscure.svg'
                                            : 'assets/svg/visible.svg',
                                        height: 24,
                                        color: Theme.of(context).accentColor,
                                      ),
                                      onTap: () {
                                        setState(() {
                                          _isNotVisible = !_isNotVisible;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                style: MediaQuery.of(context).size.width < 600
                                    ? Theme.of(context)
                                        .primaryTextTheme
                                        .bodyText2
                                        .copyWith(color: Colors.black)
                                    : Theme.of(context)
                                        .primaryTextTheme
                                        .bodyText1
                                        .copyWith(color: Colors.black),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            CommonButton(
                              title: 'Dive In',
                              borderRadius: 30,
                              fontSize: MediaQuery.of(context).size.width < 600
                                  ? 16
                                  : 26,
                              width: MediaQuery.of(context).size.width < 600
                                  ? 200
                                  : 250,
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFF64CCF9),
                                  Color(0xFFA334F4),
                                ],
                              ),
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (ctx) => MenuScreen(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
