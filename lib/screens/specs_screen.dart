import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';

import './details_screen.dart';
import '../widgets/dropdown.dart';
import '../widgets/common_button.dart';

class SpecsScreen extends StatefulWidget {
  @override
  _SpecsScreenState createState() => _SpecsScreenState();

  final Map<String, dynamic> cakeDetails;

  SpecsScreen(this.cakeDetails);
}

class _SpecsScreenState extends State<SpecsScreen> {
  GlobalKey<FormState> _formKey = GlobalKey();
  bool _isEggless = false;
  String _flavorName;
  double _weight = 1;
  double _cost1kg = 0;
  double _costhalfkg = 0;
  int _chosenFlavorIndex;
  int _quantity = 1;
  String _shape = 'Circle';
  Map<String, dynamic> _data = {
    'eggless': false,
    'flavor': '',
    'special_instructions': '',
    'message_on_cake': '',
  };
  Map<String, dynamic> _forwardData = {};

  @override
  void initState() {
    super.initState();
    _costhalfkg = widget.cakeDetails['half_kg_price'] * 1.0;
    _cost1kg = widget.cakeDetails['one_kg_price'] * 1.0;
  }

  Widget buildFlavorPicker(List<dynamic> flavors) {
    List<DropdownMenuItem> _flavors = flavors.map((flavor) {
      return DropdownMenuItem(
        child: Text(flavor['falvour_name']),
        value: flavor['id'],
        onTap: () {
          setState(() {
            _chosenFlavorIndex =
                flavors.indexWhere((element) => element['id'] == flavor['id']);
            _cost1kg = flavor['one_kg_price'] * 1.0;
            _costhalfkg = flavor['half_kg_price'] * 1.0;
          });
          print(_chosenFlavorIndex);
        },
      );
    }).toList();
    return Container(
      width: max(MediaQuery.of(context).size.width * 0.2, 300),
      child: MultilineDropdownButtonFormField(
        items: _flavors,
        value: _flavorName,
        iconSize: MediaQuery.of(context).size.width < 600 ? 40 : 50,
        icon: Icon(
          Icons.arrow_drop_down,
          color: Theme.of(context).primaryColor,
        ),
        iconEnabledColor: Theme.of(context).cardColor,
        iconDisabledColor: Theme.of(context).cardColor,
        onChanged: (val) {
          setState(() {
            _flavorName = val;
          });
        },
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
          hintText: 'Choose Flavor',
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
        validator: (value) {
          if (value == null) {
            return 'This field is required.';
          }
        },
        onSaved: (value) {
          _data['flavor'] = value;
        },
      ),
    );
  }

  Widget buildWeightPicker(int maxWeight, bool isHalfKgAvailable) {
    List<DropdownMenuItem> _items = [];
    if (maxWeight != 0) {
      for (var i = 1; i <= maxWeight; i++) {
        setState(() {
          _items.add(
            DropdownMenuItem(
              child: Text('${i - 0.5} KG'),
              value: i - 0.5,
            ),
          );
          _items.add(
            DropdownMenuItem(
              child: Text('$i KG'),
              value: i * 1.0,
            ),
          );
        });
      }
      if (!isHalfKgAvailable) {
        _items.removeAt(0);
      }
    }
    return Container(
      width: max(MediaQuery.of(context).size.width * 0.2, 150),
      child: MultilineDropdownButtonFormField(
        // isExpanded: true,
        items: _items,
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
            _shape = 'Circle';
            _data['shape'] = 'Circle';
          });
        },
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
          hintText: 'Weight',
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

