import 'package:cake_app/screens/catalogue_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../widgets/menu_card.dart';
import '../providers/data.dart';
import '../providers/auth.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  List<dynamic> _departments = [];
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
    await Provider.of<Data>(context, listen: false)
        .getDepartments(Provider.of<Auth>(context, listen: false).token);
    setState(() {
      _departments = Provider.of<Data>(context, listen: false).departments;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
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
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Just Bake',
                              style: MediaQuery.of(context).size.width < 600
                                  ? Theme.of(context)
                                      .primaryTextTheme
                                      .headline3
                                      .copyWith(
                                          color: Theme.of(context).primaryColor)
                                  : Theme.of(context)
                                      .primaryTextTheme
                                      .headline2
                                      .copyWith(
                                          color:
                                              Theme.of(context).primaryColor),
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
                                height:
                                    MediaQuery.of(context).size.height * 0.04),
                            _departments.length == 0
                                ? Container(
                                    height: 500,
                                    alignment: Alignment.center,
                                    child: Text(
                                      'No Cake Types Found',
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .headline4
                                          .copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                          ),
                                    ),
                                  )
                                : Wrap(
                                    alignment: WrapAlignment.center,
                                    spacing: 30,
                                    runSpacing: 30,
                                    children: _departments
                                        .map(
                                          (dept) => MenuCard(
                                            image: dept['department_image'],
                                            title: dept['department_name'],
                                            id: dept['id'],
                                            onTap: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (ctx) =>
                                                      CatalogueScreen(
                                                          dept['id']),
                                                ),
                                              );
                                            },
                                          ),
                                        )
                                        .toList(),
                                  ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Container(
                      margin: EdgeInsets.only(right: 20),
                      width: double.infinity,
                      alignment: Alignment.centerRight,
                      height: 80,
                      child: RaisedButton.icon(
                        onPressed: () {
                          print('check');
                          Provider.of<Auth>(context, listen: false).logout();
                        },
                        icon: Icon(Icons.exit_to_app),
                        label: Text('Logout'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
