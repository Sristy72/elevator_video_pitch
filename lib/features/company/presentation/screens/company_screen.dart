import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karlfive/core/common/widgets/app_scaffold.dart';

import '../../../../core/theme/app_buttoms.dart';
import '../../../../core/theme/app_colors.dart';
import '../controller/company_account_controller.dart';
import '../widget/add_list_widget.dart';
import '../widget/custom_text_field.dart';
import '../widget/upload_card_widget.dart';
import '../widget/upload_video_widget.dart';
import 'company_details_screen.dart';

class CreateCompanyAccountPage extends StatelessWidget {
  final CompanyAccountController controller = Get.put(
    CompanyAccountController(),
  );

  CreateCompanyAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,

      // ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            const SizedBox(height: 51),
            Text(
              "Create Company Account",
              style: TextStyle(
                color: AppColors.buttonText,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Text(
              "Sign-up and pitch your way into a new role",
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 28),

            // const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Upload company elevator pitch",
                  style: TextStyle(
                    color: AppColors.buttonText,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Upload a 60-second elevator video pitch introducing your company and what should make candidates want to join you!",
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Upload Elevator Pitch
            VideoUploadCardWidget(
              title: "Upload your elevator pitch",
              subtitle:
                  "Share a video introduction to make your resume stand out",
              buttonText: "Upload Elevator Pitch",
              fileType:
                  "Drop your file here \n Maximum size 24mb and 30 seconds or 60 seconds long (if upgraded) \n Choose File",
              // isChecked: true,
              // onChanged: (value) {},
            ),
            const SizedBox(height: 24),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Company Banner",
                style: TextStyle(
                  color: AppColors.buttonText,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Company Banner
            UploadCardWidget(
              title: "Upload banner",
              subtitle:
                  "Upload and crop a banner image to enhance your resume profile.",
              buttonText: "Upload Banner",
              fileType:
                  "Drop your file here \n Supports JPG, PNG • Max 10MB • Will be cropped to 300px height \n Choose File",
            ),

            const SizedBox(height: 24),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Company Logo",
                style: TextStyle(
                  color: AppColors.buttonText,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Company Logo
            UploadCardWidget(
              title: "",
              subtitle: "",
              buttonText: "Upload Logo",
              fileType: "Drop your file here\nChoose Logo",
            ),

            const SizedBox(height: 24),

            // Align(
            //   alignment: Alignment.centerLeft,
            //   child: Text(
            //     "About Us",
            //     style: TextStyle(
            //       color: AppColors.textBlack,
            //       fontSize: 18,
            //       fontWeight: FontWeight.w500,
            //     ),
            //   ),
            // ),
            const SizedBox(height: 8),
            CustomTextField(
              maxLines: 5,
              controller: controller.aboutUsController, // ✅ bind
              label: 'About Us',

              isRequired: false,
              hintText: "Write here",
            ),
            const SizedBox(height: 8),
            CustomTextField(
              label: 'Company Name',

              isRequired: true,
              hintText: "Enter Your Country Name",
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    label: "Country",
                    controller: controller.countryController, // ✅ bind
                    hintText: "Enter Country",
                    isRequired: true,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomTextField(
                    label: "City",
                    controller: controller.cityController, // ✅ bind
                    hintText: "Enter City",
                    isRequired: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    label: "Postal Code",
                    controller: controller.postalCodeController, // ✅ bind
                    hintText: "Enter Code",
                    isRequired: true,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomTextField(
                    label: "Email",
                    controller: controller.cityController, // ✅ bind
                    hintText: "Enter Your Email",
                    isRequired: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            CustomTextField(
              label: 'Contact Number',
              controller: controller.contactNumberController, // ✅ bind

              isRequired: true,
              hintText: "+49 97 23917 3740",
            ),
            const SizedBox(height: 8),
            CustomTextField(
              label: 'Website URL',
              controller: controller.websiteController, // ✅ bind

              isRequired: true,
              hintText: "Enter Here",
            ),
            const SizedBox(height: 8),
            CustomTextField(
              label: 'Linkedin URL',
              controller: controller.linkedInController, // ✅ bind

              isRequired: true,
              hintText: "Enter Here",
            ),
            const SizedBox(height: 8),
            CustomTextField(
              label: 'Twitter-X URL',
              controller: controller.twitterController, // ✅ bind

              isRequired: true,
              hintText: "Enter Here",
            ),
            const SizedBox(height: 8),
            CustomTextField(
              label: 'Upwork URL',
              controller: controller.upworkController, // ✅ bind

              isRequired: true,
              hintText: "Enter Here",
            ),
            const SizedBox(height: 8),
            CustomTextField(
              label: 'Other Business Website',

              isRequired: true,
              hintText: "Enter Here",
            ),
            const SizedBox(height: 8),
            CustomTextField(
              label: 'Country',

              isRequired: true,
              hintText: "Industry",
            ),

            // const SizedBox(height: 8),
            // const Text(
            //   "Services",
            //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            // ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Service field expands
                Expanded(
                  child: CustomTextField(
                    label: "Service",
                    hintText: "Enter service",
                    controller: controller.serviceControllers[0],
                    isRequired: true,
                  ),
                ),
                const SizedBox(width: 8),

                // Add More button (fixed size, gray background, black text)
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: controller.addServiceField,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFFFFF), // gray background
                    foregroundColor: Colors.black, // text/icon color
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 14,
                    ),
                    elevation: 0, // flat style
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                      side: const BorderSide(
                        color: Colors.grey, // border color
                        width: 1, // border width
                      ),
                    ),
                  ),
                  child: const Text(
                    "Add More +",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),

            // Dynamic service fields
            Obx(
              () => Column(
                children: List.generate(controller.serviceControllers.length, (
                  index,
                ) {
                  if (index == 0)
                    return const SizedBox.shrink(); // skip first field
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            label: "Service ${index + 0}",
                            hintText: "Enter service",
                            controller: controller.serviceControllers[index],
                            isRequired: true,
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.red),
                          onPressed: () => controller.removeServiceField(index),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 15),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "View your Company Employees",
                style: TextStyle(
                  color: AppColors.buttonText,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: CustomTextField(
                    label: "Add Profiles of Employees",
                    hintText: "Add Here",
                    controller: controller.employeeControllers[0],
                    isRequired: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Add More button
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: controller.addEmployee,
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
                      side: const BorderSide(
                        color: Colors.grey, // border color
                        width: 1, // border width
                      ),
                    ),
                  ),
                  child: const Text(
                    "Add More +",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),

            // Dynamic employee fields
            Obx(
              () => Column(
                children: List.generate(controller.employeeControllers.length, (
                  index,
                ) {
                  if (index == 0)
                    return const SizedBox.shrink(); // skip first field
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            label: "Employee ${index + 1}",
                            hintText: "Enter employee profile",
                            controller: controller.employeeControllers[index],
                            isRequired: true,
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.red),
                          onPressed: () =>
                              controller.removeEmployeeField(index),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),

            const SizedBox(height: 25),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Award Description*",
                style: TextStyle(
                  color: AppColors.buttonText,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 7),

            Obx(() {
              final showFields = controller.awardFields.isNotEmpty;
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Award & Honors",
                      style: TextStyle(
                        color: const Color(0xFF0A0A0A),
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      "Highlight your achievements and recognitions.",
                      style: TextStyle(
                        color: const Color(0xFF2A2A2A),
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 12),

                    const SizedBox(height: 12),

                    // Dynamic Award Fields inside the same container
                    Column(
                      children: List.generate(controller.awardFields.length, (
                        index,
                      ) {
                        final fields = controller.awardFields[index];
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.shade300),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 3,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextField(
                                label: "Award Title",
                                hintText: "e.g.Employee of the Year",
                                controller: fields['title'],
                                isRequired: true,
                              ),
                              const SizedBox(height: 8),
                              CustomTextField(
                                label: "Program Name",
                                hintText: "e.g. Company Recognition Program",
                                controller: fields['issuer'],
                                isRequired: true,
                              ),
                              const SizedBox(height: 8),
                              CustomTextField(
                                label: "Program Date",
                                hintText: "MMYYYY",
                                controller: fields['date'],
                                isRequired: true,
                              ),
                              const SizedBox(height: 8),
                              CustomTextField(
                                label: "Award Short Description",
                                hintText: "Briefly describe the award",
                                controller: fields['description'],
                                isRequired: true,
                                maxLines: 3,
                              ),
                              const SizedBox(height: 8),
                              Align(
                                alignment: Alignment.centerRight,
                                child: ElevatedButton(
                                  onPressed: () =>
                                      controller.removeAwardField(index),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red[100],
                                    foregroundColor: Colors.red[800],
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 8,
                                    ),
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                  child: const Text("Remove Award"),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),

                    // Add Award Button always at bottom
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ElevatedButton(
                        onPressed: controller.addAwardField,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(
                            0xFFFFFFFF,
                          ), // white background
                          foregroundColor: Colors.black, // text color
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                            side: const BorderSide(
                              color: Colors.grey, // border color
                              width: 1, // border width
                            ),
                          ),
                        ),
                        child: const Text("Add Award"),
                      ),
                    ),
                  ],
                ),
              );
            }),

            const SizedBox(height: 16),

            // Save Button
            PrimaryButton(
              text: "Save",
              onPressed: () {
                if (controller.formKey.currentState!.validate()) {
                  controller.saveForm();
                  Get.to(() => CompanyDetailsPage());
                }
              },
              width: double.infinity, // optional
              height: 45, // optional
            ),
          ],
        ),
      ),
    );
  }
}
