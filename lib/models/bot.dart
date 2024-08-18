class Bot {
  final String? createdAt;
  final String? updatedAt;
  final String? botId;
  final String? name;
  final String? avatar;
  final String? description;
  final bool? isActive;
  final String? personaPrompt;
  final bool? isMemoryEnabled;

  Bot({
    this.createdAt,
    this.updatedAt,
    this.botId,
    this.name,
    this.avatar,
    this.description,
    this.isActive,
    this.personaPrompt,
    this.isMemoryEnabled,
  });
  factory Bot.fromJson(Map<String, dynamic> json) {
    return Bot(
      createdAt: json['created_at'] as String? ?? '',
      updatedAt: json['updated_at'] as String? ?? '',
      botId: json['bot_id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      avatar: json['avatar'] as String? ?? '',
      description: json['description'] as String? ?? '',
      isActive: json['is_active'] as bool? ?? false,
      personaPrompt: json['persona_prompt'] as String? ?? '',
      isMemoryEnabled: json['is_memory_enabled'] as bool? ?? false,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'created_at': createdAt,
      'updated_at': updatedAt,
      'bot_id': botId,
      'name': name,
      'avatar': avatar,
      'description': description,
      'is_active': isActive,
      'persona_prompt': personaPrompt,
      'is_memory_enabled': isMemoryEnabled,
    };
  }
}
