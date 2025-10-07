import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karlfive/features/create%20job/presentation/screens/widget/searchable_widget.dart';
import '../../controller/create_job_controller.dart';

class CountryCitySelector extends StatelessWidget {
  final CreateJobPostingController controller;

  const CountryCitySelector({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoadingCountries.value) {
        return const Center(child: CircularProgressIndicator());
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: SearchableDropdownField(
                  label: "Country",
                  hintText: "Select country",
                  items: controller.filteredCountries,
                  value: controller.selectedCountry.value.isEmpty
                      ? null
                      : controller.selectedCountry.value,
                  onChanged: (val) {
                    controller.selectedCountry.value = val;
                    controller.selectedCity.value = '';
                    controller.fetchCities(val);
                  },
                  isRequired: true,
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: SearchableDropdownField(
                  label: "City",
                  hintText: controller.selectedCountry.value.isEmpty
                      ? "Select city"
                      : "Select city",
                  items: controller.filteredCities,
                  value: controller.selectedCity.value.isEmpty
                      ? null
                      : controller.selectedCity.value,
                  onChanged: (val) {
                    if (controller.selectedCountry.value.isNotEmpty) {
                      controller.selectedCity.value = val;
                    }
                  },
                  isRequired: true,
                  enabled: controller
                      .selectedCountry
                      .value
                      .isNotEmpty, // keeps dropdown visible but disabled
                ),
              ),
            ],
          ),
          
        ],
      );
    });
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:karlfive/features/create%20job/presentation/screens/widget/searchable_widget.dart';
// import '../../controller/create_job_controller.dart';

// class CountryCitySelector extends StatelessWidget {
//   final CreateJobPostingController controller;

//   const CountryCitySelector({super.key, required this.controller});

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       if (controller.isLoadingCountries.value) {
//         return const Center(child: CircularProgressIndicator());
//       }

//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // ───── Country Dropdown ─────
//           SearchableDropdownField(
//             label: "Country",
//             hintText: "Select country",
//             items: controller.filteredCountries,
//             value: controller.selectedCountry.value.isEmpty
//                 ? null
//                 : controller.selectedCountry.value,
//             onChanged: (val) {
//               controller.selectedCountry.value = val;
//               controller.selectedCity.value = '';
//               controller.fetchCities(val);
//             },
//             isRequired: true,
//           ),
//           const SizedBox(height: 16),

//           // ───── City Dropdown ─────
//           if (controller.selectedCountry.value.isNotEmpty)
//             SearchableDropdownField(
//               label: "City",
//               hintText: "Select city",
//               items: controller.filteredCities,
//               value: controller.selectedCity.value.isEmpty
//                   ? null
//                   : controller.selectedCity.value,
//               onChanged: (val) {
//                 controller.selectedCity.value = val;
//               },
//               isRequired: true,
//             ),
//         ],
//       );
//     });
//   }
// }
