import 'package:karlfive/features/create%20job/data/model/category_response_model.dart';

import '../../../../core/network/network_result.dart';

abstract class CategoryRepository{ 
  NetworkResult<CategoryResponse> jobCategory();
}