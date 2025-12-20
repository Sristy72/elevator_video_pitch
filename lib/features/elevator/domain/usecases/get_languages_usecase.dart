import '../../../../core/network/network_result.dart';
import '../../data/models/language_model.dart';
import '../repositories/language_repository.dart';

class GetLanguagesUseCase {
  final LanguageRepository _repository;

  GetLanguagesUseCase(this._repository);

  NetworkResult<LanguageResponse> call() {
    return _repository.getLanguages();
  }
}
