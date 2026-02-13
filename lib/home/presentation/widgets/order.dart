import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_chef/core/theme/color_manager.dart';
import 'package:gap/gap.dart';

class Order extends StatelessWidget {
  const Order({super.key, required this.number, required this.title});
  final int number;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(15.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Text(
              "${number < 10 ? "0$number" : number}",
              style: TextStyle(
                fontSize: 50.sp,
                fontWeight: .w900,
                color: Colors.black,
              ),
            ),
            Gap(5.h),
            Text(
              title,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: .bold,
                color: ColorsManager.holderColor2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
