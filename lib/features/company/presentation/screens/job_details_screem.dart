// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:karlfive/core/common/widgets/app_scaffold.dart';
// import 'package:table_calendar/table_calendar.dart';

// import '../controller/job_details_controller.dart';
// import '../widget/job_details_widget.dart';

// class JobDetailsPage extends StatelessWidget {
//   final JobDetailsController controller = Get.put(JobDetailsController());

//   JobDetailsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFF8F8F8),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 46),

//             /// --- Job Description Section Header in Box ---
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.symmetric(vertical: 12),
//               margin: const EdgeInsets.only(bottom: 16),
//               decoration: BoxDecoration(
//                 color: Color(0xFFF8F8F8),

//               ),
//               child: const Center(
//                 child: Text(
//                   "Job Details",
//                   style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
//                 ),
//               ),
//             ),

//             const SizedBox(height: 39),
//             Text(
//               "Job Description",
//               style: TextStyle(
//                 color: Color(0xFF000000),
//                 fontSize: 18,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             const SizedBox(height: 15),

//             JobTextField(
//               label: "Job Title",
//               hint: "Enter job title",
//               value: controller.jobTitle,
//             ),
//             JobTextField(
//               label: "Description (Optional)",
//               hint: "Enter description",
//               value: controller.description,
//             ),
//             JobTextField(
//               label: "Location",
//               hint: "Enter location",
//               value: controller.location,
//             ),
//             JobTextField(
//               label: "Employment Type",
//               hint: "Full-time / Part-time",
//               value: controller.employmentType,
//             ),
//             JobTextField(
//               label: "Compensation (Optional)",
//               hint: "\$50,000 - \$70,000 annual base",
//               value: controller.compensation,
//             ),
//             JobTextField(
//               label: "Experience (Optional)",
//               hint: "e.g. 5+ years",
//               value: controller.experience,
//             ),

//             const SizedBox(height: 20),

//             /// --- Job Description Editor Section ---
//             // Container(
//             //   width: double.infinity,
//             //   padding: const EdgeInsets.symmetric(vertical: 12),
//             //   margin: const EdgeInsets.only(bottom: 16),
//             //   decoration: BoxDecoration(
//             //     color: Colors.grey[300],
//             //     borderRadius: BorderRadius.circular(8),
//             //   ),
//             //   child: const Center(
//             //     child: Text(
//             //       "Job Description",
//             //       style: TextStyle(
//             //         fontWeight: FontWeight.bold,
//             //         fontSize: 16,
//             //       ),
//             //     ),
//             //   ),
//             // ),
//             JobTextField(
//               label: "Job Description",
//               hint: "Write Your Job Description",
//               value: controller.jobDescription,
//               maxLines: 15,
//             ),

//             Container(
//               color: Colors.white,
//               padding: const EdgeInsets.all(8),
//               child: Column(
//                 children: [
//                   quill.QuillToolbar.simple(
//                     controller: _quillController,
//                     configurations: const quill.QuillSimpleToolbarConfigurations(
//                       showBoldButton: true,
//                       showItalicButton: true,
//                       showUnderLineButton: true,
//                       showListBullets: true,
//                       showListNumbers: true,
//                       showCodeBlock: false,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Container(
//                     height: 200,
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.grey.shade300),
//                       color: Colors.white,
//                     ),
//                     child: quill.QuillEditor.basic(
//                       controller: _quillController,
//                       configurations: const quill.QuillEditorConfigurations(
//                         readOnly: false,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 24),

//             /// --- Publish Now ---
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   "Publish Now",
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//                 ),
//                 Switch(
//                   value: publishNow,
//                   onChanged: (val) {
//                     setState(() => publishNow = val);
//                   },
//                 ),
//               ],
//             ),

//             const SizedBox(height: 12),

//             /// --- Schedule Publish ---
//             const Text(
//               "Schedule Publish",
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//             ),
//             const SizedBox(height: 8),

//             Container(
//               color: Colors.white,
//               child: TableCalendar(
//                 firstDay: DateTime.utc(2020, 1, 1),
//                 lastDay: DateTime.utc(2030, 12, 31),
//                 focusedDay: DateTime.now(),
//                 selectedDayPredicate: (day) =>
//                     _selectedDate != null && isSameDay(_selectedDate, day),
//                 onDaySelected: (selectedDay, focusedDay) {
//                   setState(() => _selectedDate = selectedDay);
//                 },
//               ),
//             ),

