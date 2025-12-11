import '../../../../core/network/network_result.dart';
import '../../data/models/create_resume_request.dart';
import '../../data/models/create_resume_response.dart';

abstract class ResumeRepository {
  NetworkResult<CreateResumeResponse> createResume(CreateResumeRequest request);
}
