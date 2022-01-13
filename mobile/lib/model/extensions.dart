import 'package:flutter/material.dart';
import 'package:vibration/theme.dart';

class Extensions {
  static Color GetRandomColor() => Colors.primaries.getRandom();
  static bool isNullOrEmpty(String? value) {
    if (value == null) {
      return true;
    }
    return value.length < 1;
  }

// extension StringExtension on String? {
//   bool isNullOrEmpty() {
//     if (this == null) {
//       return true;
//     }
//     return this!.length > 0;
//   }
}
