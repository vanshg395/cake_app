import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import './menu_screen.dart';
import '../widgets/common_button.dart';
import '../providers/auth.dart';
import '../providers/data.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  bool _isNotVisible = true;
  GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, String> _data = {};

  Future<void> _submit() async {
    _formKey.currentState.save();
    if (!_formKey.currentState.validate()) {
      return;
    }
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<Auth>(context, listen: false).login(_data);

      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(
      //     builder: (ctx) => MenuScreen(),
      //   ),
      // );
    } catch (e) {
      print(e);
      String _errorMessage = 'Some Error Occurred';
      if (e.toString() == 'Invalid Details') {
        _errorMessage = 'Invalid Login Credentials. Please try again!';
      } else if (e.toString() == 'Not a Manager') {
        _errorMessage =
            'This is not a Manager Account. Please use a Manager Account to login.';
      } else if (e.toString() == 'Internal Server Error') {
        _errorMessage = 'Internal Server Error';
      }
      setState(() {
        _isLoading = false;
      });
      await showDialog(
        context: context,
        child: AlertDialog(
          title: Text('Error'),
          content: Text(_errorMessage),
          actions: [
            FlatButton(
              child: Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    }
    setState(() {
      _isLoading = false;
    });
  }

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
                  child: Form(
                    key: _formKey,
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
                                height:
                                    MediaQuery.of(context).size.height * 0.03,
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
                                  validator: (value) {
                                    if (value == '') {
                                      return 'This field is required.';
                                    }
                                  },
                                  onSaved: (value) {
                                    _data['username'] = value;
                                  },
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03,
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
                                      padding:
                                          const EdgeInsets.only(right: 20.0),
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
                                  validator: (value) {
                                    if (value == '') {
                                      return 'This field is required.';
                                    }
                                  },
                                  onSaved: (value) {
                                    _data['password'] = value;
                                  },
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                              ),
                              _isLoading
                                  ? CircularProgressIndicator()
                                  : CommonButton(
                                      title: 'Dive In',
                                      borderRadius: 30,
                                      fontSize:
                                          MediaQuery.of(context).size.width <
                                                  600
                                              ? 16
                                              : 26,
                                      width: MediaQuery.of(context).size.width <
                                              600
                                          ? 200
                                          : 250,
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xFF64CCF9),
                                          Color(0xFFA334F4),
                                        ],
                                      ),
                                      onPressed: _submit,
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
