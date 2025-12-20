class CreateResumeRequest {
  final String? photo;
  final String? banner;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String? country;
  final String? city;
  final bool immediatelyAvailable;
  final List<String> certifications;
  final List<String> languages;
  final List<String> skills;
  final List<SocialLink> sLink;
  final List<ExperienceRequest> experiences;
  final List<EducationRequest> education;
  final List<AwardRequest> awardsAndHonors;
  final String? aboutMe;

  CreateResumeRequest({
    this.photo,
    this.banner,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    this.country,
    this.city,
    this.immediatelyAvailable = false,
    this.certifications = const [],
    this.languages = const [],
    this.skills = const [],
    this.sLink = const [],
    this.experiences = const [],
    this.education = const [],
    this.awardsAndHonors = const [],
    this.aboutMe,
  });

  Map<String, dynamic> toJson() {
    return {
      if (photo != null) 'photo': photo,
      if (banner != null) 'banner': banner,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      if (country != null) 'country': country,
      if (city != null) 'city': city,
      'immediatelyAvailable': immediatelyAvailable,
      'certifications': certifications,
      'languages': languages,
      'skills': skills,
      'sLink': sLink.map((e) => e.toJson()).toList(),
      'experiences': experiences.map((e) => e.toJson()).toList(),
      'education': education.map((e) => e.toJson()).toList(),
      'awardsAndHonors': awardsAndHonors.map((e) => e.toJson()).toList(),
      if (aboutMe != null) 'aboutMe': aboutMe,
    };
  }
}

class SocialLink {
  final String platform;
  final String url;

  SocialLink({required this.platform, required this.url});

  Map<String, dynamic> toJson() {
    return {'platform': platform, 'url': url};
  }
}

class ExperienceRequest {
  final String company;
  final String position;
  final String? country;
  final String? city;
  final String? startDate;
  final String? endDate;
  final bool? currentlyWorking;
  final String? description;

  ExperienceRequest({
    required this.company,
    required this.position,
    this.country,
    this.city,
    this.startDate,
    this.endDate,
    this.currentlyWorking,
    this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'company': company,
      'position': position,
      if (country != null) 'country': country,
      if (city != null) 'city': city,
      if (startDate != null) 'startDate': startDate,
      if (endDate != null) 'endDate': endDate,
      if (currentlyWorking != null) 'currentlyWorking': currentlyWorking,
      if (description != null) 'description': description,
    };
  }
}

class EducationRequest {
  final String institutionName;
  final String? qualification;
  final String? fieldOfStudy;
  final String? country;
  final String? city;
  final bool? currentlyStudying;
  final String? startDate;
  final String? graduationDate;

  EducationRequest({
    required this.institutionName,
    this.qualification,
    this.fieldOfStudy,
    this.country,
    this.city,
    this.currentlyStudying,
    this.startDate,
    this.graduationDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'institutionName': institutionName,
      if (qualification != null) 'qualification': qualification,
      if (fieldOfStudy != null) 'fieldOfStudy': fieldOfStudy,
      if (country != null) 'country': country,
      if (city != null) 'city': city,
      if (currentlyStudying != null) 'currentlyStudying': currentlyStudying,
      if (startDate != null) 'startDate': startDate,
      if (graduationDate != null) 'graduationDate': graduationDate,
    };
  }
}

class AwardRequest {
  final String title;
  final String? description;
  final String? date;

  AwardRequest({required this.title, this.description, this.date});

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      if (description != null) 'description': description,
      if (date != null) 'date': date,
    };
  }
}
