import 'package:karlfive/features/create%20job/data/model/category_response_model.dart';
import 'package:karlfive/features/create%20job/data/model/currency_response_model.dart';
import 'package:karlfive/features/create%20job/domain/repo/category_repo.dart';
import 'package:karlfive/features/create%20job/presentation/controller/currency_controller.dart';

import '../../../../core/network/api_client.dart';
import '../../../../core/network/constants/api_constants.dart';
import '../../../../core/network/network_result.dart';
import '../../domain/repo/currency_repo.dart';

class CurrncyRepoImpl implements CurrencyRepository {
  final ApiClient _apiClient;

  CurrncyRepoImpl({required ApiClient apiClient}) : _apiClient = apiClient;

  @override
  NetworkResult<CurrencyResponseModel> courency() {
    return _apiClient.get<CurrencyResponseModel>(
      ApiConstants.currency.courency,
      // data: request.toJson(),
      fromJsonT: (json) => CurrencyResponseModel.fromJson(json),
      // isFormData: true
    );
  }
}
