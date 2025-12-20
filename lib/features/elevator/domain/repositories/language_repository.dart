import '../../../../core/network/network_result.dart';
import '../../data/models/language_model.dart';

abstract class LanguageRepository {
  NetworkResult<LanguageResponse> getLanguages();
}
