import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../widgets/common_button.dart';

class UserDetailsScreen extends StatefulWidget {
  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  String _dob = '';
  String _deliveryDate = '';

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
                                  ? Theme.of(context).primaryTextTheme.headline5
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                      style: MediaQuery.of(context).size.width <
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
                            horizontal: MediaQuery.of(context).size.width < 600
                                ? 16
                                : 30),
                        child: MediaQuery.of(context).size.width < 600
                            ? Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        'Name',
                                        style:
                                            MediaQuery.of(context).size.width <
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
                                        style:
                                            MediaQuery.of(context).size.width <
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
                                    width:
                                        MediaQuery.of(context).size.width < 600
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
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(2),
                                          borderSide: BorderSide(
                                            width: 0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
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
                                            .headline4,
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
                                    width:
                                        MediaQuery.of(context).size.width < 600
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
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(2),
                                          borderSide: BorderSide(
                                            width: 0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
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
                            horizontal: MediaQuery.of(context).size.width < 600
                                ? 16
                                : 30),
                        child: MediaQuery.of(context).size.width < 600
                            ? Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        'Phone Number',
                                        style:
                                            MediaQuery.of(context).size.width <
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
                                        style:
                                            MediaQuery.of(context).size.width <
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
                                    width:
                                        MediaQuery.of(context).size.width < 600
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
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(2),
                                          borderSide: BorderSide(
                                            width: 0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
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
                                            .headline4,
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
                                    width:
                                        MediaQuery.of(context).size.width < 600
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
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(2),
                                          borderSide: BorderSide(
                                            width: 0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
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
                            horizontal: MediaQuery.of(context).size.width < 600
                                ? 16
                                : 30),
                        child: MediaQuery.of(context).size.width < 600
                            ? Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        'Email Address',
                                        style:
                                            MediaQuery.of(context).size.width <
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
                                    width:
                                        MediaQuery.of(context).size.width < 600
                                            ? double.infinity
                                            : 300,
                                    child: TextFormField(
                                      keyboardType: TextInputType.emailAddress,
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
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(2),
                                          borderSide: BorderSide(
                                            width: 0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
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
                                        .headline4,
                                  ),
                                  Spacer(),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width < 600
                                            ? double.infinity
                                            : 300,
                                    child: TextFormField(
                                      keyboardType: TextInputType.emailAddress,
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
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(2),
                                          borderSide: BorderSide(
                                            width: 0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
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
                            horizontal: MediaQuery.of(context).size.width < 600
                                ? 16
                                : 30),
                        child: MediaQuery.of(context).size.width < 600
                            ? Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        'Date of Birth',
                                        style:
                                            MediaQuery.of(context).size.width <
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
                                    width:
                                        MediaQuery.of(context).size.width < 600
                                            ? double.infinity
                                            : 300,
                                    child: TextFormField(
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        hintStyle: TextStyle(
                                          color: Colors.black,
                                        ),
                                        hintText: _dob,
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
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(2),
                                          borderSide: BorderSide(
                                            width: 0,
                                            color: Colors.white,
                                          ),
                                        ),
                                        suffixIcon: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SvgPicture.asset(
                                            'assets/svg/calendar.svg',
                                            color:
                                                Theme.of(context).accentColor,
                                            height: 20,
                                          ),
                                        ),
                                        // contentPadding: EdgeInsets.only(
                                        //   right: 20,
                                        // ),
                                      ),
                                      onTap: () async {
                                        if (Platform.isAndroid) {
                                          final date = await showDatePicker(
                                            context: context,
                                            firstDate: DateTime(1900),
                                            initialDate: DateTime.now(),
                                            lastDate: DateTime.now(),
                                          );
                                          if (date == null) {
                                            return;
                                          }
                                          setState(() {
                                            _dob = DateFormat.yMMMMd()
                                                .format(date);

                                            // _data['from_time'] =
                                            //     DateFormat('yyyy-MM-dd')
                                            //         .format(date);
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
                                                            Navigator.of(
                                                                    context)
                                                                .pop(_date),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child:
                                                          CupertinoDatePicker(
                                                        minimumDate:
                                                            DateTime(1900),
                                                        initialDateTime:
                                                            DateTime.now(),
                                                        maximumDate:
                                                            DateTime.now(),
                                                        mode:
                                                            CupertinoDatePickerMode
                                                                .date,
                                                        onDateTimeChanged:
                                                            (date) {
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
                                            _dob = DateFormat.yMMMMd()
                                                .format(date);

                                            // _data['from_time'] =
                                            //     DateFormat('yyyy-MM-dd').format(date);
                                          });
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                children: <Widget>[
                                  Text(
                                    'Date of Birth',
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .headline4,
                                  ),
                                  Spacer(),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width < 600
                                            ? double.infinity
                                            : 300,
                                    child: TextFormField(
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        hintStyle: TextStyle(
                                          color: Colors.black,
                                        ),
                                        hintText: _dob,
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
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(2),
                                          borderSide: BorderSide(
                                            width: 0,
                                            color: Colors.white,
                                          ),
                                        ),
                                        suffixIcon: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SvgPicture.asset(
                                            'assets/svg/calendar.svg',
                                            color:
                                                Theme.of(context).accentColor,
                                            height: 20,
                                          ),
                                        ),
                                        // contentPadding: EdgeInsets.only(
                                        //   right: 20,
                                        // ),
                                      ),
                                      onTap: () async {
                                        if (Platform.isAndroid) {
                                          final date = await showDatePicker(
                                            context: context,
                                            firstDate: DateTime(1900),
                                            initialDate: DateTime.now(),
                                            lastDate: DateTime.now(),
                                          );
                                          if (date == null) {
                                            return;
                                          }
                                          setState(() {
                                            _dob = DateFormat.yMMMMd()
                                                .format(date);

                                            // _data['from_time'] =
                                            //     DateFormat('yyyy-MM-dd')
                                            //         .format(date);
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
                                                            Navigator.of(
                                                                    context)
                                                                .pop(_date),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child:
                                                          CupertinoDatePicker(
                                                        minimumDate:
                                                            DateTime(1900),
                                                        initialDateTime:
                                                            DateTime.now(),
                                                        maximumDate:
                                                            DateTime.now(),
                                                        mode:
                                                            CupertinoDatePickerMode
                                                                .date,
                                                        onDateTimeChanged:
                                                            (date) {
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
                                            _dob = DateFormat.yMMMMd()
                                                .format(date);

                                            // _data['from_time'] =
                                            //     DateFormat('yyyy-MM-dd').format(date);
                                          });
                                        }
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
                                  ? Theme.of(context).primaryTextTheme.headline4
                                  : Theme.of(context)
                                      .primaryTextTheme
                                      .headline3,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.04,
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

                                      // _data['from_time'] =
                                      //     DateFormat('yyyy-MM-dd')
                                      //         .format(date);
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
                                                color:
                                                    Theme.of(context).cardColor,
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
                                                  mode: CupertinoDatePickerMode
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

                                      // _data['from_time'] =
                                      //     DateFormat('yyyy-MM-dd').format(date);
                                    });
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
                        width:
                            MediaQuery.of(context).size.width < 600 ? 200 : 250,
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).primaryColor,
                            Theme.of(context).primaryColor,
                          ],
                        ),
                        onPressed: () {},
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
            )
          ],
        ),
      ),
    );
  }
}
