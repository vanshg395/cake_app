import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constants.dart';
import '../utils/http_exception.dart';

class Auth with ChangeNotifier {
  String _username;
  String _token;
  String _shopId;

  bool get isAuth {
    return token != null;
  }

  String get token {
    return _token;
  }

  String get username {
    return _username;
  }

  String get shopId {
    return _shopId;
  }

  Future<void> login(Map<String, String> data) async {
    try {
      final url = baseUrl + 'api/core/login/';
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(data),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        final resBody = json.decode(response.body) as Map<String, dynamic>;
        _token = 'Token ' + resBody['token'];
        _username = data['username'];
        _shopId = resBody['cake_shop_details'][0]['cake_shop'];
        final prefs = await SharedPreferences.getInstance();
        final _prefsData = json.encode({
          'token': _token,
          'username': _username,
          'shopId': _shopId,
        });
        await prefs.setString('userData', _prefsData);
        notifyListeners();
      } else if (response.statusCode == 400) {
        throw HttpException('Invalid Details');
      } else if (response.statusCode == 400) {
        throw HttpException('Not a Manager');
      } else {
        throw HttpException('Internal Server Error');
      }
    } catch (e) {
      throw e;
    }
  }

  Future<void> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    _token = extractedUserData['token'];
    _username = extractedUserData['username'];
    _shopId = extractedUserData['shopId'];
    notifyListeners();
    return true;
  }
}
