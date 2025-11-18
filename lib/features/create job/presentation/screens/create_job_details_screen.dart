import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:intl/intl.dart';
import 'package:karlfive/features/create%20job/presentation/screens/create_application_req.dart';
import 'package:table_calendar/table_calendar.dart';

import '../controller/create_job_controller.dart';
import 'widget/progress_indicator_widget.dart';

class JobDescriptionScreen extends StatelessWidget {
  JobDescriptionScreen({super.key});

  final CreateJobPostingController controller = Get.find();

  /// HTML Editor
  final HtmlEditorController _jobDescriptionController = HtmlEditorController();

  /// Rx State
  final RxBool publishNow = true.obs;
  final Rx<DateTime?> selectedDate = Rx<DateTime?>(null);

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
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Progress bar (Step 2 active)
            JobProgressBar(),
            const SizedBox(height: 20),

            /// --- Job Description ---
            const Text(
              "Job Description",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),

            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(8),
              child: HtmlEditor(
                controller: _jobDescriptionController,
                htmlEditorOptions: HtmlEditorOptions(
                  hint: "Write the full job description here...",
                  shouldEnsureVisible: true,
                ),
                htmlToolbarOptions: HtmlToolbarOptions(
                  defaultToolbarButtons: [
                    StyleButtons(),
                    FontSettingButtons(),
                    ColorButtons(),
                    ListButtons(),
                    ParagraphButtons(),
                  ],
                  toolbarPosition: ToolbarPosition.belowEditor,
                ),
                otherOptions: OtherOptions(height: 200),
              ),
            ),

            const SizedBox(height: 24),

            /// --- Tip Section ---
            _tipSection(),

            const SizedBox(height: 45),

            /// --- Publish Now Toggle ---
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Publish Now",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,color: Color(0xFF000000)),
                  ),
                  Switch(
                    value: publishNow.value,
                    onChanged: (val) => publishNow.value = val,
                    activeColor: Colors.blue,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 33),

            /// --- Schedule Publish ---
            const Text(
              "Schedule Publish",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,color:  Color(0xFF000000)),
            ),
            const SizedBox(height: 8),

            Obx(
              () => Opacity(
                opacity: publishNow.value ? 0.4 : 1,
                child: IgnorePointer(
                  ignoring: publishNow.value,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    
                 
                
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: SizedBox(
                      height: 280,
                      child: TableCalendar(
                        firstDay: DateTime.utc(2020, 1, 1),
                        lastDay: DateTime.utc(2030, 12, 31),
                        focusedDay: selectedDate.value ?? DateTime.now(),
                        rowHeight: 32,
                        selectedDayPredicate: (day) =>
                            selectedDate.value != null &&
                            isSameDay(selectedDate.value, day),
                        onDaySelected: (selectedDay, _) {
                          selectedDate.value = selectedDay;
                        },
                        headerStyle: const HeaderStyle(
                          formatButtonVisible: false,
                          titleCentered: true,
                          titleTextStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        daysOfWeekStyle: DaysOfWeekStyle(
                          weekdayStyle: const TextStyle(color: Colors.black87),
                          weekendStyle: const TextStyle(color: Colors.black87),
                          dowTextFormatter: (date, locale) {
                            if (date.weekday == DateTime.sunday) {
                              return 'Sun';
                            }
                            return DateFormat.E(locale).format(date);
                          },
                        ),
                        calendarBuilders: CalendarBuilders(
                          defaultBuilder: (context, day, _) {
                            final isSunday = day.weekday == DateTime.sunday;
                            return Center(
                              child: Text(
                                '${day.day}',
                                style: TextStyle(
                                  color: isSunday ? Colors.red : Colors.black87,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          },
                          selectedBuilder: (context, day, _) {
                            return Container(
                              decoration: const BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                '${day.day}',
                                style: const TextStyle(color: Colors.white),
                              ),
                            );
                          },
                          todayBuilder: (context, day, _) {
                            return Container(
                              decoration: const BoxDecoration(
                                color: Colors.black12,
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                '${day.day}',
                                style: TextStyle(
                                  color: day.weekday == DateTime.sunday
                                      ? Colors.red
                                      : Colors.black,
                                ),
                              ),
                            );
                          },
                        ),
                        calendarStyle: const CalendarStyle(
                          outsideDaysVisible: false,
                          todayDecoration: BoxDecoration(
                            color: Colors.black12,
                            shape: BoxShape.circle,
                          ),
                          selectedDecoration: BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                          selectedTextStyle: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ),

            const SizedBox(height: 32),

            /// --- Buttons ---
            _bottomButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _tipSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.info_outline, color: Colors.blue, size: 20),
            const SizedBox(width: 6),
            Expanded(
              child: RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: "TIP:\n\n",
                      style: TextStyle(
                        color: Color(0xFF2B7FD0),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text:
                          // "Job boards will often reject jobs that do not have quality job descriptions. "
                          "To ensure that your job description matches the requirements for job boards, consider the following guidelines:\n\n"
                          // "• Job descriptions should be clear, well-written, and informative\n"
                          // "• Job descriptions with 700–2,000 characters get the most interaction\n"
                          // "• Avoid discriminatory or inappropriate content\n"
                          "• Do not discriminatory language\n"
                          "• Help the candidate understand expectations for this role\n\n",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 26),
          child: RichText(
            text: TextSpan(
              children: [
                const TextSpan(
                  text: "For more tips on writing good job descriptions, ",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: "read our article",
                  style: const TextStyle(
                    color: Color(0xFF2B7FD0),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      print("Read our article clicked");
                    },
                ),
              ],
            ),
          ),
        ),
      ],
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
            controller.goToStep(2);
            Get.to(()=>ApplicationReqScreen(),transition: Transition.rightToLeft);
            // Get.snackbar("Next", "Proceeding to Application Requirements...");
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
