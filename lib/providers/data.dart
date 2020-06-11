import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/http_exception.dart';
import '../utils/constants.dart';

class Data with ChangeNotifier {
  List<dynamic> _departments = [];
  List<dynamic> _cakes = [];

  List<dynamic> get departments {
    return [..._departments];
  }

  List<dynamic> get cakes {
    return [..._cakes];
  }

  Future<void> getDepartments(String token) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('shopDataDepts')) {
      final extractedShopDeptsData =
          json.decode(prefs.getString('shopDataDepts')) as List<dynamic>;
      _departments = extractedShopDeptsData;
      return;
    }
    final url = baseUrl + 'api/core/get/departments/';
    final response = await http.get(
      url,
      headers: {
        HttpHeaders.authorizationHeader: token,
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      final resBody = json.decode(response.body);
      _departments = resBody['payload'];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
        'shopDataDepts',
        json.encode(_departments),
      );
    } else {
      throw HttpException('Internal Server Error');
    }
  }

  Future<void> getCakes(String token, String deptId) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('shopDataCakes_$deptId')) {
      final extractedShopDeptsData = json
          .decode(prefs.getString('shopDataCakes_$deptId')) as List<dynamic>;
      _cakes = extractedShopDeptsData;
      return;
    }
    final url = baseUrl + 'api/core/get/cakes/$deptId/';
    final response = await http.get(
      url,
      headers: {
        HttpHeaders.authorizationHeader: token,
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      final resBody = json.decode(response.body);
      _cakes = resBody['payload'];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
        'shopDataCakes_$deptId',
        json.encode(_cakes),
      );
    } else {
      throw HttpException('Internal Server Error');
    }
  }
}
