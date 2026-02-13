import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_chef/auth/presentation/logic/cubit/obscure_cubit.dart';
import 'package:food_chef/core/theme/color_manager.dart';
import 'package:food_chef/core/utils/responsive/device_utils.dart';

class CustomField extends StatelessWidget {
  CustomField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.validator,
    this.isPassword = false,
    this.isEnabled = true,
  });
  final String hintText;
  final TextEditingController controller;
  final bool isPassword;
  final FormFieldValidator<String?> validator;
  bool isEnabled ;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ObscureCubit(),
      child: BlocBuilder<ObscureCubit, bool>(
        builder: (context, isPasswordObscured) {
          return TextFormField(
            validator: validator,
            controller: controller,
            obscureText: isPassword ? isPasswordObscured : false,
            obscuringCharacter: "*",
            enabled: isEnabled,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: .normal,
              color: Colors.black,
            ),
            cursorColor: ColorsManager.primary,
            cursorWidth: 1.6,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(17.r),
              filled: true,
              fillColor: ColorsManager.inputs,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10.r),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10.r),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 2.w),
                borderRadius: BorderRadius.circular(10.r),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10.r),
              ),
              hint: Text(
                hintText,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: .normal,
                  color: ColorsManager.hint,
                ),
              ),
              suffixIcon: isPassword
                  ? IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        context.read<ObscureCubit>().toggleVisibility();
                      },
                      icon: Icon(
                        isPasswordObscured
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Color(0xFFB4B9CA),
                        size: DeviceUtils.isTablet(context) ? 20.w : 25.w,
                      ),
                    )
                  : null,
            ),
          );
        },
      ),
    );
  }
}