        validator: (value) {
          if (value == null) {
            return 'This field is required.';
          }
        },
        onSaved: (value) {
          _data['weight'] = value;
          _data['cake_details'] = widget.cakeDetails['id'];
        },
      ),
    );
  }

  Widget buildQuantityPicker() {
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
        validator: (value) {
          if (value == null) {
            return 'This field is required.';
          }
        },
        onSaved: (value) {
          _data['quantity'] = value;
        },
      ),
    );
  }

  Widget buildShapePicker() {
    return Container(
      width: max(MediaQuery.of(context).size.width * 0.15, 150),
      child: MultilineDropdownButtonFormField(
        // isExpanded: true,
        items: [
          DropdownMenuItem(
            child: Text('Circle'),
            value: 'Circle',
          ),
          if (_weight >= 1) ...[
            DropdownMenuItem(
              child: Text('Square'),
              value: 'Square',
            ),
            DropdownMenuItem(
              child: Text('Heart'),
              value: 'Heart',
            ),
          ],
        ],
        value: _shape,
        iconSize: MediaQuery.of(context).size.width < 600 ? 40 : 50,
        icon: Icon(
          Icons.arrow_drop_down,
          color: Theme.of(context).primaryColor,
        ),
        iconEnabledColor: Theme.of(context).cardColor,
        iconDisabledColor: Theme.of(context).cardColor,
        onChanged: (val) {
          setState(() {
            _shape = val;
          });
        },
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
        validator: (value) {
          if (value == null) {
            return 'This field is required.';
          }
        },
        onSaved: (value) {
          _data['shape'] = value;
        },
      ),
    );
  }

  void _submit() {
    _formKey.currentState.save();
    if (!_formKey.currentState.validate()) {
      return;
    }
    Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (ctx) => UserDetailsScreen(
              _data,
              widget.cakeDetails['custom_photo_upload'],
              widget.cakeDetails['cake_name'],
              price,
              _forwardData,
            ),
          ),
        )
        .then(
          (value) => _forwardData = value,
        );
  }

  double get price {
    return _weight == null
        ? 0
        : _weight == 0.5
            ? _costhalfkg * _quantity
            : _cost1kg * _weight * _quantity;
  }

  @override
  Widget build(BuildContext context) {
    //     ['is_egless_available']);
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
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
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
                        Text(
                          widget.cakeDetails['cake_name'],
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
                            height: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Theme.of(context).primaryColor,
                                width: 5,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: CachedNetworkImage(
                                imageUrl: widget.cakeDetails['cake_image'],
                                fit: BoxFit.cover,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) => Center(
                                  child: CircularProgressIndicator(
                                      value: downloadProgress.progress),
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        if (widget.cakeDetails['does_this_have_flavours'])
                          if (MediaQuery.of(context).size.width < 600)
                            Center(
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    'Flavour',
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .bodyText1
                                        .copyWith(color: Colors.white),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  buildFlavorPicker(
                                      widget.cakeDetails['flavours']),
                                ],
                              ),
                            )
                          else
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Flavour',
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .bodyText1
                                        .copyWith(color: Colors.white),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  buildFlavorPicker(
                                      widget.cakeDetails['flavours']),
                                ],
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
                                  widget.cakeDetails['does_this_have_flavours']
                                      ? buildWeightPicker(
                                          _chosenFlavorIndex == null
                                              ? 0
                                              : widget.cakeDetails['flavours']
                                                      [_chosenFlavorIndex]
                                                  ['maximum_kgs'],
                                          widget
                                              .cakeDetails['half_kg_available'])
                                      : buildWeightPicker(
                                          widget.cakeDetails['maximum_kgs'],
                                          widget.cakeDetails[
                                              'half_kg_available']),
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
                                  buildQuantityPicker(),
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
                                  widget.cakeDetails['does_this_have_flavours']
                                      ? buildWeightPicker(
                                          _chosenFlavorIndex == null
                                              ? 0
                                              : widget.cakeDetails['flavours']
                                                      [_chosenFlavorIndex]
                                                  ['maximum_kgs'],
                                          widget
                                              .cakeDetails['half_kg_available'])
                                      : buildWeightPicker(
                                          widget.cakeDetails['maximum_kgs'],
                                          widget.cakeDetails[
                                              'half_kg_available']),
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
                                  buildQuantityPicker(),
                                ],
                              ),
                            ]
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        MediaQuery.of(context).size.width < 600
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Shape',
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .bodyText1
                                        .copyWith(color: Colors.white),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  buildShapePicker(),
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Shape',
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .bodyText1
                                        .copyWith(color: Colors.white),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  buildShapePicker(),
                                ],
                              ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        widget.cakeDetails['does_this_have_flavours']
                            ? _chosenFlavorIndex == null
                                ? Text('')
                                : Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 30),
                                    child: widget.cakeDetails['flavours']
                                                [_chosenFlavorIndex]
                                            ['is_egless_available']
                                        ? widget.cakeDetails[
                                                'is_totally_eggless_cake']
                                            ? Text(
                                                'This cake is available in Egless option only. Add ₹${widget.cakeDetails['flavours'][_chosenFlavorIndex]['egg_less_price']}/- per KG extra cost.',
                                                style: MediaQuery.of(context)
                                                            .size
                                                            .width <
                                                        600
                                                    ? Theme.of(context)
                                                        .primaryTextTheme
                                                        .bodyText2
                                                        .copyWith(
                                                            color: Colors.red)
                                                    : Theme.of(context)
                                                        .primaryTextTheme
                                                        .bodyText1
                                                        .copyWith(
                                                            color: Colors.red),
                                              )
                                            : Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Checkbox(
                                                    checkColor:
                                                        Theme.of(context)
                                                            .primaryColor,
                                                    activeColor: Colors.white,
                                                    value: _isEggless,
                                                    onChanged: (val) {
                                                      setState(() {
                                                        _isEggless = val;
                                                        _data['eggless'] = val;
                                                        if (val) {
                                                          _cost1kg += 50;
                                                          _costhalfkg += 25;
                                                        } else {
                                                          _cost1kg -= 50;
                                                          _costhalfkg -= 25;
                                                        }
                                                      });
                                                    },
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    'Eggless',
                                                    style: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width <
                                                            600
                                                        ? Theme.of(context)
                                                            .primaryTextTheme
                                                            .bodyText2
                                                            .copyWith(
                                                                color: Colors
                                                                    .white)
                                                        : Theme.of(context)
                                                            .primaryTextTheme
                                                            .bodyText1
                                                            .copyWith(
                                                                color: Colors
                                                                    .white),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Flexible(
                                                    child: Text(
                                                      '(If you choose Eggless Add ₹${widget.cakeDetails['flavours'][_chosenFlavorIndex]['egg_less_price']}/- per KG extra cost.)',
                                                      style: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width <
                                                              600
                                                          ? Theme.of(context)
                                                              .primaryTextTheme
                                                              .bodyText2
                                                              .copyWith(
                                                                  color: Colors
                                                                      .red)
                                                          : Theme.of(context)
                                                              .primaryTextTheme
                                                              .bodyText1
                                                              .copyWith(
                                                                  color: Colors
                                                                      .red),
                                                    ),
                                                  ),
                                                ],
                                              )
                                        : Text(
                                            'Eggless option is not available for this Cake',
                                            style: MediaQuery.of(context)
                                                        .size
                                                        .width <
                                                    600
                                                ? Theme.of(context)
                                                    .primaryTextTheme
                                                    .bodyText2
                                                    .copyWith(color: Colors.red)
                                                : Theme.of(context)
                                                    .primaryTextTheme
                                                    .bodyText1
                                                    .copyWith(
                                                        color: Colors.red),
                                          ),
                                  )
                            : Container(
                                margin: EdgeInsets.symmetric(horizontal: 30),
                                child: widget.cakeDetails['is_egless_available']
                                    ? widget.cakeDetails[
                                            'is_totally_eggless_cake']
                                        ? Text(
                                            'This cake is available in Egless option only. Add ₹${widget.cakeDetails['egg_less_price']}/- per KG extra cost.',
                                            style: MediaQuery.of(context)
                                                        .size
                                                        .width <
                                                    600
                                                ? Theme.of(context)
                                                    .primaryTextTheme
                                                    .bodyText2
                                                    .copyWith(color: Colors.red)
                                                : Theme.of(context)
                                                    .primaryTextTheme
                                                    .bodyText1
                                                    .copyWith(
                                                        color: Colors.red),
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Checkbox(
                                                checkColor: Theme.of(context)
                                                    .primaryColor,
                                                activeColor: Colors.white,
                                                value: _isEggless,
                                                onChanged: (val) {
                                                  setState(() {
                                                    _isEggless = val;
                                                    _data['eggless'] = val;
                                                    if (val) {
                                                      _cost1kg += 50;
                                                      _costhalfkg += 25;
                                                    } else {
                                                      _cost1kg -= 50;
                                                      _costhalfkg -= 25;
                                                    }
                                                  });
                                                },
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                'Eggless',
                                                style: MediaQuery.of(context)
                                                            .size
                                                            .width <
                                                        600
                                                    ? Theme.of(context)
                                                        .primaryTextTheme
                                                        .bodyText2
                                                        .copyWith(
                                                            color: Colors.white)
                                                    : Theme.of(context)
                                                        .primaryTextTheme
                                                        .bodyText1
                                                        .copyWith(
                                                            color:
                                                                Colors.white),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Flexible(
                                                child: Text(
                                                  '(If you choose Eggless Add ₹${widget.cakeDetails['egg_less_price']}/- per KG extra cost.)',
                                                  style: MediaQuery.of(context)
                                                              .size
                                                              .width <
                                                          600
                                                      ? Theme.of(context)
                                                          .primaryTextTheme
                                                          .bodyText2
                                                          .copyWith(
                                                              color: Colors.red)
                                                      : Theme.of(context)
                                                          .primaryTextTheme
                                                          .bodyText1
                                                          .copyWith(
                                                              color:
                                                                  Colors.red),
                                                ),
                                              ),
                                            ],
                                          )
                                    : Text(
                                        'Eggless option is not available for this Cake',
                                        style: MediaQuery.of(context)
                                                    .size
                                                    .width <
                                                600
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
                                    style:
                                        MediaQuery.of(context).size.width < 600
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
                                    maxLength: 50,
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
                                      errorStyle:
                                          TextStyle(color: Colors.red[200]),
                                    ),
                                    onSaved: (value) {
                                      if (value == '') {
                                        _data['message_on_cake'] = 'N/A';
                                      } else {
                                        _data['message_on_cake'] = value;
                                      }
                                    },
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
                                    style:
                                        MediaQuery.of(context).size.width < 600
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
                                    onSaved: (value) {
                                      if (value == '') {
                                        _data['special_instructions'] = 'N/A';
                                      } else {
                                        _data['special_instructions'] = value;
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
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
                                'TOTAL AMOUNT = ₹ $price',
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
                                      onTap: _submit,
                                    )
                                  : CommonButton(
                                      title: 'Check Out',
                                      borderRadius: 30,
                                      fontSize:
                                          MediaQuery.of(context).size.width <
                                                  600
                                              ? 16
                                              : 26,
                                      width: MediaQuery.of(context).size.width <
                                              600
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
            ),
          ],
        ),
      ),
    );
  }
}
