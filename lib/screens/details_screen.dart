import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import './order_copy_screen.dart';
import '../widgets/common_button.dart';
import '../widgets/dropdown.dart';
import '../utils/constants.dart';
import '../providers/auth.dart';

class UserDetailsScreen extends StatefulWidget {
  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
  final Map<String, dynamic> data;
  final String cakeName;
  final bool isPhotoCake;
  final double price;

  UserDetailsScreen(this.data, this.isPhotoCake, this.cakeName, this.price);
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  GlobalKey<FormState> _formKey = GlobalKey();
  String _deliveryDate = '';
  Map<String, dynamic> _data = {
    'date_of_delivery': '',
  };
  String _occasion;

  @override
  void initState() {
    super.initState();
    _data = widget.data;
  }

  Future<void> _submit() async {
    _formKey.currentState.save();
    if (!_formKey.currentState.validate()) {
      return;
    }
    print(_data);
    bool _isConfirm = false;
    await showDialog(
      barrierDismissible: false,
      context: context,
      child: AlertDialog(
        title: Text('Confirm'),
        content: Text('Are you sure, you want to place the order?'),
        actions: <Widget>[
          FlatButton(
            child: Text('Yes'),
            onPressed: () {
              _isConfirm = true;
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text('No'),
            onPressed: () {
              _isConfirm = false;
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
    if (!_isConfirm) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      child: Dialog(
        child: Container(
          width: 300,
          child: ListTile(
            leading: CircularProgressIndicator(),
            title: Text('Loading'),
          ),
        ),
      ),
    );
    try {
      final url = baseUrl + 'api/core/order/';
      final response = await http.post(
        url,
        headers: {
          HttpHeaders.authorizationHeader:
              Provider.of<Auth>(context, listen: false).token,
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: json.encode(_data),
      );
      print(response.statusCode);
      print(response.body);
      Navigator.of(context).pop();
      if (response.statusCode == 201) {
        final resBody = json.decode(response.body);
        final orderId = resBody['payload']['id'];
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => OrderCopyScreen(
              name: _data['name'],
              phone: _data['phone_number'],
              cakeType: widget.cakeName,
              weight: _data['weight'],
              quantity: _data['quantity'],
              price: widget.price,
              isPhotoCake: widget.isPhotoCake,
              orderId: orderId,
            ),
          ),
        );
      } else {
        await showDialog(
          context: context,
          child: AlertDialog(
            title: Text('Error'),
            content: Text('Order could not be placed.'),
          ),
        );
      }
    } catch (e) {}
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
                width: double.infinity,
                height: double.infinity,
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height * 0.07,
                          padding: EdgeInsets.only(
                            left: 16,
                          ),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 5,
                              ),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'User Details',
                                style: MediaQuery.of(context).size.width < 600
                                    ? Theme.of(context)
                                        .primaryTextTheme
                                        .headline5
                                    : Theme.of(context)
                                        .primaryTextTheme
                                        .headline3,
                              ),
                              Spacer(),
                              InkWell(
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.07,
                                  color: Theme.of(context).primaryColor,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        Icons.chevron_left,
                                        color: Colors.white,
                                        size: Theme.of(context)
                                            .primaryTextTheme
                                            .headline4
                                            .fontSize,
                                      ),
                                      Text(
                                        'Back',
                                        style:
                                            MediaQuery.of(context).size.width <
                                                    600
                                                ? Theme.of(context)
                                                    .primaryTextTheme
                                                    .headline5
                                                : Theme.of(context)
                                                    .primaryTextTheme
                                                    .headline3,
                                      ),
                                      SizedBox(
                                        width: 16,
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width < 600
                                      ? 16
                                      : 30),
                          child: MediaQuery.of(context).size.width < 600
                              ? Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Text('Name',
                                            style: MediaQuery.of(context)
                                                        .size
                                                        .width <
                                                    600
                                                ? Theme.of(context)
                                                    .primaryTextTheme
                                                    .headline5
                                                : Theme.of(context)
                                                    .primaryTextTheme
                                                    .headline4),
                                        Text(
                                          '*',
                                          style: MediaQuery.of(context)
                                                      .size
                                                      .width <
                                                  600
                                              ? Theme.of(context)
                                                  .primaryTextTheme
                                                  .headline5
                                                  .copyWith(
                                                    color: Colors.red,
                                                  )
                                              : Theme.of(context)
                                                  .primaryTextTheme
                                                  .headline4
                                                  .copyWith(
                                                    color: Colors.red,
                                                  ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width <
                                              600
                                          ? double.infinity
                                          : 300,
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            borderSide: BorderSide(
                                              width: 0,
                                              color: Colors.white,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            borderSide: BorderSide(
                                              width: 0,
                                              color: Colors.white,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            borderSide: BorderSide(
                                              width: 0,
                                              color: Colors.white,
                                            ),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            borderSide: BorderSide(
                                              width: 0,
                                              color: Colors.white,
                                            ),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            borderSide: BorderSide(
                                              width: 0,
                                              color: Colors.white,
                                            ),
                                          ),
                                          errorStyle:
                                              TextStyle(color: Colors.red[200]),
                                        ),
                                        validator: (value) {
                                          if (value == '') {
                                            return 'This field is required.';
                                          }
                                        },
                                        onSaved: (value) {
                                          _data['name'] = value;
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              : Row(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          'Name',
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .headline4
                                              .copyWith(fontSize: 30),
                                        ),
                                        Text(
                                          '*',
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .headline4
                                              .copyWith(
                                                color: Colors.red,
                                              ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Container(
                                      width: MediaQuery.of(context).size.width <
                                              600
                                          ? double.infinity
                                          : 300,
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            borderSide: BorderSide(
                                              width: 0,
                                              color: Colors.white,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            borderSide: BorderSide(
                                              width: 0,
                                              color: Colors.white,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            borderSide: BorderSide(
                                              width: 0,
                                              color: Colors.white,
                                            ),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            borderSide: BorderSide(
                                              width: 0,
                                              color: Colors.white,
                                            ),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            borderSide: BorderSide(
                                              width: 0,
                                              color: Colors.white,
                                            ),
                                          ),
                                          errorStyle:
                                              TextStyle(color: Colors.red[200]),
                                        ),
                                        validator: (value) {
                                          if (value == '') {
                                            return 'This field is required.';
                                          }
                                        },
                                        onSaved: (value) {
                                          _data['name'] = value;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width < 600
                                      ? 16
                                      : 30),
                          child: MediaQuery.of(context).size.width < 600
                              ? Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          'Phone Number',
                                          style: MediaQuery.of(context)
                                                      .size
                                                      .width <
                                                  600
                                              ? Theme.of(context)
                                                  .primaryTextTheme
                                                  .headline5
                                              : Theme.of(context)
                                                  .primaryTextTheme
                                                  .headline4,
                                        ),
                                        Text(
                                          '*',
                                          style: MediaQuery.of(context)
                                                      .size
                                                      .width <
                                                  600
                                              ? Theme.of(context)
                                                  .primaryTextTheme
                                                  .headline5
                                                  .copyWith(
                                                    color: Colors.red,
                                                  )
                                              : Theme.of(context)
                                                  .primaryTextTheme
                                                  .headline4
                                                  .copyWith(
                                                    color: Colors.red,
                                                  ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width <
                                              600
                                          ? double.infinity
                                          : 300,
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            borderSide: BorderSide(
                                              width: 0,
                                              color: Colors.white,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            borderSide: BorderSide(
                                              width: 0,
                                              color: Colors.white,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            borderSide: BorderSide(
                                              width: 0,
                                              color: Colors.white,
                                            ),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            borderSide: BorderSide(
                                              width: 0,
                                              color: Colors.white,
                                            ),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            borderSide: BorderSide(
                                              width: 0,
                                              color: Colors.white,
                                            ),
                                          ),
                                          errorStyle:
                                              TextStyle(color: Colors.red[200]),
                                        ),
                                        validator: (value) {
                                          if (value == '') {
                                            return 'This field is required.';
                                          }
                                        },
                                        onSaved: (value) {
                                          _data['phone_number'] = value;
                                          _data['phone'] = value;
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              : Row(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          'Phone Number',
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .headline4
                                              .copyWith(fontSize: 30),
                                        ),
                                        Text(
                                          '*',
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .headline4
                                              .copyWith(
                                                color: Colors.red,
                                              ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Container(
                                      width: MediaQuery.of(context).size.width <
                                              600
                                          ? double.infinity
                                          : 300,
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            borderSide: BorderSide(
                                              width: 0,
                                              color: Colors.white,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            borderSide: BorderSide(
                                              width: 0,
                                              color: Colors.white,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            borderSide: BorderSide(
                                              width: 0,
                                              color: Colors.white,
                                            ),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            borderSide: BorderSide(
                                              width: 0,
                                              color: Colors.white,
                                            ),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            borderSide: BorderSide(
                                              width: 0,
                                              color: Colors.white,
                                            ),
                                          ),
                                          errorStyle:
                                              TextStyle(color: Colors.red[200]),
                                        ),
                                        validator: (value) {
                                          if (value == '') {
                                            return 'This field is required.';
                                          }
                                        },
                                        onSaved: (value) {
                                          _data['phone_number'] = value;
                                          _data['phone'] = value;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width < 600
                                      ? 16
                                      : 30),
                          child: MediaQuery.of(context).size.width < 600
                              ? Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          'Email Address',
                                          style: MediaQuery.of(context)
                                                      .size
                                                      .width <
                                                  600
                                              ? Theme.of(context)
                                                  .primaryTextTheme
                                                  .headline5
                                              : Theme.of(context)
                                                  .primaryTextTheme
                                                  .headline4,
                                        ),
                                      ],
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width <
                                              600
                                          ? double.infinity
                                          : 300,
                                      child: TextFormField(
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            borderSide: BorderSide(
                                              width: 0,
                                              color: Colors.white,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            borderSide: BorderSide(
                                              width: 0,
                                              color: Colors.white,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            borderSide: BorderSide(
                                              width: 0,
                                              color: Colors.white,
                                            ),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            borderSide: BorderSide(
                                              width: 0,
                                              color: Colors.white,
                                            ),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            borderSide: BorderSide(
                                              width: 0,
                                              color: Colors.white,
                                            ),
                                          ),
                                          errorStyle:
                                              TextStyle(color: Colors.red[200]),
                                        ),
                                        validator: (value) {
                                          if (value == '') {
                                            return 'This field is required.';
                                          }
                                        },
                                        onSaved: (value) {
                                          _data['email'] = value;
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              : Row(
                                  children: <Widget>[
                                    Text(
                                      'Email Address',
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .headline4
                                          .copyWith(fontSize: 30),
                                    ),
                                    Spacer(),
                                    Container(
                                      width: MediaQuery.of(context).size.width <
                                              600
                                          ? double.infinity
                                          : 300,
                                      child: TextFormField(
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            borderSide: BorderSide(
                                              width: 0,
                                              color: Colors.white,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            borderSide: BorderSide(
                                              width: 0,
                                              color: Colors.white,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            borderSide: BorderSide(
                                              width: 0,
                                              color: Colors.white,
                                            ),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            borderSide: BorderSide(
                                              width: 0,
                                              color: Colors.white,
                                            ),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            borderSide: BorderSide(
                                              width: 0,
                                              color: Colors.white,
                                            ),
                                          ),
                                          errorStyle:
                                              TextStyle(color: Colors.red[200]),
                                        ),
                                        validator: (value) {
                                          if (value == '') {
                                            return 'This field is required.';
                                          }
                                        },
                                        onSaved: (value) {
                                          _data['email'] = value;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width < 600
                                      ? 16
                                      : 30),
                          child: MediaQuery.of(context).size.width < 600
                              ? Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          'Occasion',
                                          style: MediaQuery.of(context)
                                                      .size
                                                      .width <
                                                  600
                                              ? Theme.of(context)
                                                  .primaryTextTheme
                                                  .headline5
                                              : Theme.of(context)
                                                  .primaryTextTheme
                                                  .headline4,
                                        ),
                                      ],
                                    ),
                                    Container(
                                      width: 300,
                                      child: MultilineDropdownButtonFormField(
                                        // isExpanded: true,
                                        items: [
                                          DropdownMenuItem(
                                            child: Text('Birthday'),
                                            value: 'Birthday',
                                          ),
                                          DropdownMenuItem(
                                            child: Text('Christmas'),
                                            value: 'Christmas',
                                          ),
                                          DropdownMenuItem(
                                            child: Text('New Year'),
                                            value: 'New Year',
                                          ),
                                        ],
                                        value: _occasion,
                                        iconSize:
                                            MediaQuery.of(context).size.width <
                                                    600
                                                ? 40
                                                : 50,
                                        icon: Icon(
                                          Icons.arrow_drop_down,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        iconEnabledColor:
                                            Theme.of(context).cardColor,
                                        iconDisabledColor:
                                            Theme.of(context).cardColor,
                                        onChanged: (val) {
                                          setState(() {
                                            _occasion = val;
                                          });
                                        },
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            borderSide: BorderSide(
                                              color: Colors.grey,
                                              width: 0,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            borderSide: BorderSide(
                                              color: Colors.grey,
                                              width: 0,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            borderSide: BorderSide(
                                              color: Colors.grey,
                                              width: 0,
                                            ),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            borderSide: BorderSide(
                                              color: Colors.grey,
                                              width: 0,
                                            ),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            borderSide: BorderSide(
                                              color: Colors.grey,
                                              width: 0,
                                            ),
                                          ),
                                          hintText: '',
                                          hintStyle: TextStyle(
                                            fontSize: 16,
                                          ),
                                          labelStyle: TextStyle(
                                            fontSize: 16,
                                          ),
                                          contentPadding: EdgeInsets.only(
                                            left: 20,
                                            top: 5,
                                            bottom: 5,
                                            right: 10,
                                          ),
                                          errorStyle:
                                              TextStyle(color: Colors.red[200]),
                                          fillColor: Colors.white,
                                          filled: true,
                                        ),
                                        validator: (value) {
                                          if (value == null) {
                                            return 'This field is required.';
                                          }
                                        },
                                        onSaved: (value) {
                                          _data['occasion'] = value;
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              : Row(
                                  children: <Widget>[
                                    Text(
                                      'Occasion',
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .headline4
                                          .copyWith(fontSize: 30),
                                    ),
                                    Spacer(),
                                    Container(
                                      width: 300,
                                      child: MultilineDropdownButtonFormField(
                                        // isExpanded: true,
                                        items: [
                                          DropdownMenuItem(
                                            child: Text('Birthday'),
                                            value: 'Birthday',
                                          ),
                                          DropdownMenuItem(
                                            child: Text('Christmas'),
                                            value: 'Christmas',
                                          ),
                                          DropdownMenuItem(
                                            child: Text('New Year'),
                                            value: 'New Year',
                                          ),
                                        ],
                                        value: _occasion,
                                        iconSize:
                                            MediaQuery.of(context).size.width <
                                                    600
                                                ? 40
                                                : 50,
                                        icon: Icon(
                                          Icons.arrow_drop_down,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        iconEnabledColor:
                                            Theme.of(context).cardColor,
                                        iconDisabledColor:
                                            Theme.of(context).cardColor,
                                        onChanged: (val) {
                                          setState(() {
                                            _occasion = val;
                                          });
                                        },
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            borderSide: BorderSide(
                                              color: Colors.grey,
                                              width: 0,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            borderSide: BorderSide(
                                              color: Colors.grey,
                                              width: 0,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            borderSide: BorderSide(
                                              color: Colors.grey,
                                              width: 0,
                                            ),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            borderSide: BorderSide(
                                              color: Colors.grey,
                                              width: 0,
                                            ),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            borderSide: BorderSide(
                                              color: Colors.grey,
                                              width: 0,
                                            ),
                                          ),
                                          hintText: '',
                                          hintStyle: TextStyle(
                                            fontSize: 16,
                                          ),
                                          labelStyle: TextStyle(
                                            fontSize: 16,
                                          ),
                                          contentPadding: EdgeInsets.only(
                                            left: 20,
                                            top: 5,
                                            bottom: 5,
                                            right: 10,
                                          ),
                                          errorStyle:
                                              TextStyle(color: Colors.red[200]),
                                          fillColor: Colors.white,
                                          filled: true,
                                        ),
                                        validator: (value) {
                                          if (value == null) {
                                            return 'This field is required.';
                                          }
                                        },
                                        onSaved: (value) {
                                          _data['occasion'] = value;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        Text(
                          'Get promotional offers on Birthday.',
                          style: MediaQuery.of(context).size.width < 600
                              ? Theme.of(context)
                                  .primaryTextTheme
                                  .bodyText2
                                  .copyWith(color: Colors.red)
                              : Theme.of(context)
                                  .primaryTextTheme
                                  .bodyText1
                                  .copyWith(color: Colors.red),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.06,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 50,
                            horizontal: 40,
                          ),
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: BoxDecoration(
                            color: Theme.of(context).accentColor,
                            border: Border.all(
                              color: Theme.of(context).primaryColor,
                              width: 5,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Date of Delivery',
                                textAlign: TextAlign.center,
                                style: MediaQuery.of(context).size.width < 600
                                    ? Theme.of(context)
                                        .primaryTextTheme
                                        .headline4
                                    : Theme.of(context)
                                        .primaryTextTheme
                                        .headline3,
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.04,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width < 600
                                    ? double.infinity
                                    : 300,
                                child: TextFormField(
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                    ),
                                    hintText: _deliveryDate,
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(2),
                                      borderSide: BorderSide(
                                        width: 0,
                                        color: Colors.white,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(2),
                                      borderSide: BorderSide(
                                        width: 0,
                                        color: Colors.white,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(2),
                                      borderSide: BorderSide(
                                        width: 0,
                                        color: Colors.white,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(2),
                                      borderSide: BorderSide(
                                        width: 0,
                                        color: Colors.white,
                                      ),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(2),
                                      borderSide: BorderSide(
                                        width: 0,
                                        color: Colors.white,
                                      ),
                                    ),
                                    suffixIcon: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SvgPicture.asset(
                                        'assets/svg/calendar.svg',
                                        color: Theme.of(context).accentColor,
                                        height: 20,
                                      ),
                                    ),
                                    errorStyle:
                                        TextStyle(color: Colors.red[200]),
                                    // contentPadding: EdgeInsets.only(
                                    //   right: 20,
                                    // ),
                                  ),
                                  onTap: () async {
                                    if (Platform.isAndroid) {
                                      final date = await showDatePicker(
                                        context: context,
                                        firstDate: DateTime.now(),
                                        initialDate: DateTime.now(),
                                        lastDate: DateTime.now().add(
                                          Duration(days: 365),
                                        ),
                                      );
                                      if (date == null) {
                                        return;
                                      }
                                      setState(() {
                                        _deliveryDate =
                                            DateFormat.yMMMMd().format(date);

                                        _data['date_of_delivery'] =
                                            date.toString();
                                      });
                                    } else {
                                      final DateTime date =
                                          await showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          DateTime _date;
                                          return Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.3,
                                            child: Column(
                                              children: <Widget>[
                                                Container(
                                                  color: Theme.of(context)
                                                      .cardColor,
                                                  width: double.infinity,
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: CupertinoButton(
                                                    child: Text('Done'),
                                                    onPressed: () =>
                                                        Navigator.of(context)
                                                            .pop(_date),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: CupertinoDatePicker(
                                                    minimumDate: DateTime.now(),
                                                    initialDateTime:
                                                        DateTime.now(),
                                                    maximumDate:
                                                        DateTime.now().add(
                                                      Duration(days: 365),
                                                    ),
                                                    mode:
                                                        CupertinoDatePickerMode
                                                            .date,
                                                    onDateTimeChanged: (date) {
                                                      _date = date;
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                      if (date == null) {
                                        return;
                                      }
                                      setState(() {
                                        _deliveryDate =
                                            DateFormat.yMMMMd().format(date);

                                        _data['date_of_delivery'] =
                                            date.toIso8601String();
                                      });
                                    }
                                  },
                                  validator: (value) {
                                    if (_data['date_of_delivery'] == null) {
                                      return 'This field is required';
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.06,
                        ),
                        CommonButton(
                          title: 'Confirm',
                          borderRadius: 30,
                          fontSize:
                              MediaQuery.of(context).size.width < 600 ? 16 : 26,
                          width: MediaQuery.of(context).size.width < 600
                              ? 200
                              : 250,
                          gradient: LinearGradient(
                            colors: [
                              Theme.of(context).primaryColor,
                              Theme.of(context).primaryColor,
                            ],
                          ),
                          onPressed: _submit,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.06,
                        ),
                        Container(
                          width: double.infinity,
                          alignment: Alignment.centerRight,
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          child: Text(
                            'Fields with * are compulsory.',
                            textAlign: TextAlign.end,
                            style: MediaQuery.of(context).size.width < 600
                                ? Theme.of(context)
                                    .primaryTextTheme
                                    .bodyText2
                                    .copyWith(color: Colors.red)
                                : Theme.of(context)
                                    .primaryTextTheme
                                    .bodyText1
                                    .copyWith(color: Colors.red),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
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
