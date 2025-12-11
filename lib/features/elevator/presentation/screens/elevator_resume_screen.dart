import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/common/widgets/app_scaffold.dart';
import '../controller/elevator_resume_controller.dart';
import '../widgets/photo_bio_section.dart';
import '../widgets/experience_form_section.dart';
import '../widgets/education_form_section.dart';
import '../widgets/awards_form_section.dart';
import '../widgets/skills_section.dart';
import '../../domain/usecases/get_languages_usecase.dart';
import '../../domain/usecases/create_resume_usecase.dart';

class ElevatorResumeScreen extends StatelessWidget {
  const ElevatorResumeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      ElevatorResumeController(
        getLanguagesUseCase: Get.isRegistered<GetLanguagesUseCase>()
            ? Get.find<GetLanguagesUseCase>()
            : null,
        createResumeUseCase: Get.isRegistered<CreateResumeUseCase>()
            ? Get.find<CreateResumeUseCase>()
            : null,
      ),
    );
    final theme = Theme.of(context);

    return AppScaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Create Your Profile',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===================== TITLE + SUBTITLE =====================
              Center(
                child: Text(
                  'Fill in your details to create a professional resume',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[700],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // ===================== VIDEO + BANNER =====================
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // ---------- Upload Video Pitch (dark card) ----------
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0E1726),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: DottedBorder(
                      color: const Color(0xFF2C3A4F),
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(12),
                      dashPattern: const [6, 4],
                      strokeWidth: 1.2,
                      child: InkWell(
                        onTap: controller.pickElevatorVideo,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // blue circular icon
                              Container(
                                width: 48,
                                height: 48,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF2563EB),
                                ),
                                child: const Icon(
                                  Icons.file_upload_outlined,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                'Upload Your Video Pitch',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Drop your video here or click to browse',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.7),
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: controller.pickElevatorVideo,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF2563EB),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 12,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(999),
                                  ),
                                ),
                                child: const Text(
                                  'Choose Video File',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ---------- Banner upload (light dashed card) ----------
                  Obx(
                    () => controller.bannerImagePath.value != null
                        ? Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(
                                  File(controller.bannerImagePath.value!),
                                  width: double.infinity,
                                  height: 150,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: IconButton(
                                        icon: const Icon(
                                          Icons.edit,
                                          color: Colors.black,
                                          size: 20,
                                        ),
                                        onPressed: controller.pickBannerImage,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: IconButton(
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                          size: 20,
                                        ),
                                        onPressed: () {
                                          controller.bannerImagePath.value =
                                              null;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : DottedBorder(
                            color: Colors.grey.shade400,
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(12),
                            dashPattern: const [6, 4],
                            strokeWidth: 1,
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                vertical: 24,
                                horizontal: 12,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.cloud_upload_outlined,
                                    size: 32,
                                    color: Colors.grey.shade500,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Drop your banner image here',
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: Colors.grey.shade800,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  OutlinedButton(
                                    onPressed: controller.pickBannerImage,
                                    style: OutlinedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 24,
                                        vertical: 10,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: const Text(
                                      'Choose Image',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Supports JPG, PNG · Max 10MB · Cropped to 1584×396 px',
                                    textAlign: TextAlign.center,
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // ===================== PROFILE PHOTO + ABOUT ME =====================
              _SectionCard(child: const PhotoBioSection()),

              const SizedBox(height: 24),

              // ===================== PERSONAL INFO =====================
              Text(
                'Personal Information',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 12),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // First Name
                  _LabeledTextField(
                    label: 'First Name*',
                    hint: 'Enter your first name',
                    controller: controller.firstNameController,
                  ),
                  const SizedBox(height: 12),

                  // Surname
                  _LabeledTextField(
                    label: 'Surname*',
                    hint: 'Enter your surname',
                    controller: controller.lastNameController,
                  ),
                  const SizedBox(height: 12),

                  // Country
                  const Text('Country*'),
                  const SizedBox(height: 6),
                  Obx(
                    () => controller.isLoadingCountries.value
                        ? const Center(
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : DropdownButtonFormField<String>(
                            isExpanded: true,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            menuMaxHeight:
                                MediaQuery.of(context).size.height * 0.5,
                            value: controller.selectedCountry.value,
                            hint: const Text('Select Country'),
                            items: controller.countries
                                .map(
                                  (country) => DropdownMenuItem(
                                    value: country,
                                    child: Text(country),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              controller.selectedCountry.value = value;
                              controller.onCountryChanged(value);
                            },
                          ),
                  ),
                  const SizedBox(height: 12),

                  // City
                  const Text('City*'),
                  const SizedBox(height: 6),
                  Obx(
                    () => DropdownButtonFormField<String>(
                      isExpanded: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      menuMaxHeight: MediaQuery.of(context).size.height * 0.5,
                      value: controller.selectedCity.value,
                      hint: const Text('Select City'),
                      items: controller.cities
                          .map(
                            (city) => DropdownMenuItem(
                              value: city,
                              child: Text(city),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        controller.selectedCity.value = value;
                      },
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Email (disabled style like screenshot)
                  _LabeledTextField(
                    label: 'Email Address*',
                    hint: 'Enter your email',
                    keyboardType: TextInputType.emailAddress,
                    enabled: true, // screenshot-e readonly, chai le false koro
                    controller: controller.emailController,
                  ),
                  const SizedBox(height: 12),

                  // Phone Number
                  _LabeledTextField(
                    label: 'Phone Number*',
                    hint: 'Enter your phone number',
                    keyboardType: TextInputType.phone,
                    controller: controller.phoneNumberController,
                  ),
                  const SizedBox(height: 12),

                  // Immediately Available checkbox
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                        () => Checkbox(
                          value: controller.immediatelyAvailable.value,
                          onChanged: (value) {
                            controller.immediatelyAvailable.value =
                                value ?? false;
                          },
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Immediately Available'),
                            const SizedBox(height: 2),
                            Text(
                              'Check if you are available to start immediately',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // ===================== PROFESSIONAL LINKS =====================
              _SectionCard(
                title: 'Professional Social Media and Website Links',
                child: Column(
                  children: [
                    _LabeledTextField(
                      label: 'LinkedIn URL',
                      hint: 'https://www.linkedin.com/your-profile',
                      controller: controller.linkedinController,
                    ),
                    const SizedBox(height: 12),
                    _LabeledTextField(
                      label: 'Twitter URL',
                      hint: 'https://www.twitter.com/your-profile',
                      controller: controller.twitterController,
                    ),
                    const SizedBox(height: 12),
                    _LabeledTextField(
                      label: 'Facebook URL',
                      hint: 'https://facebook.com/your-profile',
                      controller: controller.facebookController,
                    ),
                    const SizedBox(height: 12),
                    _LabeledTextField(
                      label: 'TikTok URL',
                      hint: 'https://www.tiktok.com/@your-handle',
                      controller: controller.tiktokController,
                    ),
                    const SizedBox(height: 12),
                    _LabeledTextField(
                      label: 'Instagram URL',
                      hint: 'https://www.instagram.com/your-profile',
                      controller: controller.instagramController,
                    ),
                    const SizedBox(height: 12),
                    _LabeledTextField(
                      label: 'Upwork URL',
                      hint: 'https://www.upwork.com/your-profile',
                      controller: controller.upworkController,
                    ),
                    const SizedBox(height: 12),
                    _LabeledTextField(
                      label: 'Fiverr URL',
                      hint: 'https://www.fiverr.com/your-username',
                      controller: controller.fiverrController,
                    ),
                    const SizedBox(height: 12),
                    _LabeledTextField(
                      label: 'Portfolio Website URL',
                      hint: 'https://your-website.com',
                      controller: controller.portfolioController,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ===================== SKILLS =====================
              Text(
                'Skills',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Showcase your strengths and what sets you apart.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 12),
              _SectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [SkillsSection()],
                ),
              ),

              const SizedBox(height: 24),

              // ===================== WORK EXPERIENCE =====================
              Text(
                'Work Experience',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),

              Obx(() {
                if (controller.experienceList.isEmpty) {
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: controller.addExperience,
                      child: const Text('Add'),
                    ),
                  );
                }

                return Column(
                  children: [
                    ...List.generate(
                      controller.experienceList.length,
                      (index) => Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: _SectionCard(
                          child: ExperienceFormSection(index: index),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: controller.addExperience,
                        child: const Text('Add'),
                      ),
                    ),
                  ],
                );
              }),

              const SizedBox(height: 24),

              // ===================== EDUCATION =====================
              Text(
                'Education*',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Obx(() {
                return Column(
                  children: [
                    ...List.generate(
                      controller.educationList.length,
                      (index) => Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: EducationFormSection(index: index),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: controller.addEducation,
                        child: const Text('Add'),
                      ),
                    ),
                  ],
                );
              }),

              const SizedBox(height: 24),

              // ===================== CERTIFICATIONS =====================
              _SectionCard(
                title: 'Certifications',
                subtitle:
                    'List your professional certifications and credentials.',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Add Certification',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: controller.certificationController,
                            decoration: const InputDecoration(
                              hintText:
                                  'e.g. AWS Certified Solutions Architect',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 12,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        OutlinedButton(
                          onPressed: controller.addCertification,
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 14,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Add',
                            style: TextStyle(color: Colors.black87),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Obx(
                      () => controller.certifications.isEmpty
                          ? Text(
                              'No certifications added yet. Add your professional certifications above.',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: Colors.grey[600],
                              ),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: controller.certifications
                                  .map(
                                    (cert) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 4.0,
                                      ),
                                      child: Text('• $cert'),
                                    ),
                                  )
                                  .toList(),
                            ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ===================== LANGUAGES =====================
              _SectionCard(
                title: 'Languages',
                subtitle: 'List the languages you speak.',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Add Language',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Obx(() {
                      if (controller.isLoadingLanguages.value) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }

                      return Autocomplete<String>(
                        optionsBuilder: (TextEditingValue textEditingValue) {
                          print(
                            '🔍 Autocomplete optionsBuilder called with: "${textEditingValue.text}"',
                          );
                          print(
                            '🔍 Available languages: ${controller.availableLanguages.length}',
                          );

                          // Update the search query
                          controller.languageSearchQuery.value =
                              textEditingValue.text;

                          // Return filtered results (or all if empty)
                          final results = controller.filteredLanguages
                              .map((lang) => lang.name)
                              .toList();

                          print('🔍 Returning ${results.length} options');
                          return results;
                        },
                        onSelected: (String selection) {
                          print('✅ Language selected: $selection');
                          controller.addLanguage(selection);
                        },
                        fieldViewBuilder:
                            (
                              BuildContext context,
                              TextEditingController textEditingController,
                              FocusNode focusNode,
                              VoidCallback onFieldSubmitted,
                            ) {
                              return TextField(
                                controller: textEditingController,
                                focusNode: focusNode,
                                decoration: const InputDecoration(
                                  hintText:
                                      'Search and add languages (e.g., English, Spanish, French...)',
                                  prefixIcon: Icon(Icons.search),
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 12,
                                  ),
                                ),
                                onSubmitted: (value) {
                                  if (value.isNotEmpty) {
                                    controller.addLanguage(value);
                                    textEditingController.clear();
                                  }
                                },
                              );
                            },
                        optionsViewBuilder:
                            (
                              BuildContext context,
                              AutocompleteOnSelected<String> onSelected,
                              Iterable<String> options,
                            ) {
                              return Align(
                                alignment: Alignment.topLeft,
                                child: Material(
                                  elevation: 4.0,
                                  child: ConstrainedBox(
                                    constraints: const BoxConstraints(
                                      maxHeight: 200,
                                      maxWidth: 400,
                                    ),
                                    child: ListView.builder(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      itemCount: options.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                            final String option = options
                                                .elementAt(index);
                                            return InkWell(
                                              onTap: () => onSelected(option),
                                              child: Padding(
                                                padding: const EdgeInsets.all(
                                                  16.0,
                                                ),
                                                child: Text(option),
                                              ),
                                            );
                                          },
                                    ),
                                  ),
                                ),
                              );
                            },
                      );
                    }),
                    const SizedBox(height: 12),
                    Obx(
                      () => controller.languages.isEmpty
                          ? Text(
                              'No languages selected. Start typing to search and add languages.',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: Colors.grey[600],
                              ),
                            )
                          : Wrap(
                              spacing: 8,
                              runSpacing: 4,
                              children: controller.languages
                                  .map(
                                    (lang) => Chip(
                                      label: Text(lang),
                                      onDeleted: () =>
                                          controller.removeLanguage(lang),
                                    ),
                                  )
                                  .toList(),
                            ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ===================== AWARDS & HONORS =====================
              _SectionCard(
                title: 'Awards & Honors',
                subtitle: 'Highlight your achievements and recognitions.',
                child: Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (controller.awardsList.isEmpty)
                        TextButton(
                          onPressed: controller.addAward,
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                          child: const Text('Add'),
                        )
                      else ...[
                        ...List.generate(
                          controller.awardsList.length,
                          (index) => Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: AwardsFormSection(index: index),
                          ),
                        ),
                        TextButton(
                          onPressed: controller.addAward,
                          child: const Text('Add'),
                        ),
                      ],
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // ===================== SUBMIT BUTTON =====================
              Obx(
                () => SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.isSubmitting.value
                        ? null
                        : controller.onUploadElevatorPitchFirst,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 52),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                      backgroundColor: Colors.blueAccent,
                      disabledBackgroundColor: Colors.grey,
                    ),
                    child: controller.isSubmitting.value
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                        : const Text(
                            'Submit Resume',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Please upload your Elevator Video Pitch© video before submitting the form.',
                style: theme.textTheme.bodySmall?.copyWith(color: Colors.red),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

/// Generic white rounded card
class _SectionCard extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final Widget child;

  const _SectionCard({this.title, this.subtitle, required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Text(
              title!,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 4),
              Text(
                subtitle!,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
            ],
            const SizedBox(height: 12),
          ],
          child,
        ],
      ),
    );
  }
}

/// Simple labeled TextField
class _LabeledTextField extends StatelessWidget {
  final String label;
  final String? hint;
  final TextInputType? keyboardType;
  final bool enabled;
  final String? initialValue;
  final TextEditingController? controller;

  const _LabeledTextField({
    super.key,
    required this.label,
    this.hint,
    this.keyboardType,
    this.enabled = true,
    this.initialValue,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: controller == null ? initialValue : null,
      enabled: enabled,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder(),
        filled: !enabled,
        fillColor: !enabled ? Colors.grey.shade100 : null,
      ),
    );
  }
}
