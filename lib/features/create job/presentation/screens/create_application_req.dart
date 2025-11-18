import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/create_job_controller.dart';
import 'widget/progress_indicator_widget.dart';

class ApplicationReqScreen extends StatefulWidget {
  const ApplicationReqScreen({super.key});

  @override
  State<ApplicationReqScreen> createState() => _ApplicationReqScreenState();
}

class _ApplicationReqScreenState extends State<ApplicationReqScreen> {
  final CreateJobPostingController controller = Get.find();

  /// Requirements map
  final Map<String, String> requirements = {
    "Resume": "Optional",
    "Valid visa for job location": "Optional",
  };

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
          style: TextStyle(color: Color(0xFF000000), fontWeight: FontWeight.w600),
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
              "Application Requirements",
              style: TextStyle(
                color: Color(0xFF000000),
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "What personal info would you like to gather about each applicant?",
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 29),

            /// --- Requirement Toggles ---
            ...requirements.keys.map((req) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        /// Blue circle with checkmark
                        Container(
                          height: 14,
                          width: 14,
                          decoration: const BoxDecoration(
                            color: Color(0xFF007BFF),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 10,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          req,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        _styledToggle(req, "Optional", true),
                        const SizedBox(width: 6),
                        _styledToggle(req, "Required", false),
                      ],
                    ),
                  ],
                ),
              );
            }),

            const SizedBox(height: 32),

            /// --- Buttons ---
            _bottomButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _styledToggle(String field, String value, bool isOptional) {
    bool isSelected = requirements[field] == value;

    Color bgColor;
    Color textColor;

    if (isOptional) {
      bgColor = isSelected ? const Color(0xFF2B7FD0) : const Color(0xFFF1F4F5);
      textColor = isSelected ? Colors.white : const Color(0xFF9EC7DC);
    } else {
      bgColor = isSelected ? Color(0xFF2B7FD0) : const Color(0xFFF1F4F5);
      textColor = isSelected ? Color(0xFF000000) : const Color(0xFF9EC7DC);
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          requirements[field] = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          value,
          style: TextStyle(color: textColor, fontSize: 13),
        ),
      ),
    );
  }

  Widget _bottomButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed:  () => Get.back(),
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
            // Get.snackbar("Next", "Proceeding to next step...");
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
