class CreateResumeResponse {
  final bool success;
  final String message;
  final ResumeData? data;

  CreateResumeResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory CreateResumeResponse.fromJson(Map<String, dynamic> json) {
    return CreateResumeResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? ResumeData.fromJson(json['data']) : null,
    );
  }
}

class ResumeData {
  final Resume resume;
  final List<Experience> experiences;
  final List<Education> education;
  final List<Award> awardsAndHonors;

  ResumeData({
    required this.resume,
    required this.experiences,
    required this.education,
    required this.awardsAndHonors,
  });

  factory ResumeData.fromJson(Map<String, dynamic> json) {
    return ResumeData(
      resume: Resume.fromJson(json['resume']),
      experiences:
          (json['experiences'] as List?)
              ?.map((e) => Experience.fromJson(e))
              .toList() ??
          [],
      education:
          (json['education'] as List?)
              ?.map((e) => Education.fromJson(e))
              .toList() ??
          [],
      awardsAndHonors:
          (json['awardsAndHonors'] as List?)
              ?.map((e) => Award.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class Resume {
  final String id;
  final String userId;
  final String type;
  final String? photo;
  final String? banner;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final List<String> certifications;
  final List<String> languages;
  final List<String> skills;
  final List<dynamic> sLink;
  final String createdAt;
  final String updatedAt;

  Resume({
    required this.id,
    required this.userId,
    required this.type,
    this.photo,
    this.banner,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.certifications,
    required this.languages,
    required this.skills,
    required this.sLink,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Resume.fromJson(Map<String, dynamic> json) {
    return Resume(
      id: json['_id'] ?? '',
      userId: json['userId'] ?? '',
      type: json['type'] ?? '',
      photo: json['photo'],
      banner: json['banner'],
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      certifications: List<String>.from(json['certifications'] ?? []),
      languages: List<String>.from(json['languages'] ?? []),
      skills: List<String>.from(json['skills'] ?? []),
      sLink: json['sLink'] ?? [],
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}

class Experience {
  final String id;
  final String userId;
  final String company;
  final String position;
  final String createdAt;
  final String updatedAt;

  Experience({
    required this.id,
    required this.userId,
    required this.company,
    required this.position,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Experience.fromJson(Map<String, dynamic> json) {
    return Experience(
      id: json['_id'] ?? '',
      userId: json['userId'] ?? '',
      company: json['company'] ?? '',
      position: json['position'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}

class Education {
  final String id;
  final String userId;
  final String degree;
  final String createdAt;
  final String updatedAt;

  Education({
    required this.id,
    required this.userId,
    required this.degree,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      id: json['_id'] ?? '',
      userId: json['userId'] ?? '',
      degree: json['degree'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}

class Award {
  final String id;
  final String userId;
  final String title;
  final String createdAt;
  final String updatedAt;

  Award({
    required this.id,
    required this.userId,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Award.fromJson(Map<String, dynamic> json) {
    return Award(
      id: json['_id'] ?? '',
      userId: json['userId'] ?? '',
      title: json['title'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}
