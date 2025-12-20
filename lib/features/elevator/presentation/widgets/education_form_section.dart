import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/elevator_resume_controller.dart';

class EducationFormSection extends StatelessWidget {
  final int index;
  const EducationFormSection({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ElevatorResumeController>();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Institution Name
          const Text(
            'Institution Name*',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              hintText: 'Type your University/College/High School',
              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
              prefixIcon: Icon(Icons.search, color: Colors.grey.shade400),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 14,
              ),
            ),
            onChanged: (value) {
              controller.updateEducationField(index, 'institutionName', value);
            },
          ),
          const SizedBox(height: 16),

          // Qualification
          const Text(
            'Qualification',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Obx(() {
            final selectedQualification =
                controller.educationList[index]['qualification'];
            return DropdownButtonFormField<String>(
              isExpanded: true,
              initialValue: selectedQualification,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 14,
                ),
              ),
              hint: Text(
                'Select a qualification',
                style: TextStyle(color: Colors.grey.shade400),
              ),
              items: controller.qualifications
                  .map(
                    (qualification) => DropdownMenuItem(
                      value: qualification,
                      child: Text(qualification),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                controller.updateEducationField(index, 'qualification', value);
              },
            );
          }),
          const SizedBox(height: 16),

          // Field Of Study
          const Text(
            'Field Of Study',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              hintText: 'e.g. Computer Science/Medicine/Civil Engineering',
              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 14,
              ),
            ),
            onChanged: (value) {
              controller.updateEducationField(index, 'fieldOfStudy', value);
            },
          ),
          const SizedBox(height: 16),

          // Country
          const Text(
            'Country',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Obx(() {
            final selectedCountry = controller.educationList[index]['country'];
            return DropdownButtonFormField<String>(
              isExpanded: true,
              initialValue: selectedCountry,
              menuMaxHeight: MediaQuery.of(context).size.height * 0.5,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 14,
                ),
              ),
              hint: Text(
                'Select Country',
                style: TextStyle(color: Colors.grey.shade400),
              ),
              items: controller.countries
                  .map(
                    (country) =>
                        DropdownMenuItem(value: country, child: Text(country)),
                  )
                  .toList(),
              onChanged: (value) {
                controller.updateEducationField(index, 'country', value);
              },
            );
          }),
          const SizedBox(height: 16),

          // City
          const Text(
            'City',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Obx(() {
            final selectedCity = controller.educationList[index]['city'];
            return DropdownButtonFormField<String>(
              isExpanded: true,
              initialValue: selectedCity,
              menuMaxHeight: MediaQuery.of(context).size.height * 0.5,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 14,
                ),
              ),
              hint: Text(
                'Select country first',
                style: TextStyle(color: Colors.grey.shade400),
              ),
              items: controller.cities
                  .map(
                    (city) => DropdownMenuItem(value: city, child: Text(city)),
                  )
                  .toList(),
              onChanged: (value) {
                controller.updateEducationField(index, 'city', value);
              },
            );
          }),
          const SizedBox(height: 16),

          // Currently Studying checkbox
          Obx(() {
            final isChecked =
                controller.educationList[index]['currentlyStudying'] ?? false;
            return Row(
              children: [
                SizedBox(
                  height: 20,
                  width: 20,
                  child: Checkbox(
                    value: isChecked,
                    onChanged: (value) {
                      controller.toggleCurrentlyStudying(index);
                    },
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'Currently Studying',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            );
          }),
          const SizedBox(height: 16),

          // Start Date
          const Text(
            'Start Date',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              hintText: 'MM/YYYY',
              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 14,
              ),
            ),
            onChanged: (value) {
              controller.updateEducationField(index, 'startDate', value);
            },
          ),
          const SizedBox(height: 16),

          // Graduation Date
          const Text(
            'Graduation Date',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              hintText: 'MM/YYYY',
              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 14,
              ),
            ),
            onChanged: (value) {
              controller.updateEducationField(index, 'graduationDate', value);
            },
          ),
          const SizedBox(height: 16),

          // Remove Education button (only show if not the first form or if there are multiple forms)
          Obx(() {
            final shouldShowRemove =
                controller.educationList.length > 1 && index > 0;
            if (!shouldShowRemove) {
              return const SizedBox.shrink();
            }
            return Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFFE11D48),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                onPressed: () => controller.removeEducation(index),
                child: const Text('Remove Education'),
              ),
            );
          }),
        ],
      ),
    );
  }
}
