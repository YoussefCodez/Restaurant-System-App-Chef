import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_chef/core/theme/color_manager.dart';

class NavTap extends StatelessWidget {
  const NavTap({super.key, required this.icon, required this.isActive});

  final IconData icon;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Tab(
      icon: Icon(
        icon,
        size: 28.sp,
        color: isActive ? ColorsManager.primary : ColorsManager.holderColor2,
      ),
    );
  }
}