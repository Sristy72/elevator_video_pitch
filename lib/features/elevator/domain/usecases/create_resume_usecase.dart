import '../../../../core/network/network_result.dart';
import '../../data/models/create_resume_request.dart';
import '../../data/models/create_resume_response.dart';
import '../repositories/resume_repository.dart';

class CreateResumeUseCase {
  final ResumeRepository _repository;

  CreateResumeUseCase(this._repository);

  NetworkResult<CreateResumeResponse> call(CreateResumeRequest request) {
    return _repository.createResume(request);
  }
}
