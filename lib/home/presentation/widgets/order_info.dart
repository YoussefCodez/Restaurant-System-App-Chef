import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_chef/home/presentation/logic/cubit/completed_orders_cubit.dart';
import 'package:food_chef/home/presentation/logic/cubit/orders_cubit.dart';
import 'package:food_chef/home/presentation/logic/cubit/users_cubit.dart';
import 'package:food_chef/home/presentation/widgets/order.dart';

class OrderInfo extends StatelessWidget {
  const OrderInfo({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompletedOrdersCubit, int>(
      builder: (context, completedOrdersCount) {
        return BlocBuilder<UsersCubit, UsersState>(
          builder: (context, userState) {
            return BlocBuilder<OrdersCubit, OrdersState>(
              builder: (context, orderState) {
                int activeUsers =
                    userState is UsersLoaded && orderState is OrdersLoaded
                    ? userState.users
                          .where(
                            (user) => orderState.orders.any(
                              (order) => order.userId == user.userId,
                            ),
                          )
                          .length
                    : 0;
                return Column(
                  spacing: 16.h,
                  children: [
                    Row(
                      spacing: 16.w,
                      children: [
                        Order(
                          number: orderState is OrdersLoaded
                              ? orderState.orders.length
                              : 0,
                          title: "Running Orders",
                        ),
                        Order(number: activeUsers, title: "Active Users"),
                      ],
                    ),
                    Row(
                      children: [
                        Order(
                          number: completedOrdersCount,
                          title: "Completed Orders",
                        ),
                      ],
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }
}
