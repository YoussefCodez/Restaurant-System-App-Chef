import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_chef/auth/presentation/logic/cubit/auth_cubit.dart';
import 'package:food_chef/auth/presentation/screens/sign_up_screen.dart';
import 'package:food_chef/core/utils/validators/validators.dart';
import 'package:food_chef/core/widgets/custom_button.dart';
import 'package:food_chef/core/widgets/custom_field.dart';
import 'package:food_chef/core/widgets/custom_field_text.dart';
import 'package:food_chef/core/widgets/my_dialog.dart';
import 'package:food_chef/home/presentation/screens/home_screen.dart';
import 'package:gap/gap.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
                  CustomFieldText(text: "Email"),
                  Gap(10.h),
                  CustomField(
                    hintText: "Enter Your Email",
                    controller: emailController,
                    validator: Valdiator.emailValidator,
                  ),
                  Gap(30.h),
                  CustomFieldText(text: "Password"),
                  Gap(10.h),
                  CustomField(
                    hintText: "Enter Your Password",
                    controller: passwordController,
                    validator: Valdiator.passValidator,
                    isPassword: true,
                  ),
                  Gap(30.h),
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is AuthError) {
                        showDialog(
                          context: context,
                          builder: (_) => MyDialog(message: state.message),
                        );
                      } else if (state is AuthSuccess) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const HomeScreen()),
                        );
                      }
                    },
                    builder: (context, state) {
                      return state is AuthLoading
                          ? const Center(child: CupertinoActivityIndicator())
                          : CustomButton(
                              text: "Log In",
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  context.read<AuthCubit>().logIn(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                            );
                    },
                  ),
                  Gap(20.h),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SignUpScreen(),
                          ),
                        );
                      },
                      child: const Text("Don't have an account? Sign Up"),
                    ),
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
