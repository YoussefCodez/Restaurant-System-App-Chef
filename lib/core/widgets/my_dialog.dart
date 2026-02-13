
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_chef/core/theme/color_manager.dart';
import 'package:gap/gap.dart';

class MyDialog extends StatelessWidget {
  const MyDialog({
    super.key,
    required this.message,
  });
  final String message;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 200.h,
        width: 200.w,
        decoration: BoxDecoration(
          color: ColorsManager.holderColor,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Text(
              message,
              textAlign: .center,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: .bold,
                color: Colors.black,
              ),
            ),
            Gap(30.h),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 40.h,
                width: 100.w,
                decoration: BoxDecoration(
                  color: ColorsManager.primary,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Center(
                  child: Text(
                    "OK",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: .bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}