import '../../../../core/network/api_client.dart';
import '../../../../core/network/constants/api_constants.dart';
import '../../../../core/network/network_result.dart';
import '../../domain/repositories/language_repository.dart';
import '../models/language_model.dart';

class LanguageRepositoryImpl implements LanguageRepository {
  final ApiClient _apiClient;

  LanguageRepositoryImpl({required ApiClient apiClient})
    : _apiClient = apiClient;

  @override
  NetworkResult<LanguageResponse> getLanguages() {
    print('🌐 API Call: ${ApiConstants.language.getLanguages}');
    return _apiClient.get<LanguageResponse>(
      ApiConstants.language.getLanguages,
      fromJsonT: (json) {
        print('🔄 Parsing JSON response...');
        print('🔄 JSON type: ${json.runtimeType}');

        // BaseResponse already extracts the 'data' field, so json is the data array directly
        if (json is List) {
          print('✅ JSON is List with ${json.length} items');
          final languages = json
              .where((e) => e != null && e is Map<String, dynamic>)
              .map((e) => LanguageModel.fromJson(e as Map<String, dynamic>))
              .toList();
          print('✅ Parsed ${languages.length} languages');
          print(
            '📋 First 5: ${languages.take(5).map((e) => e.name).join(", ")}',
          );
          return LanguageResponse(status: 'success', data: languages);
        } else if (json is Map<String, dynamic>) {
          // Fallback if full response is passed
          print('✅ JSON is Map, parsing LanguageResponse');
          final response = LanguageResponse.fromJson(json);
          print('✅ Parsed ${response.data.length} languages');
          return response;
        }

        print('❌ JSON is neither List nor Map, returning error response');
        return LanguageResponse(status: 'error', data: []);
      },
    );
  }
}
