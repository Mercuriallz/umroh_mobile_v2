import 'package:flutter/material.dart';
import 'package:mobile_umroh_v2/constant/color_constant.dart';


class TextConfig {
  static const TextStyle fontHeadline = TextStyle(fontSize: 18);

  static const TextStyle fontTitle = TextStyle(fontSize: 16); //14;
  static const TextStyle buttonLarge = TextStyle(fontSize: 14); //14;

  static const TextStyle titleLarge = TextStyle(
    fontWeight: FontWeight.w600,
    letterSpacing: 1,
    fontSize: 16,
  );
  static const TextStyle titleMedium = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 14,
  );

  static const TextStyle headlineLarge = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 14,
  );
  static const TextStyle bodyMedium = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 14,
  );

  static const TextStyle bodySmall = TextStyle(fontSize: 14);

  static const TextStyle alertLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle alertMedium = TextStyle(
    fontSize: 12,   
    color: ColorConstant.outline,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle alertSmall = TextStyle(
    fontSize: 12,
    color: ColorConstant.outline,
  );

  static const TextStyle fontBody = TextStyle(fontSize: 14); // 12
}
