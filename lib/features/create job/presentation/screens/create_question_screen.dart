// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../../company/presentation/widget/custom_text_field.dart';
// import '../controller/create_job_controller.dart';
// import 'widget/progress_indicator_widget.dart';

// class CustomQuestionScreen extends StatefulWidget {
//   const CustomQuestionScreen({super.key});

//   @override
//   State<CustomQuestionScreen> createState() => _CustomQuestionScreenState();
// }

// class _CustomQuestionScreenState extends State<CustomQuestionScreen> {
//   final CreateJobPostingController controller = Get.find();

//    @override
//   void initState() {
//     super.initState();
//     if (controller.questionControllers.isEmpty) {
//       controller.questionControllers.add(TextEditingController());
//     }
//   }

//   /// Requirements map
//   final Map<String, String> requirements = {
//     "Resume": "Optional",
//     "Valid visa for job location": "Optional",
//   };

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         elevation: 0,
//         backgroundColor: Colors.white,
//         centerTitle: true,
//         title: const Text(
//           "Create Job Posting",
//           style: TextStyle(
//             color: Color(0xFF000000),
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             /// Progress bar
//             JobProgressBar(),
//             const SizedBox(height: 20),

//             const Text(
//               "Add Custom Questions",
//               style: TextStyle(
//                 color: Color(0xFF000000),
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(
//                   child: CustomTextField(
//                     label: "Ask a question",
//                     hintText: "Write here",
//                     // controller: controller.askQuestionController[0],
//                     isRequired: true,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 8),

//             // Add More button
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 ElevatedButton(
//                   onPressed: controller.addQuestion,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFFFFFFFF),
//                     foregroundColor: Colors.black,
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 12,
//                       vertical: 14,
//                     ),
//                     elevation: 0,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(6),
//                       side: const BorderSide(
//                         color: Colors.grey, // border color
//                         width: 1, // border width
//                       ),
//                     ),
//                   ),
//                   child: const Text(
//                     "Add More +",
//                     style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
//                   ),
//                 ),
//               ],
//             ),

//             // Dynamic employee fields
//             Obx(
//               () => Column(
//                 children: List.generate(
//                   controller.questionControllers.length,
//                   (index) => Padding(
//                     padding: const EdgeInsets.only(bottom: 12),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: CustomTextField(
//                             label: "Question ${index + 1}",
//                             hintText: "Write your question here",
//                             controller: controller.questionControllers[index],
//                             isRequired: true,
//                           ),
//                         ),
//                         const SizedBox(width: 8),
//                         if (index > 0)
//                           IconButton(
//                             icon: const Icon(Icons.close, color: Colors.red),
//                             onPressed: () => controller.removeQuestion(index),
//                           ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),

//             const SizedBox(height: 32),

//             /// --- Buttons ---
//             _bottomButtons(context),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _styledToggle(String field, String value, bool isOptional) {
//     bool isSelected = requirements[field] == value;

//     Color bgColor;
//     Color textColor;

//     if (isOptional) {
//       bgColor = isSelected ? const Color(0xFF2B7FD0) : const Color(0xFFF1F4F5);
//       textColor = isSelected ? Colors.white : const Color(0xFF9EC7DC);
//     } else {
//       bgColor = isSelected ? Color(0xFF2B7FD0) : const Color(0xFFF1F4F5);
//       textColor = isSelected ? Color(0xFF000000) : const Color(0xFF9EC7DC);
//     }

//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           requirements[field] = value;
//         });
//       },
//       child: Container(
//         padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
//         decoration: BoxDecoration(
//           color: bgColor,
//           borderRadius: BorderRadius.circular(6),
//         ),
//         child: Text(value, style: TextStyle(color: textColor, fontSize: 13)),
//       ),
//     );
//   }

//   Widget _bottomButtons(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: [
//         TextButton(
//           onPressed: () => Get.back(),
//           child: const Text(
//             "Back",
//             style: TextStyle(
//               color: Color(0xFF2B7FD0),
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ),
//         const SizedBox(width: 8),
//         ElevatedButton(
//           onPressed: () {
//             controller.nextStep();
//             // Get.snackbar("Next", "Proceeding to next step...");
//           },
//           style: ElevatedButton.styleFrom(
//             backgroundColor: const Color(0xFF2B7FD0),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(8),
//             ),
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//           ),
//           child: const Text(
//             "Next",
//             style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../company/presentation/widget/custom_text_field.dart';
import '../controller/create_job_controller.dart';
import 'widget/progress_indicator_widget.dart';

class CustomQuestionScreen extends StatefulWidget {
  const CustomQuestionScreen({super.key});

  @override
  State<CustomQuestionScreen> createState() => _CustomQuestionScreenState();
}

class _CustomQuestionScreenState extends State<CustomQuestionScreen> {
  final CreateJobPostingController controller = Get.find();

  @override
  void initState() {
    super.initState();
    if (controller.questionControllers.isEmpty) {
      controller.questionControllers.add(TextEditingController());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Create Job Posting",
          style: TextStyle(
            color: Color(0xFF000000),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Progress bar
            JobProgressBar(),
            const SizedBox(height: 20),

            const Text(
              "Add Custom Questions",
              style: TextStyle(
                color: Color(0xFF000000),
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),

            // --- Dynamic Question Fields ---
            Obx(
              () => Column(
                children: [
                  // 🧩 Main question field (always visible)
                  CustomTextField(
                    label: "Question 1",
                    hintText: "Write here",
                    controller: controller.questionControllers[0],
                    isRequired: true,
                  ),
                  const SizedBox(height: 12),

                  // 🧩 Dynamically added question fields (if any)
                  ...List.generate(controller.questionControllers.length - 1, (
                    index,
                  ) {
                    final actualIndex = index + 1; // skip the first one
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              label: "Question ${actualIndex + 1}",
                              hintText: "Write your question here",
                              controller:
                                  controller.questionControllers[actualIndex],
                              isRequired: true,
                            ),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            icon: const Icon(Icons.close, color: Colors.red),
                            onPressed: () =>
                                controller.removeQuestion(actualIndex),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // --- Add More Button ---
            Row(
              children: [
                ElevatedButton(
                  onPressed: controller.addQuestion,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFFFFF),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 14,
                    ),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                      side: const BorderSide(color: Colors.grey, width: 1),
                    ),
                  ),
                  child: const Text(
                    "Add More +",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            /// --- Bottom Buttons ---
            _bottomButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _bottomButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text(
            "Back",
            style: TextStyle(
              color: Color(0xFF2B7FD0),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: () {
            controller.nextStep();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2B7FD0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
          child: const Text(
            "Next",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
