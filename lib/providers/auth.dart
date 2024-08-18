import 'dart:convert';

import '../models/http_exception.dart';
import '../utils/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  bool _isLogin = false;
  int _id = 0;
  String _accessToken = "";
  String _refreshToken = "";

  String get accessToken {
    return _accessToken;
  }

  String _avatar = "";

  String get avatar {
    return _avatar;
  }

  bool get isAuth {
    return _accessToken != "";
  }

  int get id {
    return _id;
  }

  Future<Map<String, dynamic>> login(String userName, String password) async {
    try {
      final response = await http.post(
        Uri.parse(API.login),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'grant_type': 'password',
          'username': userName,
          'password': password,
          'scope': '',
          'client_id': 'string',
          'client_secret': 'string',
        },
      );
      final responseData = json.decode(response.body) as Map<String, dynamic>;
      responseData['status'] = response.statusCode;
      if (response.statusCode == 403) {
        return responseData;
      }

      if (response.statusCode != 200) {
        throw Exception(responseData['detail'] ?? 'An error occurred');
      }
      _accessToken = responseData["access_token"];
      _refreshToken = responseData["refresh_token"];
      notifyListeners();
      return responseData;
    } catch (error) {
      print("DAYyyyyyy ${error.toString()}");
      rethrow;
    }
  }

  Future<bool> register(String userName, String password, String fullName,
      String phoneNumber) async {
    try {
      final response = await http.post(
        Uri.parse(API.signup),
        body: json.encode({
          'user_name': userName,
          'password': password,
          'full_name': fullName,
          'phone_number': phoneNumber,
        }),
      );
      final responseData = json.decode(response.body);
      print(responseData);
      if (responseData['status'] == 'error') {
        throw HttpException(responseData['message']);
      }
      if (responseData['status'] == 'success') {
        notifyListeners();
        return true;
      } else {
        notifyListeners();
        return false;
      }
      // notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Locale _currentLocale = Locale('vi');
  int _selectedLanguage = 1;
  final Map<int, Locale> _locales = {
    1: const Locale('en'),
    2: const Locale('vi'),
  };

  int get selectedLanguage {
    return _selectedLanguage;
  }

  void set selectedLanguage(int value) {
    _selectedLanguage = value;
    notifyListeners();
  }

  Map<int, Locale> get locales {
    return _locales;
  }

  void changeLocale(Locale newLocale) {
    _currentLocale = newLocale;
    notifyListeners();
  }
}
