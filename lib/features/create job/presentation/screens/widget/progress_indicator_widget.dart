// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../controller/create_job_controller.dart';

// class JobProgressBar extends StatelessWidget {
//   final List<String> steps = const [
//     "Job\nDetails",
//     "Job\nDescription",
//     "Application\nRequirements",
//     "Custom\nQuestions",
//     "Finish",
//   ];

//   JobProgressBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.find<CreateJobPostingController>();

//     return Obx(() {
//       final current = controller.currentStep.value;

//       return Container(
//         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
//         child: Row(
//           children: List.generate(steps.length * 2 - 1, (i) {
//             if (i.isEven) {
//               // Circle + label
//               final index = i ~/ 2;
//               final isActive = index < current;
//               final isCurrent = index == current;

//               return Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   // Circle
//                   Container(
//                     width: 24,
//                     height: 24,
//                     decoration: BoxDecoration(
//                       color: isActive || isCurrent ? Colors.blue : Colors.white,
//                       border: Border.all(
//                         color: isActive || isCurrent
//                             ? Colors.blue
//                             : const Color(0xFFF1F1F1),
//                         width: 2,
//                       ),
//                       shape: BoxShape.circle,
//                     ),
//                     child: isActive
//                         ? const Icon(Icons.check, color: Colors.white, size: 10)
//                         : null,
//                   ),

//                   const SizedBox(height: 6),

//                   // Label
//                   SizedBox(
//                     width: 50,
//                     child: Text(
//                       steps[index],
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 9,
//                         color: isActive || isCurrent
//                             ? Colors.blue
//                             : Colors.black,
//                         fontWeight: isActive || isCurrent
//                             ? FontWeight.w600
//                             : FontWeight.normal,
//                       ),
//                     ),
//                   ),
//                 ],
//               );
//             } else {
//               // Connector line
//               final lineIndex = (i - 1) ~/ 2;
//               return Expanded(
//                 child: Container(
//                   height: 2,
//                   color: current > lineIndex
//                       ? Colors.blue
//                       : Colors.grey.shade300,
//                 ),
//               );
//             }
//           }),
//         ),
//       );
//     });
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../controller/create_job_controller.dart';

// class JobProgressBar extends StatelessWidget {
//   final List<String> steps = const [
//     "Job \n Details",
//     "Job \n Description",
//     "Application \n Requirements",
//     "Custom \n Questions",
//     "Finish \n",
//   ];

//   JobProgressBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.find<CreateJobPostingController>();

//     return Obx(() {
//       final current = controller.currentStep.value;

//       return Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           // --- Circles + Connecting Lines (compact width) ---
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 35), // 👈 compact sides
//             child: Row(
//               children: List.generate(steps.length * 2 - 1, (index) {
//                 if (index.isOdd) {
//                   int lineIndex = (index - 1) ~/ 2;
//                   return Expanded(
//                     child: Container(
//                       height: 2,
//                       color: lineIndex < current
//                           ? Colors.blue
//                           : Colors.grey.shade300,
//                     ),
//                   );
//                 } else {
//                   int circleIndex = index ~/ 2;
//                   final isCompleted = circleIndex < current;
//                   final isCurrent = circleIndex == current;

//                   return Container(
//                     width: 16,
//                     height: 16,
//                     decoration: BoxDecoration(
//                       color: isCompleted ? Colors.blue : Colors.white,
//                       border: Border.all(
//                         color: isCompleted || isCurrent
//                             ? Colors.blue
//                             : Colors.grey.shade400,
//                         width: 2,
//                       ),
//                       shape: BoxShape.circle,
//                     ),
//                     child: isCompleted
//                         ? const Icon(Icons.check, size: 12, color: Colors.white)
//                         : isCurrent
//                             ? Center(
//                                 child: Container(
//                                   width: 8,
//                                   height: 8,
//                                   decoration: const BoxDecoration(
//                                     color: Colors.white,
//                                     shape: BoxShape.circle,
//                                   ),
//                                 ),
//                               )
//                             : null,
//                   );
//                 }
//               }),
//             ),
//           ),

//           const SizedBox(height: 8),

//           // --- Step Labels (full width, unchanged) ---
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: List.generate(steps.length, (index) {
//               final isActive = index <= current;
//               return Expanded(
//                 child: Text(
//                   steps[index],
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 11,
//                     color: isActive ? Colors.black : Colors.black87,
//                     fontWeight:
//                         isActive ? FontWeight.w600 : FontWeight.normal,
//                   ),
//                 ),
//               );
//             }),
//           ),
//         ],
//       );
//     });
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/create_job_controller.dart';

class JobProgressBar extends StatelessWidget {
  final List<String> steps = const [
    "Job \n Details",
    "Job \n Description",
    "Application \n Requirements",
    "Custom \n Questions",
    "Finish \n",
  ];

  JobProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CreateJobPostingController>();

    return Obx(() {
      final current = controller.currentStep.value;

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // --- Circles + Connecting Lines ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Row(
              children: List.generate(steps.length * 2 - 1, (index) {
                if (index.isOdd) {
                  // --- Connector line ---
                  int lineIndex = (index - 1) ~/ 2;
                  return Expanded(
                    child: Container(
                      height: 2,
                      color: lineIndex < current
                          ? Colors.blue
                          : Colors.grey.shade300,
                    ),
                  );
                } else {
                  // --- Circle ---
                  int circleIndex = index ~/ 2;
                  final isCompleted = circleIndex < current;
                  final isCurrent = circleIndex == current;
                  final isUpcoming = circleIndex > current;

                  Color circleColor;
                  Widget? child;

                  if (isCompleted) {
                    // Completed step → Blue with white tick
                    circleColor = Colors.blue;
                    child = const Icon(Icons.check, size: 12, color: Colors.white);
                  } else if (isCurrent) {
                    // Current step → Blue with white dot
                    circleColor = Colors.blue;
                    child = Center(
                      child: Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    );
                  } else {
                    // Upcoming step → Gray
                    circleColor = Colors.grey.shade300;
                  }

                  return Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      color: circleColor,
                      shape: BoxShape.circle,
                    ),
                    child: child,
                  );
                }
              }),
            ),
          ),

          const SizedBox(height: 8),

          // --- Step Labels ---
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(steps.length, (index) {
              return Expanded(
                child: Text(
                  steps[index],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }),
          ),
        ],
      );
    });
  }
}

