import 'dart:math';

import 'package:cake_app/screens/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/dropdown.dart';
import '../widgets/common_button.dart';

class SpecsScreen extends StatefulWidget {
  @override
  _SpecsScreenState createState() => _SpecsScreenState();
}

class _SpecsScreenState extends State<SpecsScreen> {
  bool _isEggless = false;

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
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                              'Specifications',
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
                      Text(
                        'Premium Black Forest Cake',
                        textAlign: TextAlign.center,
                        style: MediaQuery.of(context).size.width < 600
                            ? Theme.of(context)
                                .primaryTextTheme
                                .headline5
                                .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                )
                            : Theme.of(context)
                                .primaryTextTheme
                                .headline3
                                .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Theme.of(context).primaryColor,
                              width: 5,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: SvgPicture.asset(
                              'assets/img/cake.svg',
                              fit: BoxFit.cover,
                              height: MediaQuery.of(context).size.height * 0.3,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          if (MediaQuery.of(context).size.width < 600) ...[
                            Column(
                              children: <Widget>[
                                Text(
                                  'Weight',
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .bodyText1
                                      .copyWith(color: Colors.white),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                WeightPicker(),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Text(
                                  'Quantity',
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .bodyText1
                                      .copyWith(color: Colors.white),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                QuantityPicker(),
                              ],
                            )
                          ] else ...[
                            Row(
                              children: <Widget>[
                                Text(
                                  'Weight',
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .bodyText1
                                      .copyWith(color: Colors.white),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                WeightPicker(),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  'Quantity',
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .bodyText1
                                      .copyWith(color: Colors.white),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                QuantityPicker(),
                              ],
                            ),
                          ]
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Checkbox(
                              checkColor: Theme.of(context).primaryColor,
                              activeColor: Colors.white,
                              value: _isEggless,
                              onChanged: (val) {
                                setState(() {
                                  _isEggless = val;
                                });
                              },
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Eggless',
                              style: MediaQuery.of(context).size.width < 600
                                  ? Theme.of(context)
                                      .primaryTextTheme
                                      .bodyText2
                                      .copyWith(color: Colors.white)
                                  : Theme.of(context)
                                      .primaryTextTheme
                                      .bodyText1
                                      .copyWith(color: Colors.white),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              child: Text(
                                '(If you choose Eggless Add ₹50/- per KG extra cost.)',
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
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.start,
                        spacing: 10,
                        runSpacing: 20,
                        alignment: WrapAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 30,
                            ),
                            width: MediaQuery.of(context).size.width < 600
                                ? double.infinity
                                : 300,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Message On Cake',
                                  style: MediaQuery.of(context).size.width < 600
                                      ? Theme.of(context)
                                          .primaryTextTheme
                                          .bodyText2
                                          .copyWith(color: Colors.white)
                                      : Theme.of(context)
                                          .primaryTextTheme
                                          .bodyText1
                                          .copyWith(color: Colors.white),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  maxLength: 20,
                                  decoration: InputDecoration(
                                    counterStyle:
                                        TextStyle(color: Colors.white),
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
                                  ),
                                ),
                                Text(
                                  'Special Characters other than *!@ not allowed.',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w100,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 30,
                            ),
                            width: MediaQuery.of(context).size.width < 600
                                ? double.infinity
                                : 300,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Special Instructions',
                                  style: MediaQuery.of(context).size.width < 600
                                      ? Theme.of(context)
                                          .primaryTextTheme
                                          .bodyText2
                                          .copyWith(color: Colors.white)
                                      : Theme.of(context)
                                          .primaryTextTheme
                                          .bodyText1
                                          .copyWith(color: Colors.white),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
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
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Container(
                        width: double.infinity,
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          '*0.5 KG cake cost little more than all other quantities.',
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
                        height: 20,
                      ),
                      Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 5,
                          ),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 20,
                              spreadRadius: 3,
                              offset: Offset(1, 1),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              'TOTAL AMOUNT = ₹ 400',
                              style: MediaQuery.of(context).size.width < 600
                                  ? Theme.of(context)
                                      .primaryTextTheme
                                      .bodyText1
                                      .copyWith(
                                        fontSize: 16,
                                        color: Colors.white,
                                      )
                                  : Theme.of(context)
                                      .primaryTextTheme
                                      .headline5,
                            ),
                            MediaQuery.of(context).size.width < 600
                                ? InkWell(
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      child: Icon(
                                        Icons.done,
                                        color: Colors.white,
                                      ),
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                              blurRadius: 10,
                                              spreadRadius: 0.1),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (ctx) => UserDetailsScreen(),
                                        ),
                                      );
                                    },
                                  )
                                : CommonButton(
                                    title: 'Check Out',
                                    borderRadius: 30,
                                    fontSize:
                                        MediaQuery.of(context).size.width < 600
                                            ? 16
                                            : 26,
                                    width:
                                        MediaQuery.of(context).size.width < 600
                                            ? 200
                                            : 250,
                                    gradient: LinearGradient(
                                      colors: [
                                        Theme.of(context).primaryColor,
                                        Theme.of(context).primaryColor,
                                      ],
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (ctx) => UserDetailsScreen(),
                                        ),
                                      );
                                    },
                                  ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Positioned(
            //   bottom: 20,
            //   left: MediaQuery.of(context).size.width * 0.05,
            //   child:
            // ),
          ],
        ),
      ),
    );
  }
}

