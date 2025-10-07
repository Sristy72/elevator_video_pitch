import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karlfive/core/init/app_initializer.dart';
import 'package:karlfive/core/theme/app_theme.dart';
import 'features/create job/presentation/screens/create_job_screen.dart';

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
      home: CreateJobPostingScreen(),
    );
  }
}
