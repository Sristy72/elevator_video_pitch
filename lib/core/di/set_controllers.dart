import 'package:get/get.dart';
import 'package:karlfive/features/create%20job/presentation/controller/category_controller.dart';


import 'package:karlfive/features/create%20job/presentation/controller/create_job_controller.dart';




void setupController() {
  // Auth Controller
  Get.lazyPut<CategoryController>(
    () => CategoryController(Get.find()),
    fenix: true,
  );

   Get.lazyPut<CreateJobPostingController>(
    () => CreateJobPostingController(Get.find()),
    fenix: true,
  );
 
}
