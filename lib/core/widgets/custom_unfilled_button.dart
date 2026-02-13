import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_chef/core/theme/color_manager.dart';
import 'package:gap/gap.dart';

class CustomUnfilledButton extends StatelessWidget {
  const CustomUnfilledButton({
    super.key,
    required this.text,
    required this.onTap,
    this.isIcon = false,
  });

  final String text;
  final Function onTap;
  final bool isIcon;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 20).h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(width: 1, color: ColorsManager.primary),
        ),
        child: Row(
          mainAxisAlignment: .center,
          children: [
            if (isIcon) Icon(Icons.add, color: ColorsManager.primary),
            if (isIcon) Gap(10.w),
            Text(
              text,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: .w900,
                color: ColorsManager.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}