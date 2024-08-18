import 'dart:convert';

import '../models/http_exception.dart';
import '../utils/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserProvider with ChangeNotifier {
  String _userId = "";
  String _email = "";
  String _firstName = "";
  String _lastName = "";
  String _gender = "";
  String _birthDay = "";
  String _avatar = "";
  final String accessToken;

  UserProvider({required this.accessToken});

  String get avatar {
    return _avatar;
  }

  Future<void> getUserInfo() async {
    try {
      final response = await http.get(
        Uri.parse(API.getUserInfo),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        _userId = data["user_id"];
        _avatar = data["avatar"];
        _email = data["email"];
        _firstName = data["first_name"] ?? "";
        _lastName = data["last_name"] ?? "";
        _gender = data["gender"] ?? "";
        _birthDay = data["birth_date"] ?? "";
        notifyListeners();
      } else {
        final errorData = json.decode(response.body);
        throw Exception(errorData['detail']);
      }
    } catch (error) {
      throw Exception('Failed to load user info: $error');
    }
  }
}
