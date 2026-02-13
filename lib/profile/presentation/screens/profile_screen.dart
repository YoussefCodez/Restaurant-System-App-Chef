import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_chef/auth/presentation/logic/cubit/auth_cubit.dart';
import 'package:food_chef/auth/presentation/screens/log_in_screen.dart';
import 'package:food_chef/core/theme/color_manager.dart';
import 'package:food_chef/profile/presentation/logic/user_cubit.dart';
import 'package:gap/gap.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        final chef = state is UserLoaded ? state.chef : null;
        final bool isLoading = state is UserLoading || state is UserInitial;
        return Skeletonizer(
          enabled: isLoading,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
            child: Column(
              children: [
                _buildProfileHeader(chef),
                Gap(32.h),
                _buildInfoSection(context, chef),
                Gap(40.h),
                ElevatedButton(
                  onPressed: () {
                    context.read<AuthCubit>().signOut();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LogInScreen(),
                      ),
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.withValues(alpha: 0.1),
                    foregroundColor: Colors.red,
                    elevation: 0,
                    minimumSize: Size(double.infinity, 56.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  child: Text(
                    "Logout",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Gap(100.h),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProfileHeader(dynamic chef) {
    return Column(
      children: [
        Container(
          width: 120.r,
          height: 120.r,
          decoration: BoxDecoration(
            color: ColorsManager.hover,
            shape: BoxShape.circle,
            border: Border.all(color: ColorsManager.primary, width: 3),
            boxShadow: [
              BoxShadow(
                color: ColorsManager.primary.withValues(alpha: 0.2),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Center(
            child: Icon(
              Icons.person_rounded,
              size: 60.r,
              color: ColorsManager.primary,
            ),
          ),
        ),
        Gap(16.h),
        Text(
          chef?.name[0].toUpperCase() + chef?.name.substring(1) ?? "Chef Name",
          textAlign: .center,
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: ColorsManager.thirdColor,
          ),
        ),
        Gap(4.h),
        Text(
          "Master Chef",
          textAlign: .center,
          style: TextStyle(
            fontSize: 14.sp,
            color: ColorsManager.fourthColor,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoSection(BuildContext context, dynamic chef) {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: ColorsManager.holderColor,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        children: [
          _buildInfoRow(
            icon: Icons.monetization_on_outlined,
            label: "Salary",
            value: "${chef?.salary ?? 0} EGP",
          ),
          _divider(),
          _buildInfoRow(
            icon: Icons.email_outlined,
            label: "Email",
            value: chef?.email ?? "email@example.com",
          ),
          _divider(),
          _buildInfoRow(
            icon: Icons.phone_android_rounded,
            label: "Phone",
            value: chef?.phoneNumber ?? "+20 123 456 789",
          ),
          _divider(),
          _buildInfoRow(
            icon: Icons.location_on_outlined,
            label: "Address",
            value: chef?.address ?? "Address Not Provided",
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(icon, color: ColorsManager.primary, size: 22.r),
          ),
          Gap(16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: ColorsManager.fourthColor,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: ColorsManager.thirdColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Divider(color: Colors.white, thickness: 1, height: 1);
  }
}
