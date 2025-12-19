import 'package:karlfive/core/network/network_result.dart';
import '../../data/models/about_content_model.dart';

abstract class AboutRepository {
  NetworkResult<AboutContentModel> getAboutContent();
}
