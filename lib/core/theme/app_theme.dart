// import 'package:flutter/material.dart';

// import 'package:google_fonts/google_fonts.dart';
// import 'app_colors.dart';

// class AppTheme {
//   static ThemeData get dark => ThemeData(
//     scaffoldBackgroundColor: AppColors.primaryBackground,
//     primaryColor: AppColors.primaryGreen,
//     colorScheme: ColorScheme.dark(primary: AppColors.primaryGreen),

//     textTheme: GoogleFonts.notoSansKrTextTheme(),
//     // appBarTheme: AppBarTheme(
//     //   titleTextStyle: TextStyle(
//     //     color: AppColors.,
//     //     fontSize: 16,
//     //     fontWeight: FontWeight.w600,
//     //   ),
//     // ),
//   );
// }
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: AppColors.primaryBlue,
    colorScheme: ColorScheme.light(primary: AppColors.primaryBlue),

    textTheme: GoogleFonts.robotoTextTheme(),
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: Color(0xFF1A3E74)),
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(
        fontSize: 24,
        color: Color(0xFF1A3E74),
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}