import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class Extensions {
  static Color GetRandomColor() => Colors.primaries[Random().nextInt(Colors.primaries.length)];
}
