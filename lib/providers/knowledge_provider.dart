import 'dart:convert';
import 'dart:io';

import 'package:chat_document/models/bot.dart';
import 'package:chat_document/models/file.dart';
import 'package:chat_document/models/knowledge.dart';

import '../models/http_exception.dart';
import '../utils/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class KnowledgeProvider with ChangeNotifier {
  List<Knowledge> _knowledges = [];
  List<FileData> _currentFiles = [];
  List<FileData> get files {
    return _currentFiles;
  }

  List<Knowledge> get knowledges {
    return _knowledges;
  }

  final String accessToken;

  KnowledgeProvider({required this.accessToken});
  Future<void> getKnowledges() async {
    try {
      final response = await http.get(
        Uri.parse(API.getKnowledge),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );
      final responseData = json.decode(response.body) as Map<String, dynamic>;
      if (response.statusCode != 200) {
        throw Exception('${responseData['detail']}');
      }
      final List<dynamic> listKnowledge = responseData["knowledges"];
      _knowledges =
          listKnowledge.map((json) => Knowledge.fromJson(json)).toList();
      print(_knowledges);
      notifyListeners();
    } catch (error) {
      throw Exception('Failed to load knowledges: $error');
    }
  }

  Future<Map<String, dynamic>> createKnowledge(
      String name, String description) async {
    try {
      final response = await http.post(
        Uri.parse(API.knowledges),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
        body: jsonEncode({
          "name": name,
          "description": description,
        }),
      );
      final Map<String, dynamic> data = jsonDecode(response.body);
      if (response.statusCode == 201) {
        _knowledges.add(Knowledge.fromJson(data));
        notifyListeners();
      }
      if (response.statusCode == 422) {
        throw Exception(data['detail'][0].msg);
      }
      throw Exception(data['detail']);
    } catch (error) {
      throw Exception('Failed to create knowledge: $error');
    }
  }

  Future<void> updateKnowledge(
      String knowledgeId, String name, String description) async {
    try {
      final response = await http.put(
        Uri.parse('${API.knowledges}/$knowledgeId'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
        body: jsonEncode({
          "name": name,
          "description": description,
        }),
      );
      final Map<String, dynamic> data = jsonDecode(response.body);
      if (response.statusCode != 200) {
        throw Exception(data['detail']);
      } else {
        Knowledge updatedKnowledgeData = Knowledge.fromJson(data);
        _knowledges = _knowledges.map((knowledge) {
          return knowledge.knowledgeId == updatedKnowledgeData.knowledgeId
              ? updatedKnowledgeData
              : knowledge;
        }).toList();
      }
      notifyListeners();
    } catch (error) {
      throw Exception('Failed to update knowledge: $error');
    }
  }

  Future<void> deleteKnowledge(String knowledgeId) async {
    try {
      final response = await http.delete(
        Uri.parse('${API.knowledges}/$knowledgeId'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
      );
      if (response.statusCode != 204) {
        throw Exception('Error: ${response.statusCode}');
      } else {
        _knowledges = _knowledges
            .where((knowledge) => knowledge.knowledgeId != knowledgeId)
            .toList();
        notifyListeners();
      }
    } catch (error) {
      throw Exception('Failed to delete knowledge: $error');
    }
  }

  // file
  Future<String> addFileToKnowledge(
      List<File> files, String knowledgeId) async {
    try {
      final uri = Uri.parse('${API.knowledges}/$knowledgeId/files');
      final request = http.MultipartRequest('POST', uri)
        ..headers['Authorization'] = 'Bearer $accessToken';

      for (var file in files) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'files',
            file.path,
          ),
        );
      }
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode != 201) {
        throw Exception('ERROR: ${response.statusCode}');
      }
      print("suceessful");
      return "SUCCESSFUL";
    } catch (error) {
      throw Exception('Failed to add files: $error');
    }
  }

  Future<void> getFilesKnowledge(String knowledgeId) async {
    try {
      final uri = Uri.parse('${API.knowledges}/$knowledgeId');
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
      final decodedResponse = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> data = json.decode(decodedResponse);
      final List<dynamic> listFiles = data["files"];
      print(listFiles);
      _currentFiles = listFiles.map((json) => FileData.fromJson(json)).toList();
      notifyListeners();
    } catch (error) {
      throw Exception('Failed to load files knowledge: $error');
    }
  }
}
