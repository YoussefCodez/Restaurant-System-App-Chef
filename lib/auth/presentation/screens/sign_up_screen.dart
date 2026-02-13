import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_chef/core/entities/chef_entity.dart';
import 'package:food_chef/auth/presentation/logic/cubit/auth_cubit.dart';
import 'package:food_chef/auth/presentation/screens/log_in_screen.dart';
import 'package:food_chef/core/theme/color_manager.dart';
import 'package:food_chef/core/widgets/custom_button.dart';
import 'package:food_chef/core/widgets/custom_field.dart';
import 'package:food_chef/core/utils/validators/validators.dart';
import 'package:food_chef/core/widgets/custom_field_text.dart';
import 'package:food_chef/core/widgets/my_dialog.dart';
import 'package:food_chef/home/presentation/screens/home_screen.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ImagePicker picker = ImagePicker();
  XFile? imagePath;
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneNumberController;
  late TextEditingController addressController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneNumberController = TextEditingController();
    addressController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    addressController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(30.r),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset("assets/images/logo.png", width: 150.w),
                  ),
                  Gap(50.h),
                  GestureDetector(
                    onTap: () async {
                      final XFile? image = await picker.pickImage(
                        source: ImageSource.gallery,
                      );
                      setState(() {
                        if (image != null) {
                          imagePath = image;
                        }
                      });
                    },
                    child: Center(
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        padding: imagePath != null
                            ? EdgeInsets.zero
                            : EdgeInsets.all(35.r),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: imagePath != null
                            ? Image.file(
                                File(imagePath!.path),
                                width: 150.w,
                                height: 150.h,
                                fit: BoxFit.cover,
                              )
                            : Icon(
                                Icons.person,
                                color: ColorsManager.primary,
                                size: 35.w,
                              ),
                      ),
                    ),
                  ),
                  Gap(30.h),
                  CustomFieldText(text: "Name"),
                  Gap(10.h),
                  CustomField(
                    hintText: "Enter Your Name",
                    controller: nameController,
                    validator: Valdiator.nameValidator,
                  ),
                  Gap(30.h),
                  CustomFieldText(text: "Email"),
                  Gap(10.h),
                  CustomField(
                    hintText: "Enter Your Email",
                    controller: emailController,
                    validator: Valdiator.emailValidator,
                  ),
                  Gap(30.h),
                  CustomFieldText(text: "Phone Number"),
                  Gap(10.h),
                  CustomField(
                    hintText: "Enter Your Phone Number",
                    controller: phoneNumberController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Phone Number Is Required";
                      }
                      if (value.length != 11) {
                        return "Phone Number Must Be 11 Digits";
                      }
                      return null;
                    },
                  ),
                  Gap(30.h),
                  CustomFieldText(text: "Address"),
                  Gap(10.h),
                  CustomField(
                    hintText: "Enter Your Address",
                    controller: addressController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Address Is Required";
                      }
                      return null;
                    },
                  ),
                  Gap(30.h),
                  CustomFieldText(text: "Password"),
                  Gap(10.h),
                  CustomField(
                    hintText: "Password",
                    controller: passwordController,
                    validator: Valdiator.passValidator,
                    isPassword: true,
                  ),
                  Gap(30.h),
                  CustomFieldText(text: "Confirm Password"),
                  Gap(10.h),
                  CustomField(
                    hintText: "Confirm Password",
                    controller: confirmPasswordController,
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Confirm Password Is Required";
                      }
                      if (value != passwordController.text) {
                        return "Confirm Password Must Be Matched";
                      }
                      return null;
                    },
                  ),
                  Gap(15.h),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const LogInScreen(),
                          ),
                        );
                      },
                      child: const Text("Already have an account? Log In"),
                    ),
                  ),
                  Gap(15.h),
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is AuthError) {
                        showDialog(
                          context: context,
                          builder: (context) =>
                              MyDialog(message: state.message),
                        );
                      } else if (state is AuthSuccess) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                HomeScreen(imagePath: imagePath?.path),
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return CustomButton(
                        text: "Sign Up",
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            context.read<AuthCubit>().signUp(
                              chef: ChefEntity(
                                name: nameController.text,
                                email: emailController.text,
                                phoneNumber: phoneNumberController.text,
                                address: addressController.text,
                              ),
                              password: passwordController.text,
                            );
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
