import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karlfive/features/create%20job/presentation/controller/category_controller.dart';
import 'package:karlfive/features/create%20job/presentation/controller/currency_controller.dart';
import 'package:karlfive/features/create%20job/presentation/screens/create_job_details_screen.dart';
import 'package:karlfive/features/create%20job/presentation/screens/widget/job_category_widget.dart';
import 'package:karlfive/features/create%20job/presentation/screens/widget/searchable_widget.dart';
import '../../../company/presentation/widget/custom_text_field.dart';
import '../../../company/presentation/widget/custom_dropdown_widget.dart';
import '../controller/create_job_controller.dart';
import 'widget/job_create_widget.dart';
import 'widget/progress_indicator_widget.dart';

class CreateJobPostingScreen extends StatelessWidget {
  final CreateJobPostingController controller = Get.put(
    CreateJobPostingController(Get.find()),
  );

  final CategoryController categoryController = Get.put(
    CategoryController(Get.find()),
  );

  final CurrencyController currencyController = Get.put(
    CurrencyController(Get.find()),
  );

  CreateJobPostingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Create Job Posting",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
      body: Obx(() {
        if (controller.isLoadingCountries.value ||
            categoryController.isLoading.value) {
          // || categoryController.isLoading.value
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              JobProgressBar(),
              const SizedBox(height: 20),
              const Text(
                "Please update the candidate at every stage of their application journey with a simple click!",
                style: TextStyle(fontSize: 12, color: Colors.black),
              ),
              const SizedBox(height: 24),
              const Text(
                "Job Details",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: SearchableDropdownField(
                      label: "Job Category",
                      hintText: 'Select job category',
                      items: categoryController.categories
                          .map((c) => c.name)
                          .toList(),
                      value: categoryController.selectedCategory.value,
                      onChanged: (value) {
                        categoryController.selectedCategory.value = value;
                        // Update roles based on selected category
                        categoryController.updateRoles(value);
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Obx(() {
                      return SearchableDropdownField(
                        label: "Job Role",
                        hintText: 'Select role',
                        items: categoryController.roles,
                        value: categoryController.selectedRole.value,
                        onChanged: (value) {
                          categoryController.selectedRole.value = value;
                          // Only auto-fill Job Title if user hasn't typed manually
                          if (!controller.jobTitleManuallyEdited.value) {
                            controller.jobTitleController.text = value;
                          }
                        },
                        enabled: categoryController.roles.isNotEmpty,
                      );
                    }),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              /// Job Title
              ///
              CustomTextField(
                label: "Job Title",
                hintText: "Enter job title",
                controller: controller.jobTitleController,
                isRequired: true,
                // onChanged: (text) {
                //   // Mark as manually edited when user types
                //   controller.jobTitleManuallyEdited.value = true;
                // },
              ),

              // CustomTextField(
              //   label: "Job Title",
              //   hintText: "Enter job title",
              //   controller: controller.jobTitleController,
              //   isRequired: true,
              // ),
              CustomTextField(
                label: "Department (Optional)",
                hintText: "Enter department",
                controller: controller.departmentController,
                isRequired: false,
              ),

              const SizedBox(height: 16),

              /// Country + City Section
              CountryCitySelector(controller: controller),
              const SizedBox(height: 16),

              ///Job Category=Role selection

              // JobCategoryRoleSelector(controller:   controller),
              // const SizedBox(height: 16),

              /// Employment Type
              Row(
                children: [
                  Expanded(
                    child: CustomDropdownJobField(
                      label: "Employment Type",
                      hintText: 'Select employment type',
                      items: [
                        "Full-time",
                        "Part-time",
                        "Internship",
                        "Contract",
                        "Temporary",
                        "Freelance",
                        "Volunteer",
                      ],
                      isRequired: true,
                      rxValue: controller.selectedEmploymentType,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomDropdownJobField(
                      label: "Experience Level",
                      hintText: 'Select experience level',
                      items: [
                        "Entry Level",
                        "Mid Level",
                        "Senior Level",
                        "Executive",
                      ],
                      isRequired: true,
                      rxValue: controller.selectedEmploymentType,
                    ),
                  ),
                ],
              ),

              Row(
                children: [
                  Expanded(
                    child: Obx(() {
                      return SearchableDropdownField(
                        label: "Currency",
                        hintText: 'Select currency',
                        items: currencyController.currencyList
                            .map((c) => "${c.currencyName} (${c.code})")
                            .toList(), // ✅ Now it's List<String>
                        value: currencyController.selectedCurrency.value != null
                            ? "${currencyController.selectedCurrency.value!.currencyName} (${currencyController.selectedCurrency.value!.code})"
                            : null,
                        onChanged: (value) {
                          if (value != null) {
                            // Find the CurrencyData that matches the string
                            final selected = currencyController.currencyList
                                .firstWhere(
                                  (c) =>
                                      "${c.currencyName} (${c.code})" == value,
                                );
                            currencyController.selectCurrency(selected);
                            controller.compensationController.clear();
                          }
                        },
                      );
                    }),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Obx(() {
                      final selected =
                          currencyController.selectedCurrency.value;

                      // Get the symbol safely
                      final symbol = selected?.symbol;

                      return CustomTextField(
                        label: "Compensation (Optional)",
                        hintText: selected != null
                            ? "Enter amount in ${selected.code}"
                            : "Enter amount",
                        controller: controller.compensationController,
                        keyboardType: TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        prefix: symbol != null
                            ? Text(
                                symbol, // ✅ Already checked it's not null
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              )
                            : null,
                      );
                    }),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              /// Compensation
              const SizedBox(height: 20),

              CustomDropdownJobField(
                label: "Job Posting Expiration (Days)",
                hintText: 'Select experience level',
                items: ["7 days", "14 days", "30 days", "60 days", "90 days"],
                isRequired: true,
                rxValue: controller.jobpostingExpirationDate,
              ),

              const SizedBox(height: 20),

              CustomTextField(
                label: "Company Website (Optional)",
                hintText: "https://example.com",
                controller: controller.companyWebsiteController,
              ),

              const SizedBox(height: 20),

              _bottomButtons(),
            ],
          ),
        );
      }),
    );
  }



  Widget _stepItem(String title, bool active) {
    return Column(
      children: [
        Icon(
          Icons.circle,
          size: 12,
          color: active ? Colors.blue : Colors.grey.shade300,
        ),
        const SizedBox(height: 4),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10,
            color: active ? Colors.blue : Colors.grey,
            fontWeight: active ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _bottomButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text(
            "Cancel",
            style: TextStyle(
              color: Color(0xFF2B7FD0),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: () {
            controller.goToStep(1);
            Get.to(() => JobDescriptionScreen(),transition: Transition.rightToLeft);
          },
          // Get.snackbar("Next", "Proceeding to next step..."),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF2B7FD0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            "Next",
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
