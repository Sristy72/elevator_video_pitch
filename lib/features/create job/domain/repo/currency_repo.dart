import 'package:karlfive/features/create%20job/data/model/currency_response_model.dart';

import '../../../../core/network/network_result.dart';

abstract class CurrencyRepository{ 
  NetworkResult<CurrencyResponseModel> courency();
}