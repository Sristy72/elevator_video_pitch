import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:karlfive/core/init/app_initializer.dart';
import 'package:karlfive/core/theme/app_theme.dart';
import 'features/auth/presentation/screens/splash_screen.dart';
import 'package:karlfive/core/common/constants/stripe_key.dart';

import 'features/company/presentation/screens/company_details_screen.dart';
import 'features/company/presentation/screens/company_screen.dart';
import 'features/company/presentation/screens/job_details_screem.dart';
import 'features/company/presentation/screens/manage_job_req_screen.dart';
import 'features/create job/presentation/screens/create_application_req.dart';
import 'features/create job/presentation/screens/create_job_screen.dart';
import 'features/create job/presentation/screens/create_question_screen.dart';

void main() async {
  await AppInitializer.initializeApp();

  // Stripe.publishableKey = StripeKey
  //     .publishableKey;
  // Stripe.merchantIdentifier =
  //     'merchant.com.yourapp';
  // await Stripe.instance.applySettings();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KarlFive',
      theme: AppTheme.light,
      // home: SplashScreen(),
      home: CreateCompanyAccountPage(),
    );
  }
}
