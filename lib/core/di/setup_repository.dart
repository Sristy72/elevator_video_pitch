import 'package:get/get.dart';

import '../../features/auth/data/repo/auth_repo_impl.dart';
import '../../features/auth/domain/repo/auth_repo.dart';


void setupRepository() {
  Get.lazyPut<AuthRepository>(
    () => AuthRepositoryImpl(apiClient: Get.find()),
    fenix: true,
  );

  // Get.lazyPut<UserInfoRepo>(
  //   () => UserInfoRepoImpl(apiClient: Get.find()),
  //   fenix: true,
  // );

  // Get.lazyPut<JoinLeagueRepository>(
  //   () => JoinLeagueRepositoryImpl(apiClient: Get.find()),
  //   fenix: true,
  // );

  // Get.lazyPut<ContactUsRepo>(
  //   () => ContactUsRepoImpl(apiClient: Get.find()),
  //   fenix: true,
  // );

  // // User profile repo & controller
  // Get.lazyPut<UserProfileRepo>(
  //   () => UserProfileRepoImpl(apiClient: Get.find()),
  //   fenix: true,
  // );

  // Get.lazyPut<ProfileController>(
  //   () => ProfileController(repository: Get.find()),
  //   fenix: true,
  // );

  // // Edit profile controller (uses existing UserInfoRepo)
  // Get.lazyPut(
  //   () => EditProfileController(Get.find<UserInfoRepo>()),
  //   fenix: true,
  // );

  // // Team details
  // Get.lazyPut<TeamRepo>(() => TeamRepoImpl(apiClient: Get.find()), fenix: true);

  // Get.lazyPut<TeamController>(
  //   () => TeamController(repo: Get.find()),
  //   fenix: true,
  // );

  // // Register server-side payment API repository (used by CreatePayment API flow)
  // Get.lazyPut<PaymentApiRepository>(
  //   () => PaymentApiRepositoryImpl(Get.find()),
  //   fenix: true,
  // );

  // // Register Stripe payment repository implementation
  // Get.lazyPut<PaymentRepository>(
  //   () => PaymentRepositoryStripeImpl(Get.find()),
  //   fenix: true,
  // );

  // Get.lazyPut<HomeRepository>(
  //   () => HomeRepositoryImpl(apiClient: Get.find()),
  //   fenix: true,
  // );

  // Get.lazyPut<LeagueRepository>(
  //   () => LeagueRepositoryImpl(apiClient: Get.find()),
  //   fenix: true,
  // );

  // Get.lazyPut<UserInfoRepo>(
  //   () => UserInfoRepoImpl(apiClient: Get.find()),
  //   fenix: true,
  // );
}
