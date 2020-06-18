import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../widgets/common_button.dart';

class SuccessScreen extends StatelessWidget {
  final int orderId;
  final bool isPhotoCake;

  SuccessScreen(this.orderId, this.isPhotoCake);

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
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.width < 600
                            ? MediaQuery.of(context).size.height * 0.1
                            : MediaQuery.of(context).size.height * 0.2,
                        child: SvgPicture.asset('assets/img/logo.svg'),
                      ),
                      SizedBox(
                        height: isPhotoCake ? 50 : 100,
                      ),
                      Text(
                        'Thanks for Shopping at JustBake',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .primaryTextTheme
                            .headline4
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: isPhotoCake ? 30 : 100,
                      ),
                      if (isPhotoCake) ...[
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: QrImage(
                              backgroundColor: Colors.white,
                              padding: EdgeInsets.all(20),
                              data:
                                  'https://photo.justbakeadmin.live/?id=$orderId',
                              version: QrVersions.auto,
                              size: 250.0,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          'Please confirm your order at counter'.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .primaryTextTheme
                              .headline4
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                      SizedBox(
                        height: isPhotoCake ? 50 : 100,
                      ),
                      Text(
                        'Visit Again',
                        style: Theme.of(context)
                            .primaryTextTheme
                            .headline5
                            .copyWith(
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.italic,
                              color: Colors.white,
                            ),
                      ),
                      SizedBox(
                        height: isPhotoCake ? 50 : 100,
                      ),
                      Center(
                        child: CommonButton(
                          title: 'Place Another Order',
                          borderRadius: 30,
                          fontSize: 16,
                          width: MediaQuery.of(context).size.width < 600
                              ? 200
                              : 250,
                          gradient: LinearGradient(
                            colors: [
                              Theme.of(context).primaryColor,
                              Theme.of(context).primaryColor,
                            ],
                          ),
                          onPressed: () => Navigator.of(context).pop(),
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
