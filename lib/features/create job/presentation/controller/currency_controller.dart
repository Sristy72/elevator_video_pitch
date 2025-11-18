import 'package:get/get.dart';
import 'package:karlfive/core/utils/debug_print.dart';
import 'package:karlfive/features/create%20job/data/model/currency_response_model.dart';
import 'package:karlfive/features/create%20job/domain/repo/currency_repo.dart';
import '../../../../core/base/base_controller.dart';
import '../../../../core/network/network_result.dart';

class CurrencyController extends BaseController {
  final CurrencyRepository _currencyRepository;

  CurrencyController(this._currencyRepository);

  /// Reactive variables
  final RxBool isLoading = false.obs;
  final RxList<CurrencyData> currencyList = <CurrencyData>[].obs;
  final Rxn<CurrencyData> selectedCurrency = Rxn<CurrencyData>();

  @override
  void onInit() {
    super.onInit();
    fetchCurrencies();
  }

  /// Fetch all currencies from API
  Future<void> fetchCurrencies() async {
    try {
      isLoading.value = true;

      final result = await _currencyRepository.courency();

      result.fold(
        (failure) {
          isLoading.value = false;
          DPrint.log("❌ Error fetching currencies: ${failure.message}");
        },
        (success) {
          isLoading.value = false;

          // Use the flattened currencies list from the response model
          currencyList.assignAll(success.data.currencies);

          DPrint.log("✅ Loaded ${currencyList.length} currencies");
        },
      );
    } catch (e) {
      isLoading.value = false;
      DPrint.log("❌ Exception in fetchCurrencies: $e");
    }
  }

  /// Handle dropdown selection
  void selectCurrency(CurrencyData currency) {
    selectedCurrency.value = currency;
    DPrint.log("💰 Selected currency: ${currency.currencyName} (${currency.code})");
  }
}





// import 'package:get/get.dart';
// import 'package:karlfive/core/utils/debug_print.dart';
// import 'package:karlfive/features/create%20job/data/model/currency_response_model.dart';
// import 'package:karlfive/features/create%20job/domain/repo/currency_repo.dart';
// import '../../../../core/base/base_controller.dart';
// import '../../../../core/network/network_result.dart';

// class CurrencyController extends BaseController {
//   final CurrencyRepository _currencyRepository;

//   CurrencyController(this._currencyRepository);

//   /// Reactive variables
//   final RxBool isLoading = false.obs;
//     final RxList<CurrencyData> currencyList = <CurrencyData>[].obs;
//   // final RxList<CurrencyData> currencyList = <CurrencyData>[].obs;
//   final Rxn<CurrencyData> selectedCurrency = Rxn<CurrencyData>();

//   @override
//   void onInit() {
//     super.onInit();
//     fetchCurrencies();
//   }

//   /// Fetch all currencies from API
//   Future<void> fetchCurrencies() async {
//     try {
//       isLoading.value = true;

//       final result = await _currencyRepository.courency();

//       result.fold(
//         (failure) {
//           isLoading.value = false;
//           DPrint.log("❌ Error fetching currencies: ${failure.message}");
//           // Optionally show user-facing error
//           // showErrorMessage(failure.message ?? "Failed to load currencies");
//         },
//         (success) {
//           isLoading.value = false;
//           currencyList.assignAll(success.currencies);
//           // currencyList.assignAll(success.data.map((e) => e).toList());

//           DPrint.log("✅ Loaded ${currencyList.length} currencies");
//         },
//       );
//     } catch (e) {
//       isLoading.value = false;
//       DPrint.log("❌ Exception in fetchCurrencies: $e");
//       // Optionally show user-facing error
//       // showErrorMessage("Something went wrong while fetching currencies");
//     }
//   }

//   /// Handle dropdown selection
//   void selectCurrency(CurrencyData currency) {
//     selectedCurrency.value = currency;
//     DPrint.log("💰 Selected currency: ${currency.currencyName} (${currency.code})");
//   }
// }




