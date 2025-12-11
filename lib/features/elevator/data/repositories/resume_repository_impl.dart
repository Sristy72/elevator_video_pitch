import '../../../../core/network/api_client.dart';
import '../../../../core/network/constants/api_constants.dart';
import '../../../../core/network/network_result.dart';
import '../../domain/repositories/resume_repository.dart';
import '../models/create_resume_request.dart';
import '../models/create_resume_response.dart';

class ResumeRepositoryImpl implements ResumeRepository {
  final ApiClient _apiClient;

  ResumeRepositoryImpl({required ApiClient apiClient})
      : _apiClient = apiClient;

  @override
  NetworkResult<CreateResumeResponse> createResume(
      CreateResumeRequest request) {
    return _apiClient.post<CreateResumeResponse>(
      '${ApiConstants.baseUrl}/create-resume/create-resume',
      data: request.toJson(),
      fromJsonT: (json) => CreateResumeResponse.fromJson(json),
    );
  }
}
