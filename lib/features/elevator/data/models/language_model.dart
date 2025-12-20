class LanguageResponse {
  final String status;
  final List<LanguageModel> data;

  LanguageResponse({required this.status, required this.data});

  factory LanguageResponse.fromJson(Map<String, dynamic> json) {
    return LanguageResponse(
      status: json['status'] ?? '',
      data:
          (json['data'] as List<dynamic>?)
              ?.where((e) => e != null && e is Map<String, dynamic>)
              .map((e) => LanguageModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'data': data.map((e) => e.toJson()).toList()};
  }
}

class LanguageModel {
  final String id;
  final String name;
  final String? nativeName;
  final String direction;
  final String sourceFile;
  final String createdAt;
  final String updatedAt;
  final int v;

  LanguageModel({
    required this.id,
    required this.name,
    this.nativeName,
    required this.direction,
    required this.sourceFile,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory LanguageModel.fromJson(Map<String, dynamic> json) {
    try {
      return LanguageModel(
        id: json['_id']?.toString() ?? '',
        name: json['name']?.toString() ?? '',
        nativeName: json['nativeName']?.toString(),
        direction: json['direction']?.toString() ?? 'ltr',
        sourceFile: json['sourceFile']?.toString() ?? '',
        createdAt: json['createdAt']?.toString() ?? '',
        updatedAt: json['updatedAt']?.toString() ?? '',
        v: json['__v'] is int ? json['__v'] : 0,
      );
    } catch (e) {
      // If parsing fails, return a default object
      return LanguageModel(
        id: '',
        name: 'Unknown',
        nativeName: null,
        direction: 'ltr',
        sourceFile: '',
        createdAt: '',
        updatedAt: '',
        v: 0,
      );
    }
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'nativeName': nativeName,
      'direction': direction,
      'sourceFile': sourceFile,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
    };
  }
}
