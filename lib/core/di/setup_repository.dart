import 'package:get/get.dart';
import 'package:karlfive/features/create%20job/data/repo/category_repo_impl.dart';
import 'package:karlfive/features/create%20job/domain/repo/category_repo.dart';

void setupRepository() {
  Get.lazyPut<CategoryRepository>(
    () => CategoryRepoImpl(apiClient: Get.find()),
    fenix: true,
  );
}
