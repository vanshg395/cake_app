import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/common_button.dart';

class OrderCopyScreen extends StatelessWidget {
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
                                        'XXXXXXXXXXXXXXXXXXXXXXXXXX',
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
                                        'XXXXXXXXXXXXX',
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
                                        '9876543210',
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
                                        'XXXXXXXXXXXXX',
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
                                        'XXXXXXXXXXXXXXXXX',
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
                                        'XXXXXXXXXXXXX',
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
                                        '1 KG',
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
                                        '1KG',
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
                                        '2',
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
                                        '1KG',
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
                            Center(
                              child: CommonButton(
                                title: 'Place Order',
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
                                onPressed: () {},
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
