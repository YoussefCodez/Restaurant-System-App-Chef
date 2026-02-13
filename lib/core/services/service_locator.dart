import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_chef/auth/data/repositories/auth_repo_impl.dart';
import 'package:food_chef/auth/domain/repositories/auth_repo.dart';
import 'package:food_chef/auth/domain/use_cases/login_use_case.dart';
import 'package:food_chef/auth/domain/use_cases/logout_use_case.dart';
import 'package:food_chef/auth/domain/use_cases/sign_up_use_case.dart';
import 'package:food_chef/auth/presentation/logic/cubit/auth_cubit.dart';
import 'package:food_chef/home/data/repositories/get_orders_impl.dart';
import 'package:food_chef/home/data/repositories/get_users_impl.dart';
import 'package:food_chef/home/domain/repositories/get_orders_repo.dart';
import 'package:food_chef/home/domain/repositories/get_users_repo.dart';
import 'package:food_chef/home/domain/use_cases/delete_order_use_case.dart';
import 'package:food_chef/home/domain/use_cases/get_orders_use_case.dart';
import 'package:food_chef/home/domain/use_cases/get_users_use_case.dart';
import 'package:food_chef/home/data/repositories/send_data_impl.dart';
import 'package:food_chef/home/domain/repositories/send_data_repo.dart';
import 'package:food_chef/home/domain/use_cases/send_data_use_case.dart';
import 'package:food_chef/home/presentation/logic/cubit/send_data_cubit.dart';
import 'package:food_chef/home/domain/use_cases/update_order_use_case.dart';
import 'package:food_chef/home/presentation/logic/cubit/completed_orders_cubit.dart';
import 'package:food_chef/home/presentation/logic/cubit/home_cubit.dart';
import 'package:food_chef/home/presentation/logic/cubit/orders_cubit.dart';
import 'package:food_chef/home/presentation/logic/cubit/total_orders_cubit.dart';
import 'package:food_chef/home/presentation/logic/cubit/users_cubit.dart';
import 'package:food_chef/profile/data/repositories/profile_repo_impl.dart';
import 'package:food_chef/profile/domain/repositories/profile_repo.dart';
import 'package:food_chef/profile/domain/use_cases/get_user_data.dart';
import 'package:food_chef/profile/presentation/logic/user_cubit.dart';
import 'package:get_it/get_it.dart';

import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Services
  final sharedPrefs = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );

  // Repositories
  getIt.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(getIt<FirebaseAuth>(), getIt<FirebaseFirestore>()),
  );
  getIt.registerLazySingleton<ProfileRepo>(
    () => ProfileRepoImpl(getIt<FirebaseFirestore>()),
  );
  getIt.registerLazySingleton<GetOrdersRepo>(
    () => GetOrdersImpl(getIt<FirebaseFirestore>()),
  );
  getIt.registerLazySingleton<GetUsersRepo>(
    () => GetUsersImpl(getIt<FirebaseFirestore>()),
  );
  getIt.registerLazySingleton<SendDataRepo>(
    () => SendDataImpl(getIt<FirebaseFirestore>()),
  );

  // Use Cases
  getIt.registerLazySingleton(() => LoginUseCase(authRepo: getIt()));
  getIt.registerLazySingleton(() => SignUpUseCase(authRepo: getIt()));
  getIt.registerLazySingleton(() => LogoutUseCase(authRepo: getIt()));
  getIt.registerLazySingleton(() => GetUserData(profileRepo: getIt()));
  getIt.registerLazySingleton(() => GetOrdersUseCase(getIt()));
  getIt.registerLazySingleton(() => GetUsersUseCase(getIt()));
  getIt.registerLazySingleton(() => UpdateOrderUseCase(getIt()));
  getIt.registerLazySingleton(() => DeleteOrderUseCase(getIt()));
  getIt.registerLazySingleton(() => SendDataUseCase(getIt()));

  // Cubits
  getIt.registerLazySingleton<AuthCubit>(
    () => AuthCubit(getIt(), getIt(), getIt(), getIt<AuthRepo>()),
  );
  getIt.registerFactory(() => UserCubit(getUserDataUseCase: getIt()));
  getIt.registerFactory(() => HomeCubit());
  getIt.registerFactory(() => OrdersCubit(getIt(), getIt(), getIt()));
  getIt.registerFactory(() => UsersCubit(getIt()));
  getIt.registerLazySingleton(() => CompletedOrdersCubit(getIt()));
  getIt.registerLazySingleton(() => TotalOrdersCubit(getIt()));
  getIt.registerFactory(() => SendDataCubit(getIt()));
}
