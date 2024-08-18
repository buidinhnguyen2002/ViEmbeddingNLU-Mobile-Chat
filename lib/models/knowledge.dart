import 'package:flutter/foundation.dart';

class Knowledge {
  final String? createdAt;
  final String? updatedAt;
  final String? knowledgeId;
  final String? name;
  final String? description;

  Knowledge({
    this.createdAt,
    this.updatedAt,
    this.knowledgeId,
    this.name,
    this.description,
  });
  factory Knowledge.fromJson(Map<String, dynamic> json) {
    return Knowledge(
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      knowledgeId: json['knowledge_id'],
      name: json['name'],
      description: json['description'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'created_at': createdAt,
      'updated_at': updatedAt,
      'knowledge_id': knowledgeId,
      'name': name,
      'description': description,
    };
  }
}
