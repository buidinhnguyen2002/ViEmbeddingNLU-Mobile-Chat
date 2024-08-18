import 'dart:convert';

import 'package:chat_document/models/bot.dart';
import 'package:chat_document/models/message.dart';

import '../models/http_exception.dart';
import '../utils/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BotProvider with ChangeNotifier {
  List<Bot> _bots = [];
  List<Message> _currentMessage = [];
  List<Bot> get bots {
    return _bots;
  }

  final String accessToken;

  BotProvider({required this.accessToken});
  Future<void> getBots() async {
    try {
      final response = await http.get(
        Uri.parse(API.getBots),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );
      if (response.statusCode != 200) {
        final data = json.decode(response.body);
        throw Exception('${data['detail']}');
      }

      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> listBots = responseData["bots"];
      _bots = listBots.map((json) => Bot.fromJson(json)).toList();
      notifyListeners();
    } catch (error) {
      throw Exception('Failed to load bots: $error');
    }
  }

  Future<void> createBot(String name, String description) async {
    final url = Uri.parse(API.bots);
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: json.encode({
          'name': name,
          'description': description,
        }),
      );
      final data = json.decode(response.body);
      if (response.statusCode == 200) {
        _bots.add(Bot.fromJson(data));
        notifyListeners();
      }
      if (response.statusCode == 422) {
        throw Exception(data['detail'][0].msg);
      }
      throw Exception(data['detail']);
    } catch (error) {
      throw Exception('Failed to create bot: $error');
    }
  }

  Future<void> updateBot(String botId, String name, String description) async {
    try {
      final response = await http.put(
        Uri.parse('${API.bots}/$botId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: json.encode({
          'name': name,
          'description': description,
        }),
      );
      final data = json.decode(response.body);
      if (response.statusCode != 200) {
        throw Exception('${data['detail']}');
      } else {
        Bot updatedBotData = Bot.fromJson(data);
        _bots = _bots.map((bot) {
          return bot.botId == updatedBotData.botId ? updatedBotData : bot;
        }).toList();
      }
      notifyListeners();
    } catch (error) {
      throw Exception('Failed to update bot: $error');
    }
  }

  Future<void> deleteBot(String botId) async {
    try {
      final response = await http.delete(
        Uri.parse('${API.bots}/$botId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode != 200) {
        final data = json.decode(response.body);
        throw Exception('${data['detail']}');
      } else {
        _bots = _bots.where((bot) => bot.botId != botId).toList();
      }
      notifyListeners();
    } catch (error) {
      throw Exception('Failed to delete bot: $error');
    }
  }

  Future<dynamic> getChatsInBot(String botId, String chatId) async {
    try {
      final uri = Uri.parse('${API.chatsBot}/$botId/chats/$chatId');
      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode != 200) {
        final data = json.decode(response.body);
        throw Exception('${data['detail']}');
      }
      return json.decode(response.body);
    } catch (error) {
      throw Exception('Failed to load chats: $error');
    }
  }
}
