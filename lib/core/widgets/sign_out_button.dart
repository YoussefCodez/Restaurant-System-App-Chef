import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_chef/auth/presentation/logic/cubit/auth_cubit.dart';
import 'package:food_chef/auth/presentation/screens/log_in_screen.dart';

class SignOutButton extends StatelessWidget {
  const SignOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSignedOut) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => LogInScreen()),
          );
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            context.read<AuthCubit>().signOut();
          },
          child: Container(
            margin: EdgeInsets.only(bottom: 20.h),
            padding: EdgeInsets.all(20.r),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.r),
            ),
            child: Text(
              "Sign Out",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSecondaryContainer,
                fontSize: 15.sp,
                fontWeight: .bold,
              ),
            ),
          ),
        );
      },
    );
  }
}