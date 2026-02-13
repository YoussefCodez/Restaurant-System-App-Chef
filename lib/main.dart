import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_chef/auth/presentation/logic/cubit/auth_cubit.dart';
import 'package:food_chef/core/services/service_locator.dart';
import 'package:food_chef/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await setupServiceLocator();

  runApp(
    BlocProvider(create: (context) => getIt<AuthCubit>(), child: const MyApp()),
  );
}
