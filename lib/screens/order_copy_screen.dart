import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../widgets/common_button.dart';

class OrderCopyScreen extends StatelessWidget {
  final String name;
  final String phone;
  final String cakeType;
  final double weight;
  final int quantity;
  final double price;
  final bool isPhotoCake;
  final int orderId;

  OrderCopyScreen({
    this.name,
    this.phone,
    this.cakeType,
    this.weight,
    this.quantity,
    this.price,
    this.isPhotoCake,
    this.orderId,
  });

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
                                        name,
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
                                        name,
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
                                        phone,
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
                                        phone,
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
                                        cakeType,
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
                                        cakeType,
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
                                        weight.toString(),
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
                                        weight.toString(),
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
                                        quantity.toString(),
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
                                        quantity.toString(),
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
                                        price.toString(),
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
                                        '₹ ' + price.toStringAsFixed(2),
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
                            if (isPhotoCake) ...[
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                              ),
                              Center(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: QrImage(
                                    backgroundColor: Colors.white,
                                    padding: EdgeInsets.all(20),
                                    data: 'https://www.google.com/?id=$orderId',
                                    version: QrVersions.auto,
                                    size: 250.0,
                                  ),
                                ),
                              ),
                            ],
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.1,
                            ),
                            Center(
                              child: Text(
                                'Your order has been placed.',
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .headline3,
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