//             const SizedBox(height: 24),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 minimumSize: const Size(double.infinity, 50),
//                 backgroundColor: Colors.black,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               onPressed: () {
//                 Get.snackbar(
//                   "Success",
//                   "Job Details Submitted",
//                   snackPosition: SnackPosition.BOTTOM,
//                 );
//               },
//               child: const Text("Save Job Details"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_quill/flutter_quill.dart';

import '../controller/job_details_controller.dart';
import '../widget/job_details_widget.dart';

class JobDetailsPage extends StatefulWidget {
  const JobDetailsPage({super.key});

  @override
  State<JobDetailsPage> createState() => _JobDetailsPageState();
}

class _JobDetailsPageState extends State<JobDetailsPage> {
  final JobDetailsController controller = Get.put(JobDetailsController());

  /// Rich Text Editor
  final quill.QuillController _quillController = quill.QuillController.basic();

  /// Publish Now Toggle
  bool publishNow = true;

  /// Calendar Date
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 46),

            /// --- Job Description Section Header in Box ---
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              margin: const EdgeInsets.only(bottom: 16),
              child: const Center(
                child: Text(
                  "Job Details",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              "Job Information",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 15),

            /// Job Fields
            JobTextField(
              label: "Job Title",
              hint: "Enter job title",
              value: controller.jobTitle,
            ),
            JobTextField(
              label: "Description (Optional)",
              hint: "Enter description",
              value: controller.description,
            ),
            JobTextField(
              label: "Location",
              hint: "Enter location",
              value: controller.location,
            ),
            JobTextField(
              label: "Employment Type",
              hint: "Full-time / Part-time",
              value: controller.employmentType,
            ),
            JobTextField(
              label: "Compensation (Optional)",
              hint: "\$50,000 - \$70,000 annual base",
              value: controller.compensation,
            ),
            JobTextField(
              label: "Experience (Optional)",
              hint: "e.g. 5+ years",
              value: controller.experience,
            ),

            const SizedBox(height: 20),

            /// --- Rich Text Editor Section ---
            Text(
              "Job Description",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),

//             Container(
//               color: Colors.white,
//               padding: const EdgeInsets.all(8),
//               child: Column(
//                 children: [
//                   /// Toolbar (Bold, Italic, Underline, Bullets, etc.)
//                   QuillToolbar.basic(
//                     controller: _quillController,
//                     showBoldButton: true,
//                     showItalicButton: true,
//                     showUnderLineButton: true,
//                     showListBullets: true,
//                     showListNumbers: true,
//                     showCodeBlock: false,
//                   ),
//                   const SizedBox(height: 8),

//                   /// Editor Box
//                   Container(
//                     height: 200,
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.grey.shade300),
//                       color: Colors.white,
//                     ),
//                     child: QuillEditor.basic(
//   controller: _quillController,
//   // readOnly: false,
// ),

//                     ),
//                   ),
//                 ];
//               ),
//             ),

            const SizedBox(height: 24),

            /// --- Publish Now ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Publish Now",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Switch(
                  value: publishNow,
                  onChanged: (val) {
                    setState(() => publishNow = val);
                  },
                ),
              ],
            ),

            const SizedBox(height: 12),

            /// --- Schedule Publish ---
            const Text(
              "Schedule Publish",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),

            Opacity(
              opacity: publishNow ? 0.4 : 1, // fade when disabled
              child: IgnorePointer(
                ignoring: publishNow, // block taps when Publish Now is true
                child: Container(
                  color: Colors.white,
                  child: TableCalendar(
                    firstDay: DateTime.utc(2020, 1, 1),
                    lastDay: DateTime.utc(2030, 12, 31),
                    focusedDay: DateTime.now(),
                    selectedDayPredicate: (day) =>
                        _selectedDate != null && isSameDay(_selectedDate, day),
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() => _selectedDate = selectedDay);
                    },
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            /// --- Save Button ---
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                Get.snackbar(
                  "Success",
                  "Job Details Submitted",
                  snackPosition: SnackPosition.BOTTOM,
                );
              },
              child: const Text("Save Job Details"),
            ),
          ],
        ),
      ),
    );
  }
}