class WeightPicker extends StatefulWidget {
  @override
  _WeightPickerState createState() => _WeightPickerState();
}

class _WeightPickerState extends State<WeightPicker> {
  double _weight = 0.5;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: max(MediaQuery.of(context).size.width * 0.2, 150),
      child: MultilineDropdownButtonFormField(
        // isExpanded: true,
        items: [
          DropdownMenuItem(
            child: Text('0.5 KG'),
            value: 0.5,
          ),
          DropdownMenuItem(
            child: Text('1 KG'),
            value: 1.0,
          ),
          DropdownMenuItem(
            child: Text('1.5 KG'),
            value: 1.5,
          ),
          DropdownMenuItem(
            child: Text('2 KG'),
            value: 2.0,
          ),
          DropdownMenuItem(
            child: Text('2.5 KG'),
            value: 2.5,
          ),
          DropdownMenuItem(
            child: Text('3 KG'),
            value: 3.0,
          ),
        ],
        value: _weight,
        iconSize: MediaQuery.of(context).size.width < 600 ? 40 : 50,
        icon: Icon(
          Icons.arrow_drop_down,
          color: Theme.of(context).primaryColor,
        ),
        iconEnabledColor: Theme.of(context).cardColor,
        iconDisabledColor: Theme.of(context).cardColor,
        onChanged: (val) {
          setState(() {
            _weight = val;
          });
        },
        // validator: (value) {
        //   if (_manufCreateData['department'] == null) {
        //     return 'This field is required.';
        //   }
        // },

        // onSaved: (value) {
        //   _manufCreateData['department'] = value;
        // },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Colors.grey,
              width: 0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Colors.grey,
              width: 0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Colors.grey,
              width: 0,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Colors.grey,
              width: 0,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
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
            right: 10,
          ),
          errorStyle: TextStyle(color: Colors.red[200]),
          fillColor: Colors.white,
          filled: true,
        ),

        // validator: (value) {
        //   if (value == null) {
        //     return 'This field is required.';
        //   }
        // },
        // onSaved: (value) {
        //   _data['identity_choice'] = value;
        // },
      ),
    );
  }
}

class QuantityPicker extends StatefulWidget {
  @override
  _QuantityPickerState createState() => _QuantityPickerState();
}

class _QuantityPickerState extends State<QuantityPicker> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: max(MediaQuery.of(context).size.width * 0.15, 100),
      child: MultilineDropdownButtonFormField(
        // isExpanded: true,
        items: [
          DropdownMenuItem(
            child: Text('1'),
            value: 1,
          ),
          DropdownMenuItem(
            child: Text('2'),
            value: 2,
          ),
          DropdownMenuItem(
            child: Text('3'),
            value: 3,
          ),
          DropdownMenuItem(
            child: Text('4'),
            value: 4,
          ),
          DropdownMenuItem(
            child: Text('5'),
            value: 5,
          ),
          DropdownMenuItem(
            child: Text('6'),
            value: 6,
          ),
        ],
        value: _quantity,
        iconSize: MediaQuery.of(context).size.width < 600 ? 40 : 50,
        icon: Icon(
          Icons.arrow_drop_down,
          color: Theme.of(context).primaryColor,
        ),
        iconEnabledColor: Theme.of(context).cardColor,
        iconDisabledColor: Theme.of(context).cardColor,
        onChanged: (val) {
          setState(() {
            _quantity = val;
          });
        },
        // validator: (value) {
        //   if (_manufCreateData['department'] == null) {
        //     return 'This field is required.';
        //   }
        // },

        // onSaved: (value) {
        //   _manufCreateData['department'] = value;
        // },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Colors.grey,
              width: 0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Colors.grey,
              width: 0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Colors.grey,
              width: 0,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Colors.grey,
              width: 0,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
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
            right: 10,
          ),
          errorStyle: TextStyle(color: Colors.red[200]),
          fillColor: Colors.white,
          filled: true,
        ),

        // validator: (value) {
        //   if (value == null) {
        //     return 'This field is required.';
        //   }
        // },
        // onSaved: (value) {
        //   _data['identity_choice'] = value;
        // },
      ),
    );
  }
}
