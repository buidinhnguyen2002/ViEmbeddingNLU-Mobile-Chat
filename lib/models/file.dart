class FileData {
  final String? createdAt;
  final String? updatedAt;
  final String? fileId;
  final String? name;
  final String? fileType;
  final double? size;
  final String? url;
  final bool? isActive;
  final int? chunkCount;
  final double? timeImport;
  final int? pageCount;

  FileData({
    this.createdAt,
    this.updatedAt,
    this.fileId,
    this.name,
    this.fileType,
    this.size,
    this.url,
    this.isActive,
    this.chunkCount,
    this.timeImport,
    this.pageCount,
  });

  // Phương thức để tạo một đối tượng FileData từ JSON
  factory FileData.fromJson(Map<String, dynamic> json) {
    return FileData(
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      fileId: json['file_id'],
      name: json['name'],
      fileType: json['file_type'],
      size: (json['size'] is int)
          ? (json['size'] as int).toDouble()
          : json['size'],
      url: json['url'],
      isActive: json['is_active'],
      chunkCount: json['chunk_count'],
      timeImport: json['time_import'],
      pageCount: json['page_count'],
    );
  }

  // Phương thức để chuyển đổi đối tượng FileData thành JSON
  Map<String, dynamic> toJson() {
    return {
      'created_at': createdAt,
      'updated_at': updatedAt,
      'file_id': fileId,
      'name': name,
      'file_type': fileType,
      'size': size,
      'url': url,
      'is_active': isActive,
      'chunk_count': chunkCount,
      'time_import': timeImport,
      'page_count': pageCount,
    };
  }
}
