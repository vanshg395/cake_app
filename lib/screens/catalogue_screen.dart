import 'package:cake_app/screens/specs_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../widgets/catalogue_card.dart';
import '../providers/data.dart';
import '../providers/auth.dart';

class CatalogueScreen extends StatefulWidget {
  @override
  _CatalogueScreenState createState() => _CatalogueScreenState();

  final String deptId;

  CatalogueScreen(this.deptId);
}

class _CatalogueScreenState extends State<CatalogueScreen> {
  List<dynamic> _cakes = [];
  bool _isLoading = false;

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> getData() async {
    setState(() {
      _isLoading = true;
    });
    await Provider.of<Data>(context, listen: false).getCakes(
        Provider.of<Auth>(context, listen: false).token, widget.deptId);
    setState(() {
      _cakes = Provider.of<Data>(context, listen: false).cakes;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('done');
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: <Widget>[
                  SvgPicture.asset(
                    'assets/img/background.svg',
                    fit: BoxFit.cover,
                  ),
                  SafeArea(
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
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
                                  'Catalogue',
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
                                    height: MediaQuery.of(context).size.height *
                                        0.07,
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
                                          style: MediaQuery.of(context)
                                                      .size
                                                      .width <
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
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              child: GridView.count(
                                crossAxisCount:
                                    MediaQuery.of(context).size.width < 600
                                        ? 2
                                        : 3,
                                childAspectRatio: 4 / 5,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 20,
                                children: _cakes
                                    .map(
                                      (cake) => CatalogueCard(
                                        name: cake['cake_name'],
                                        image: cake['cake_image'],
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (ctx) => SpecsScreen(),
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                    .toList(),
                                // children: <Widget>[

                                //   CatalogueCard(
                                //     name: 'Black Forest',
                                //     image: 'assets/img/cake.svg',
                                //     onTap: () {
                                //       Navigator.of(context).push(
                                //         MaterialPageRoute(
                                //           builder: (ctx) => SpecsScreen(),
                                //         ),
                                //       );
                                //     },
                                //   ),
                                //   CatalogueCard(
                                //     name: 'Black Forest',
                                //     image: 'assets/img/cake.svg',
                                //     onTap: () {
                                //       Navigator.of(context).push(
                                //         MaterialPageRoute(
                                //           builder: (ctx) => SpecsScreen(),
                                //         ),
                                //       );
                                //     },
                                //   ),
                                //   CatalogueCard(
                                //     name: 'Black Forest',
                                //     image: 'assets/img/cake.svg',
                                //     onTap: () {
                                //       Navigator.of(context).push(
                                //         MaterialPageRoute(
                                //           builder: (ctx) => SpecsScreen(),
                                //         ),
                                //       );
                                //     },
                                //   ),
                                //   CatalogueCard(
                                //     name: 'Black Forest',
                                //     image: 'assets/img/cake.svg',
                                //     onTap: () {
                                //       Navigator.of(context).push(
                                //         MaterialPageRoute(
                                //           builder: (ctx) => SpecsScreen(),
                                //         ),
                                //       );
                                //     },
                                //   ),
                                //   CatalogueCard(
                                //     name: 'Black Forest',
                                //     image: 'assets/img/cake.svg',
                                //     onTap: () {
                                //       Navigator.of(context).push(
                                //         MaterialPageRoute(
                                //           builder: (ctx) => SpecsScreen(),
                                //         ),
                                //       );
                                //     },
                                //   ),
                                // ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
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
