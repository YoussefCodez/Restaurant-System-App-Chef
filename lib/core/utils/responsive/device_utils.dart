import 'package:flutter/material.dart';

class DeviceUtils {
  DeviceUtils._();

  static bool isTablet(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return size.shortestSide >= 600;
  }
}