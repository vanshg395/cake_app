import 'dart:io';
import 'dart:convert';

import 'package:cake_app/screens/success_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../utils/constants.dart';
import '../providers/auth.dart';
import '../widgets/common_button.dart';

class OrderCopyScreen extends StatefulWidget {
  final String name;
  final String phone;
  final String cakeType;
  final double weight;
  final int quantity;
  final double price;
  final bool isPhotoCake;
  final Map<String, dynamic> data;

  OrderCopyScreen({
    this.name,
    this.phone,
    this.cakeType,
    this.weight,
    this.quantity,
    this.price,
    this.isPhotoCake,
    this.data,
  });

  @override
  _OrderCopyScreenState createState() => _OrderCopyScreenState();
}

class _OrderCopyScreenState extends State<OrderCopyScreen> {
  Future<void> _submit() async {
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
        body: json.encode(widget.data),
      );
      print(response.statusCode);
      print(response.body);
      Navigator.of(context).pop();
      if (response.statusCode == 201) {
        final resBody = json.decode(response.body);
        final orderId = resBody['payload']['id'];
        Navigator.of(context).popUntil((route) => route.isFirst);

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => SuccessScreen(orderId, widget.isPhotoCake),
          ),
        );
      } else {
        await showDialog(
          context: context,
          child: AlertDialog(
            title: Text('Error'),
            content: Text('Order could not be placed. Please try again.'),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            SvgPicture.asset(
              'assets/img/bg.svg',
              fit: BoxFit.cover,
            ),
            SafeArea(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                alignment: Alignment.center,
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
                            'Order Copy',
                            style: MediaQuery.of(context).size.width < 600
                                ? Theme.of(context).primaryTextTheme.headline5
                                : Theme.of(context).primaryTextTheme.headline3,
                          ),
                          Spacer(),
                          InkWell(
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.07,
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
                                    style:
                                        MediaQuery.of(context).size.width < 600
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
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(context).size.width < 600 ? 16 : 30,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            MediaQuery.of(context).size.width < 600
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'NAME',
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .bodyText1
                                            .copyWith(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w300,
                                            ),
                                      ),
                                      Text(
                                        widget.name,
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .bodyText1
                                            .copyWith(
                                              color: Colors.white,
                                              fontSize: 24,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ],
                                  )
                                : Row(
                                    children: <Widget>[
                                      Text(
                                        'NAME - ',
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .bodyText1
                                            .copyWith(
                                              color: Colors.white,
                                            ),
                                      ),
                                      Text(
                                        widget.name,
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .bodyText1
                                            .copyWith(
                                              color: Colors.white,
                                            ),
                                      ),
                                    ],
                                  ),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(
                              thickness: 1,
                              color: Theme.of(context).primaryColor,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            MediaQuery.of(context).size.width < 600
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'PHONE NUMBER',
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .bodyText1
                                            .copyWith(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w300,
                                            ),
                                      ),
                                      Text(
                                        widget.phone,
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .bodyText1
                                            .copyWith(
                                              color: Colors.white,
                                              fontSize: 24,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ],
                                  )
                                : Row(
                                    children: <Widget>[
                                      Text(
                                        'PHONE NUMBER - ',
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .bodyText1
                                            .copyWith(
                                              color: Colors.white,
                                            ),
                                      ),
                                      Text(
                                        widget.phone,
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .bodyText1
                                            .copyWith(
                                              color: Colors.white,
                                            ),
                                      ),
                                    ],
                                  ),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(
                              thickness: 1,
                              color: Theme.of(context).primaryColor,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            MediaQuery.of(context).size.width < 600
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'CAKE TYPE',
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .bodyText1
                                            .copyWith(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w300,
                                            ),
                                      ),
                                      Text(
                                        widget.cakeType,
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .bodyText1
                                            .copyWith(
                                              color: Colors.white,
                                              fontSize: 24,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ],
                                  )
                                : Row(
                                    children: <Widget>[
                                      Text(
                                        'CAKE TYPE - ',
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .bodyText1
                                            .copyWith(
                                              color: Colors.white,
                                            ),
                                      ),
                                      Text(
                                        widget.cakeType,
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .bodyText1
                                            .copyWith(
                                              color: Colors.white,
                                            ),
                                      ),
                                    ],
                                  ),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(
                              thickness: 1,
                              color: Theme.of(context).primaryColor,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            MediaQuery.of(context).size.width < 600
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'WEIGHT',
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .bodyText1
                                            .copyWith(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w300,
                                            ),
                                      ),
                                      Text(
                                        widget.weight.toString(),
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .bodyText1
                                            .copyWith(
                                              color: Colors.white,
                                              fontSize: 24,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ],
                                  )
                                : Row(
                                    children: <Widget>[
                                      Text(
                                        'WEIGHT - ',
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .bodyText1
                                            .copyWith(
                                              color: Colors.white,
                                            ),
                                      ),
                                      Text(
                                        widget.weight.toString(),
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .bodyText1
                                            .copyWith(
                                              color: Colors.white,
                                            ),
                                      ),
                                    ],
                                  ),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(
                              thickness: 1,
                              color: Theme.of(context).primaryColor,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            MediaQuery.of(context).size.width < 600
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'QUANTITY',
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .bodyText1
                                            .copyWith(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w300,
                                            ),
                                      ),
                                      Text(
                                        widget.quantity.toString(),
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .bodyText1
                                            .copyWith(
                                              color: Colors.white,
                                              fontSize: 24,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ],
                                  )
                                : Row(
                                    children: <Widget>[
                                      Text(
                                        'QUANTITY - ',
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .bodyText1
                                            .copyWith(
                                              color: Colors.white,
                                            ),
                                      ),
                                      Text(
                                        widget.quantity.toString(),
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .bodyText1
                                            .copyWith(
                                              color: Colors.white,
                                            ),
                                      ),
                                    ],
                                  ),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(
                              thickness: 1,
                              color: Theme.of(context).primaryColor,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            MediaQuery.of(context).size.width < 600
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'TOTAL AMOUNT',
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .bodyText1
                                            .copyWith(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w300,
                                            ),
                                      ),
                                      Text(
                                        widget.price.toString(),
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .bodyText1
                                            .copyWith(
                                              color: Colors.white,
                                              fontSize: 24,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ],
                                  )
                                : Row(
                                    children: <Widget>[
                                      Text(
                                        'TOTAL AMOUNT - ',
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .bodyText1
                                            .copyWith(
                                              color: Colors.white,
                                            ),
                                      ),
                                      Text(
                                        '₹ ' + widget.price.toStringAsFixed(2),
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .bodyText1
                                            .copyWith(
                                              color: Colors.white,
                                            ),
                                      ),
                                    ],
                                  ),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(
                              thickness: 1,
                              color: Theme.of(context).primaryColor,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.1,
                            ),
                            Center(
                              child: CommonButton(
                                title: 'Confirm',
                                borderRadius: 30,
                                fontSize:
                                    MediaQuery.of(context).size.width < 600
                                        ? 16
                                        : 26,
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
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
