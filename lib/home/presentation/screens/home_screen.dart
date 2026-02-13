import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_chef/core/services/service_locator.dart';
import 'package:food_chef/core/theme/color_manager.dart';
import 'package:food_chef/home/presentation/logic/cubit/completed_orders_cubit.dart';
import 'package:food_chef/home/presentation/logic/cubit/orders_cubit.dart';
import 'package:food_chef/home/presentation/logic/cubit/home_cubit.dart';
import 'package:food_chef/home/presentation/logic/cubit/total_orders_cubit.dart';
import 'package:food_chef/home/presentation/logic/cubit/send_data_cubit.dart';
import 'package:food_chef/home/presentation/logic/cubit/users_cubit.dart';
import 'package:food_chef/auth/presentation/screens/log_in_screen.dart';
import 'package:food_chef/auth/presentation/logic/cubit/auth_cubit.dart';
import 'package:food_chef/home/presentation/widgets/nav_tap.dart';
import 'package:food_chef/home/presentation/widgets/orders_screen.dart';
import 'package:food_chef/profile/presentation/logic/user_cubit.dart';
import 'package:food_chef/profile/presentation/screens/profile_screen.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.imagePath});

  final String? imagePath;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<HomeCubit>()),
        BlocProvider(create: (context) => getIt<CompletedOrdersCubit>()),
        BlocProvider(create: (context) => getIt<TotalOrdersCubit>()),
        BlocProvider(create: (context) => getIt<SendDataCubit>()),
        BlocProvider(
          create: (context) =>
              getIt<UserCubit>()
                ..getUserData(getIt<FirebaseAuth>().currentUser!.uid),
        ),
        BlocProvider(create: (context) => getIt<OrdersCubit>()..getOrders()),
        BlocProvider(create: (context) => getIt<UsersCubit>()..getUsers()),
      ],
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSignedOut) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const LogInScreen()),
              (route) => false,
            );
          }
        },
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            int currentIndex = 0;
            if (state is HomeInitial) currentIndex = state.index;
            if (state is HomeTabChanged) currentIndex = state.index;
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                elevation: 0,
                title: BlocBuilder<UserCubit, UserState>(
                  builder: (context, state) {
                    if (state is UserError) {
                      return Text(
                        "Error While Loading",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      );
                    }
                    return Skeletonizer(
                      enabled: state is UserLoading,
                      child: Text(
                        state is UserLoaded
                            ? state.chef.name[0].toUpperCase() +
                                  state.chef.name.substring(1)
                            : "Loading",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    );
                  },
                ),
                actions: [
                  Container(
                    width: 40.w,
                    height: 40.h,
                    margin: EdgeInsets.only(right: 16.w),
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: widget.imagePath != null
                        ? Image.file(File(widget.imagePath!), fit: BoxFit.cover)
                        : Icon(
                            Icons.person,
                            color: ColorsManager.primary,
                            size: 25.w,
                          ),
                  ),
                ],
              ),
              body: BottomBar(
                fit: StackFit.expand,
                borderRadius: BorderRadius.circular(500),
                duration: const Duration(milliseconds: 500),
                curve: Curves.decelerate,
                width: MediaQuery.of(context).size.width * 0.9,
                barColor: Colors.white,
                barDecoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(500),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      blurRadius: 15,
                      spreadRadius: 2,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                start: 2,
                end: 0,
                body: (context, controller) {
                  return TabBarView(
                    controller: tabController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: const [OrdersScreen(), ProfileScreen()],
                  );
                },
                child: TabBar(
                  controller: tabController,
                  splashFactory: NoSplash.splashFactory,
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  dividerColor: Colors.transparent,
                  indicatorColor: Colors.transparent,
                  onTap: (index) {
                    context.read<HomeCubit>().changeTab(index);
                  },
                  tabs: [
                    NavTap(
                      icon: Icons.dashboard_outlined,
                      isActive: currentIndex == 0,
                    ),
                    NavTap(
                      icon: Icons.person_outline,
                      isActive: currentIndex == 1,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
