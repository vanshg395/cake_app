import 'package:cake_app/screens/catalogue_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/menu_card.dart';

class MenuScreen extends StatelessWidget {
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
                      Text(
                        'Just Bake',
                        style: MediaQuery.of(context).size.width < 600
                            ? Theme.of(context)
                                .primaryTextTheme
                                .headline3
                                .copyWith(color: Theme.of(context).primaryColor)
                            : Theme.of(context)
                                .primaryTextTheme
                                .headline2
                                .copyWith(
                                    color: Theme.of(context).primaryColor),
                      ),
                      Text(
                        'Welcome',
                        style: MediaQuery.of(context).size.width < 600
                            ? Theme.of(context)
                                .primaryTextTheme
                                .headline2
                                .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                )
                            : Theme.of(context)
                                .primaryTextTheme
                                .headline1
                                .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 84),
                      ),
                      Text(
                        'Choose an Option',
                        style: Theme.of(context)
                            .primaryTextTheme
                            .bodyText1
                            .copyWith(color: Colors.white),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04),
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 30,
                        runSpacing: 30,
                        children: <Widget>[
                          MenuCard(
                            image: 'assets/img/cake.svg',
                            title: 'Regular',
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ctx) => CatalogueScreen(),
                                ),
                              );
                            },
                          ),
                          MenuCard(
                            image: 'assets/img/cake.svg',
                            title: 'Shape',
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ctx) => CatalogueScreen(),
                                ),
                              );
                            },
                          ),
                          MenuCard(
                            image: 'assets/img/cake.svg',
                            title: 'Photo',
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ctx) => CatalogueScreen(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
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
