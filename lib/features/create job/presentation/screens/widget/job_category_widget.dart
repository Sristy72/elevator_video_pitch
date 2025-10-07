import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karlfive/features/company/presentation/widget/custom_dropdown_widget.dart';
import '../../controller/create_job_controller.dart';
import 'searchable_widget.dart';

// class JobCategoryRoleSelector extends StatelessWidget {
//   final CreateJobPostingController controller;

//   const JobCategoryRoleSelector({super.key, required this.controller});

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       if (controller.isLoadingCategories.value) {
//         return const Center(child: CircularProgressIndicator());
//       }

//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // ───── Job Category Dropdown ─────
//           SearchableDropdownField(
//             label: "Job Category",
//             hintText: "Select job category",
//             items: controller.jobCategories,
//             value: controller.selectedCategory.value.isEmpty
//                 ? null
//                 : controller.selectedCategory.value,
//             onChanged: (val) {
//               controller.selectedCategory.value = val;
//               controller.fetchRoles(val); // load roles for selected category
//             },
//             isRequired: true,
//           ),
//           const SizedBox(height: 16),

//           // ───── Role Dropdown ─────
//           SearchableDropdownField(
//             label: "Role",
//             hintText: controller.selectedCategory.value.isEmpty
//                 ? "Select category first"
//                 : "Select role",
//             items: controller.rolesList,
//             value: controller.selectedRole.value.isEmpty
//                 ? null
//                 : controller.selectedRole.value,
//             onChanged: (val) {
//               controller.selectedRole.value = val;
//             },
//             enabled: controller.selectedCategory.value.isNotEmpty,
//             isRequired: true,
//           ),
//         ],
//       );
//     });
//   }
//}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:karlfive/features/create%20job/presentation/screens/widget/searchable_widget.dart';
// import '../../controller/create_job_controller.dart';

// class JobCategoryRoleSelector extends StatelessWidget {
//   final CreateJobPostingController controller;

//   const JobCategoryRoleSelector({super.key, required this.controller});

//   @override
//   Widget build(BuildContext context) {

//     final categoryCtrl = controller.categoryController;
//    return Obx(() {
//       if (categoryCtrl.isLoading.value) {
//         return const Center(child: CircularProgressIndicator());
//       }

//       final categories = categoryCtrl.categoryResponse.value?.categories ?? [];

//       if (categories.isEmpty) {
//         return const Text('No categories found');
//       }

//       final categoryNames = categories.map((c) => c.name).toList();

//       // Get roles for selected category
//       final selectedCategoryObj = categories.firstWhereOrNull(
//         (c) => c.name == controller.selectedCategory.value,
//       );
//       final roleItems = selectedCategoryObj?.role ?? [];


//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // ───── Country Dropdown ─────
//           CustomDropdownJobField(
//            label: "Job Category",
//             hintText: "Select category",
//             items: categoryNames,
//             rxValue: controller.selectedCategory,
//             onChanged: (val) {
//               controller.selectedCategory.value = val ?? '';
//               controller.selectedRole.value = ''; // reset role
//             },
//             isRequired: true,
//           ),
//           const SizedBox(height: 16),

//           // ───── City Dropdown ─────
//           if (controller.selectedCountry.value.isNotEmpty)
//             CustomDropdownJobField(
//             label: "Job Role",
//             hintText: "Select role",
//             items: roleItems,
//             rxValue: controller.selectedRole,
//             onChanged: (val) => controller.selectedRole.value = val ?? '',
//             isRequired: true,
//           ),
//         ],
//       );
//     });
//   }
// }
