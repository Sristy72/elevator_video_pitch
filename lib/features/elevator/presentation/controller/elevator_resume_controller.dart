import 'dart:convert';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:http/http.dart' as http;
import '../../../../core/network/constants/api_constants.dart';
import '../../data/models/language_model.dart';
import '../../domain/usecases/get_languages_usecase.dart';
import '../../domain/usecases/create_resume_usecase.dart';
import '../../data/models/create_resume_request.dart';

class ElevatorResumeController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  final GetLanguagesUseCase? _getLanguagesUseCase;
  final CreateResumeUseCase? _createResumeUseCase;

  /// ================== TEXT CONTROLLERS ==================
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final linkedinController = TextEditingController();
  final twitterController = TextEditingController();
  final facebookController = TextEditingController();
  final tiktokController = TextEditingController();
  final instagramController = TextEditingController();
  final upworkController = TextEditingController();
  final fiverrController = TextEditingController();
  final portfolioController = TextEditingController();
  final certificationController = TextEditingController();
  final languageController = TextEditingController();

  /// ================== SUBMISSION STATE ==================
  var isSubmitting = false.obs;

  /// ================== ABOUT ME (QUILL) ==================
  late final quill.QuillController aboutMeQuillController;
  var aboutMeWordCount = 0.obs;

  /// ================== SELECTED VALUES ==================
  var selectedTitle = 'Mr.'.obs;
  var selectedCountry = Rx<String?>(null);
  var selectedCity = Rx<String?>(null);

  var selectedJobTitle = Rx<String?>(null);
  var selectedStartMonth = Rx<String?>(null);
  var selectedStartYear = Rx<String?>(null);
  var selectedEndMonth = Rx<String?>(null);
  var selectedEndYear = Rx<String?>(null);
  var selectedAvailability = Rx<String?>(null);
  var selectedJobCategory = Rx<String?>(null);
  var selectedDegree = Rx<String?>(null);
  var selectedGradMonth = Rx<String?>(null);
  var selectedGradYear = Rx<String?>(null);

  /// Immediately Available checkbox
  var immediatelyAvailable = false.obs;

  /// ================== FILE PATHS ==================
  var elevatorVideoPath = Rx<String?>(null);
  var photoPath = Rx<String?>(null);
  var bannerImagePath = Rx<String?>(null);

  /// ================== DYNAMIC LISTS ==================
  var experienceList = <Map<String, dynamic>>[].obs;

  var educationList = <Map<String, dynamic>>[
    {
      'institutionName': '',
      'qualification': null,
      'fieldOfStudy': '',
      'country': null,
      'city': null,
      'currentlyStudying': false,
      'startDate': '',
      'graduationDate': '',
    },
  ].obs;

  var awardsList = <Map<String, dynamic>>[].obs;

  /// Skills chips
  var skillsList = <String>[].obs;

  /// Other custom URLs
  var otherUrlsList = <String>[].obs;

  /// Certifications list
  var certifications = <String>[].obs;

  /// Languages list
  var languages = <String>[].obs;

  /// Languages from API
  var availableLanguages = <LanguageModel>[].obs;
  var isLoadingLanguages = false.obs;
  var languageSearchQuery = ''.obs;

  /// Countries and Cities from API
  var countries = <String>[].obs;
  var cities = <String>[].obs;
  var isLoadingCountries = false.obs;
  Map<String, List<String>> countryCityMap = {};

  /// ================== DUMMY DATA ==================
  final List<String> titles = ['Mr.', 'Mrs.', 'Ms.', 'Dr.'];

  ElevatorResumeController({
    GetLanguagesUseCase? getLanguagesUseCase,
    CreateResumeUseCase? createResumeUseCase,
  }) : _getLanguagesUseCase = getLanguagesUseCase,
       _createResumeUseCase = createResumeUseCase;

  final List<String> jobTitles = [
    'Software Engineer',
    'Product Manager',
    'Designer',
    'Data Scientist',
    'Marketing Manager',
    'Sales Executive',
    'HR Manager',
    'Business Analyst',
  ];

  final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  final List<String> years = List.generate(
    50,
    (index) => (DateTime.now().year - index).toString(),
  );

  final List<String> availabilities = [
    'Immediately',
    'Within 2 weeks',
    'Within 1 month',
    'Within 2 months',
    'Within 3 months',
  ];

  final List<String> jobCategories = [
    'Technology',
    'Healthcare',
    'Finance',
    'Education',
    'Marketing',
    'Sales',
    'Human Resources',
    'Design',
    'Engineering',
  ];

  final List<String> degrees = [
    'High School',
    'Associate Degree',
    'Bachelor\'s Degree',
    'Master\'s Degree',
    'Doctorate',
    'Professional Certificate',
  ];

  final List<String> qualifications = [
    'High School Diploma',
    'Associate Degree',
    'Bachelor\'s Degree',
    'Master\'s Degree',
    'Doctorate (PhD)',
    'Professional Certificate',
    'Diploma',
    'Other',
  ];

  /// ================== LIFECYCLE ==================
  @override
  void onInit() {
    super.onInit();

    aboutMeQuillController = quill.QuillController.basic();
    aboutMeQuillController.addListener(_updateWordCountFromQuill);

    // Fetch languages from API
    fetchLanguages();

    // Fetch countries from API
    fetchCountries();
  }

  void _updateWordCountFromQuill() {
    final plain = aboutMeQuillController.document.toPlainText().trim();
    if (plain.isEmpty) {
      aboutMeWordCount.value = 0;
    } else {
      aboutMeWordCount.value = plain
          .split(RegExp(r'\s+'))
          .where((w) => w.isNotEmpty)
          .length;
    }
  }

  @override
  void onClose() {
    aboutMeQuillController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    linkedinController.dispose();
    twitterController.dispose();
    facebookController.dispose();
    tiktokController.dispose();
    instagramController.dispose();
    upworkController.dispose();
    fiverrController.dispose();
    portfolioController.dispose();
    certificationController.dispose();
    languageController.dispose();
    super.onClose();
  }

  /// ================== PICKERS ==================
  Future<void> pickElevatorVideo() async {
    try {
      final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
      if (video != null) {
        elevatorVideoPath.value = video.path;
        Get.snackbar('Success', 'Video selected successfully');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick video: $e');
    }
  }

  Future<void> pickPhoto() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        photoPath.value = image.path;
        Get.snackbar('Success', 'Photo selected successfully');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick photo: $e');
    }
  }

  Future<void> pickBannerImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        bannerImagePath.value = image.path;
        Get.snackbar('Success', 'Banner image selected successfully');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick banner image: $e');
    }
  }

  /// ================== DROPDOWN HELPERS ==================
  void onCountryChanged(String? value) {
    selectedCountry.value = value;
    selectedCity.value = null; // Reset city when country changes
    if (value != null) {
      cities.value = countryCityMap[value] ?? [];
      print('🌍 Loaded ${cities.length} cities for $value');
    } else {
      cities.clear();
    }
  }

  /// ================== API CALLS ==================
  Future<void> fetchCountries() async {
    try {
      isLoadingCountries.value = true;
      print('🌐 Fetching countries from API...');

      final response = await http.get(
        Uri.parse(ApiConstants.country.getCountries),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('✅ Countries API response: ${response.statusCode}');

        countryCityMap.clear();
        for (var country in data['data']) {
          if (country['cities'] != null &&
              (country['cities'] as List).isNotEmpty) {
            countryCityMap[country['country']] = List<String>.from(
              country['cities'],
            );
          }
        }

        countries.value = countryCityMap.keys.toList();
        print('✅ Loaded ${countries.length} countries from API');
        isLoadingCountries.value = false;
      } else {
        print('❌ Failed to load countries: ${response.statusCode}');
        isLoadingCountries.value = false;
        Get.snackbar(
          'Error',
          'Failed to load countries',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      print('❌ Exception fetching countries: $e');
      isLoadingCountries.value = false;
      Get.snackbar(
        'Error',
        'Failed to load countries: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  /// ================== EXPERIENCE / EDUCATION / AWARDS ==================
  void addExperience() {
    experienceList.add({
      'presentlyWorkHere': false,
      'country': null,
      'city': null,
      // 'jobTitle': '',
      // 'companyName': '',
      // 'startDate': '',
      // 'endDate': '',
      // 'description': '',
    });
  }

  void addEducation() {
    educationList.add({
      'institutionName': '',
      'qualification': null,
      'fieldOfStudy': '',
      'country': null,
      'city': null,
      'currentlyStudying': false,
      'startDate': '',
      'graduationDate': '',
    });
  }

  void updateEducationField(int index, String field, dynamic value) {
    educationList[index][field] = value;
    educationList.refresh();
  }

  void addAward() {
    awardsList.add({
      'awardTitle': '',
      'programName': '',
      'programDate': '',
      'description': '',
    });
  }

  void updateAwardField(int index, String field, dynamic value) {
    awardsList[index][field] = value;
    awardsList.refresh();
  }

  void removeExperience(int index) {
    if (experienceList.length > 1) {
      experienceList.removeAt(index);
    }
  }

  void removeEducation(int index) {
    educationList.removeAt(index);
  }

  void removeAward(int index) {
    awardsList.removeAt(index);
  }

  void togglePresentlyWorkHere(int index) {
    experienceList[index]['presentlyWorkHere'] =
        !(experienceList[index]['presentlyWorkHere'] ?? false);
    experienceList.refresh();
  }

  void togglePresentlyAttendHere(int index) {
    educationList[index]['presentlyAttendHere'] =
        !(educationList[index]['presentlyAttendHere'] ?? false);
    educationList.refresh();
  }

  void toggleCurrentlyStudying(int index) {
    educationList[index]['currentlyStudying'] =
        !(educationList[index]['currentlyStudying'] ?? false);
    educationList.refresh();
  }

  /// ================== SKILLS ==================
  void addSkill(String skill) {
    final s = skill.trim();
    if (s.isNotEmpty && !skillsList.contains(s)) {
      skillsList.add(s);
    }
  }

  void removeSkill(int index) {
    skillsList.removeAt(index);
  }

  /// ================== OTHER URLS ==================
  void addOtherUrl() {
    otherUrlsList.add('');
  }

  void removeOtherUrl(int index) {
    if (otherUrlsList.isNotEmpty) {
      otherUrlsList.removeAt(index);
    }
  }

  /// ================== CERTIFICATIONS ==================
  void addCertification() {
    final text = certificationController.text.trim();
    if (text.isNotEmpty && !certifications.contains(text)) {
      certifications.add(text);
      certificationController.clear();
    }
  }

  void removeCertification(String cert) {
    certifications.remove(cert);
  }

  /// ================== LANGUAGES ==================
  Future<void> fetchLanguages() async {
    if (_getLanguagesUseCase == null) {
      print('❌ GetLanguagesUseCase is null - not registered in DI');
      return;
    }

    print('🔄 Starting to fetch languages...');
    isLoadingLanguages.value = true;

    try {
      final result = await _getLanguagesUseCase.call();

      result.fold(
        (failure) {
          print('❌ Language API failed: ${failure.message}');
          isLoadingLanguages.value = false;
          Get.snackbar(
            'Error',
            'Failed to load languages: ${failure.message}',
            snackPosition: SnackPosition.BOTTOM,
          );
        },
        (success) {
          print(
            '✅ Language API success: ${success.data.data.length} languages loaded',
          );
          print(
            '📋 First 5 languages: ${success.data.data.take(5).map((e) => e.name).join(", ")}',
          );
          isLoadingLanguages.value = false;
          availableLanguages.value = success.data.data;
        },
      );
    } catch (e) {
      print('❌ Exception fetching languages: $e');
      isLoadingLanguages.value = false;
      Get.snackbar(
        'Error',
        'Failed to load languages: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  List<LanguageModel> get filteredLanguages {
    print(
      '🔍 Filtering languages: query="${languageSearchQuery.value}", available=${availableLanguages.length}',
    );
    if (languageSearchQuery.value.isEmpty) {
      return availableLanguages;
    }
    final filtered = availableLanguages.where((lang) {
      return lang.name.toLowerCase().contains(
        languageSearchQuery.value.toLowerCase(),
      );
    }).toList();
    print(
      '🔍 Filtered results: ${filtered.length} languages match "${languageSearchQuery.value}"',
    );
    return filtered;
  }

  void addLanguage(String lang) {
    final l = lang.trim();
    // Support direct add via controller if argument is empty
    if (l.isEmpty && languageController.text.isNotEmpty) {
      final fromController = languageController.text.trim();
      if (fromController.isNotEmpty && !languages.contains(fromController)) {
        languages.add(fromController);
        languageController.clear();
      }
      return;
    }

    if (l.isNotEmpty && !languages.contains(l)) {
      languages.add(l);
    }
  }

  void removeLanguage(String lang) {
    languages.remove(lang);
  }

  /// ================== SUBMIT / SAVE ==================
  Future<void> saveResume() async {
    if (_createResumeUseCase == null) {
      print('❌ CreateResumeUseCase is null - not registered in DI');
      Get.snackbar('Error', 'Resume service not available');
      return;
    }

    // Validation
    if (firstNameController.text.trim().isEmpty) {
      Get.snackbar('Validation Error', 'Please enter your first name');
      return;
    }
    if (lastNameController.text.trim().isEmpty) {
      Get.snackbar('Validation Error', 'Please enter your last name');
      return;
    }
    if (emailController.text.trim().isEmpty) {
      Get.snackbar('Validation Error', 'Please enter your email');
      return;
    }
    if (phoneNumberController.text.trim().isEmpty) {
      Get.snackbar('Validation Error', 'Please enter your phone number');
      return;
    }

    try {
      isSubmitting.value = true;

      // Prepare social links
      final socialLinks = <SocialLink>[];
      if (linkedinController.text.trim().isNotEmpty) {
        socialLinks.add(
          SocialLink(platform: 'LinkedIn', url: linkedinController.text.trim()),
        );
      }
      if (twitterController.text.trim().isNotEmpty) {
        socialLinks.add(
          SocialLink(platform: 'Twitter', url: twitterController.text.trim()),
        );
      }
      if (facebookController.text.trim().isNotEmpty) {
        socialLinks.add(
          SocialLink(platform: 'Facebook', url: facebookController.text.trim()),
        );
      }
      if (tiktokController.text.trim().isNotEmpty) {
        socialLinks.add(
          SocialLink(platform: 'TikTok', url: tiktokController.text.trim()),
        );
      }
      if (instagramController.text.trim().isNotEmpty) {
        socialLinks.add(
          SocialLink(
            platform: 'Instagram',
            url: instagramController.text.trim(),
          ),
        );
      }
      if (upworkController.text.trim().isNotEmpty) {
        socialLinks.add(
          SocialLink(platform: 'Upwork', url: upworkController.text.trim()),
        );
      }
      if (fiverrController.text.trim().isNotEmpty) {
        socialLinks.add(
          SocialLink(platform: 'Fiverr', url: fiverrController.text.trim()),
        );
      }
      if (portfolioController.text.trim().isNotEmpty) {
        socialLinks.add(
          SocialLink(
            platform: 'Portfolio',
            url: portfolioController.text.trim(),
          ),
        );
      }

      // Prepare experiences
      final experiences = experienceList
          .where(
            (exp) =>
                exp['companyName'] != null &&
                exp['companyName'].toString().trim().isNotEmpty,
          )
          .map(
            (exp) => ExperienceRequest(
              company: exp['companyName'] ?? '',
              position: exp['jobTitle'] ?? '',
              country: exp['country'],
              city: exp['city'],
              startDate: exp['startDate'],
              endDate: exp['endDate'],
              currentlyWorking: exp['currentlyWorking'],
              description: exp['description'],
            ),
          )
          .toList();

      // Prepare education
      final education = educationList
          .where(
            (edu) =>
                edu['institutionName'] != null &&
                edu['institutionName'].toString().trim().isNotEmpty,
          )
          .map(
            (edu) => EducationRequest(
              institutionName: edu['institutionName'] ?? '',
              qualification: edu['qualification'],
              fieldOfStudy: edu['fieldOfStudy'],
              country: edu['country'],
              city: edu['city'],
              currentlyStudying: edu['currentlyStudying'],
              startDate: edu['startDate'],
              graduationDate: edu['graduationDate'],
            ),
          )
          .toList();

      // Prepare awards
      final awards = awardsList
          .where(
            (award) =>
                award['title'] != null &&
                award['title'].toString().trim().isNotEmpty,
          )
          .map(
            (award) => AwardRequest(
              title: award['title'] ?? '',
              description: award['description'],
              date: award['date'],
            ),
          )
          .toList();

      // Get about me text
      final aboutMe = aboutMeQuillController.document.toPlainText().trim();

      // Create request
      final request = CreateResumeRequest(
        photo: photoPath.value,
        banner: bannerImagePath.value,
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        email: emailController.text.trim(),
        phoneNumber: phoneNumberController.text.trim(),
        country: selectedCountry.value,
        city: selectedCity.value,
        immediatelyAvailable: immediatelyAvailable.value,
        certifications: certifications.toList(),
        languages: languages.toList(),
        skills: skillsList.toList(),
        sLink: socialLinks,
        experiences: experiences,
        education: education,
        awardsAndHonors: awards,
        aboutMe: aboutMe.isNotEmpty ? aboutMe : null,
      );

      print('📤 Submitting resume...');
      final result = await _createResumeUseCase(request);

      result.fold(
        (failure) {
          print('❌ Resume creation failed: ${failure.message}');
          isSubmitting.value = false;
          Get.snackbar(
            'Error',
            failure.message,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        },
        (success) {
          print('✅ Resume created successfully!');
          isSubmitting.value = false;
          Get.snackbar(
            'Success',
            success.data.message,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          // You can navigate to another screen or perform other actions here
        },
      );
    } catch (e) {
      print('❌ Exception creating resume: $e');
      isSubmitting.value = false;
      Get.snackbar(
        'Error',
        'Failed to create resume: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void onUploadElevatorPitchFirst() {
    if (elevatorVideoPath.value == null) {
      Get.snackbar(
        'Upload required',
        'Please upload your Elevator Video Pitch before submitting the form.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    saveResume();
  }
}
