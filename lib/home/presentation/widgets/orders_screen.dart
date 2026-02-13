import 'package:cached_network_image/cached_network_image.dart';
import 'package:food_chef/home/domain/entities/data_entity.dart';
import 'package:food_chef/home/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_chef/core/theme/color_manager.dart';
import 'package:food_chef/home/presentation/logic/cubit/completed_orders_cubit.dart';
import 'package:food_chef/home/presentation/logic/cubit/orders_cubit.dart';
import 'package:food_chef/home/presentation/logic/cubit/send_data_cubit.dart';
import 'package:food_chef/home/presentation/logic/cubit/total_orders_cubit.dart';
import 'package:food_chef/home/presentation/logic/cubit/users_cubit.dart';
import 'package:food_chef/home/presentation/widgets/order_info.dart';
import 'package:gap/gap.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:vibration/vibration.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  int? _lastOrdersCount;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const OrderInfo(),
          Gap(24.h),
          Text(
            "Running Orders",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Gap(16.h),
          BlocBuilder<UsersCubit, UsersState>(
            builder: (context, userState) {
              return BlocListener<OrdersCubit, OrdersState>(
                listenWhen: (previous, current) => current is OrdersLoaded,
                listener: (context, state) {
                  if (state is OrdersLoaded) {
                    Vibration.vibrate(duration: 500);
                    if (_lastOrdersCount == null) {
                      _lastOrdersCount = state.orders.length;
                    } else if (state.orders.length > _lastOrdersCount!) {
                      int difference = state.orders.length - _lastOrdersCount!;
                      context.read<TotalOrdersCubit>().increment(difference);
                      _lastOrdersCount = state.orders.length;
                    } else {
                      _lastOrdersCount = state.orders.length;
                    }
                    if (userState is UsersLoaded) {
                      context.read<SendDataCubit>().sendData(
                        DataEntity(
                          completedOrdersCount: context
                              .read<CompletedOrdersCubit>()
                              .state,
                          activeUsers: userState.users
                              .where(
                                (user) => state.orders.any(
                                  (order) => order.userId == user.userId,
                                ),
                              )
                              .length,
                          totalOrders: context.read<TotalOrdersCubit>().state,
                        ),
                      );
                    }
                  }
                },
                child: BlocBuilder<OrdersCubit, OrdersState>(
                  builder: (context, orderState) {
                    if (orderState is OrdersFailure) {
                      return Center(
                        child: Text(
                          orderState.message,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: ColorsManager.primary,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }
                    if (orderState is OrdersLoaded &&
                        orderState.orders.isEmpty) {
                      return Center(
                        child: Text(
                          "No orders yet",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: ColorsManager.primary,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }
                    return Skeletonizer(
                      enabled: orderState is OrdersLoading,
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: orderState is OrdersLoaded
                            ? orderState.orders.length
                            : 4,
                        separatorBuilder: (context, index) => Gap(16.h),
                        itemBuilder: (context, index) {
                          final order = orderState is OrdersLoaded
                              ? orderState.orders[index]
                              : null;
                          final customerOwner =
                              (userState is UsersLoaded && order != null)
                              ? userState.users.firstWhere(
                                  (u) => u.userId == order.userId,
                                  orElse: () => const MyUserEntity(
                                    userId: '',
                                    name: 'Unknown',
                                    email: '',
                                  ),
                                )
                              : null;
                          return Container(
                            padding: EdgeInsets.all(12.r),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (userState is UsersError)
                                  Text(
                                    userState.message,
                                    style: TextStyle(
                                      color: ColorsManager.primary,
                                      fontSize: 14.sp,
                                      fontWeight: .bold,
                                    ),
                                  )
                                else
                                  Skeletonizer(
                                    enabled: userState is UsersLoading,
                                    child: Padding(
                                      padding: EdgeInsets.only(bottom: 12.h),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.person_outline,
                                            size: 20.r,
                                            color: ColorsManager.primary,
                                          ),
                                          Gap(8.w),
                                          Expanded(
                                            child: Text(
                                              customerOwner?.name ??
                                                  "Unknown Customer",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                Skeletonizer(
                                  enabled: userState is UsersLoading,
                                  child: Padding(
                                    padding: EdgeInsets.only(bottom: 12.h),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.home_outlined,
                                          size: 20.r,
                                          color: ColorsManager.primary,
                                        ),
                                        Gap(8.w),
                                        Expanded(
                                          child: Text(
                                            customerOwner != null
                                                ? "${customerOwner.address}, ${customerOwner.governorate ?? ""}"
                                                : (userState is UsersLoading
                                                      ? "Loading..."
                                                      : "No Address"),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16.sp,
                                              fontWeight: .bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Skeletonizer(
                                  enabled: userState is UsersLoading,
                                  child: Padding(
                                    padding: EdgeInsets.only(bottom: 12.h),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.phone_outlined,
                                          size: 20.r,
                                          color: ColorsManager.primary,
                                        ),
                                        Gap(8.w),
                                        Expanded(
                                          child: Text(
                                            customerOwner?.phone ?? "No Phone",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16.sp,
                                              fontWeight: .bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Skeletonizer(
                                  enabled: userState is UsersLoading,
                                  child: Padding(
                                    padding: EdgeInsets.only(bottom: 12.h),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.payment,
                                          size: 20.r,
                                          color: ColorsManager.primary,
                                        ),
                                        Gap(8.w),
                                        Expanded(
                                          child: Text(
                                            order?.paymentMethod ??
                                                "No Payment Method",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16.sp,
                                              fontWeight: .bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Gap(20.h),
                                ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: order?.items?.length ?? 0,
                                  separatorBuilder: (context, index) => Column(
                                    children: [
                                      Gap(12.h),
                                      Divider(
                                        color: ColorsManager.primary.withValues(
                                          alpha: 0.5,
                                        ),
                                        thickness: 1,
                                      ),
                                      Gap(12.h),
                                    ],
                                  ),
                                  itemBuilder: (context, itemIndex) {
                                    final item = order?.items?[itemIndex];
                                    final num pricePerOnce =
                                        (item?.mealPrice ?? 0) /
                                        (item?.mealQuantity ?? 1);
                                    return Row(
                                      children: [
                                        SizedBox(
                                          width: 80.w,
                                          height: 80.h,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              12.r,
                                            ),
                                            child: orderState is OrdersLoading
                                                ? Skeletonizer(
                                                    enabled: true,
                                                    child: Container(
                                                      width: 80.w,
                                                      height: 80.h,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              12.r,
                                                            ),
                                                      ),
                                                      child: Image.asset(
                                                        "assets/images/burger1.png",
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  )
                                                : CachedNetworkImage(
                                                    imageUrl:
                                                        item?.mealImage ?? "",
                                                    fit: BoxFit.cover,
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            const Icon(
                                                              Icons.fastfood,
                                                              color:
                                                                  ColorsManager
                                                                      .primary,
                                                            ),
                                                  ),
                                          ),
                                        ),
                                        Gap(16.w),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                item?.mealName ?? "",
                                                style: Theme.of(
                                                  context,
                                                ).textTheme.headlineLarge,
                                              ),
                                              Gap(4.h),
                                              Text(
                                                "Qty: ${item?.mealQuantity ?? ""}",
                                                style: Theme.of(
                                                  context,
                                                ).textTheme.headlineSmall,
                                              ),
                                              Gap(4.h),
                                              Text(
                                                "Size: ${item?.mealSize ?? ""}",
                                                style: Theme.of(
                                                  context,
                                                ).textTheme.headlineSmall,
                                              ),
                                              Gap(4.h),
                                              Text(
                                                "Spicey: ${item?.mealSpicey ?? ""}",
                                                style: Theme.of(
                                                  context,
                                                ).textTheme.headlineSmall,
                                              ),
                                              if (item?.mealAddons != null &&
                                                  item!
                                                      .mealAddons!
                                                      .isNotEmpty) ...[
                                                Gap(4.h),
                                                Text(
                                                  "Add-ons: ${item.mealAddons?.join(", ") ?? ""}",
                                                  style: Theme.of(
                                                    context,
                                                  ).textTheme.headlineSmall,
                                                ),
                                              ],
                                              Gap(8.h),
                                              Text(
                                                "Price Per Once : ${pricePerOnce.round()} EGP",
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: ColorsManager.primary,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                                Gap(20.h),
                                Text.rich(
                                  TextSpan(
                                    text: "Total Price : ",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                    children: [
                                      TextSpan(
                                        text:
                                            "${order?.totalPrice?.round()} EGP",
                                        style: TextStyle(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w600,
                                          color: ColorsManager.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  color: ColorsManager.primary.withValues(
                                    alpha: 0.3,
                                  ),
                                  thickness: 2,
                                ),
                                Gap(10.h),
                                Row(
                                  children: [
                                    Expanded(
                                      child: _buildDropdown(
                                        context: context,
                                        label: "Status",
                                        value: order?.status,
                                        options: [
                                          "Pending",
                                          "Waiting",
                                          "Out For Delivery",
                                          "Delivered",
                                        ],
                                        onChanged: (val) {
                                          if (val != null &&
                                              order?.orderId != null) {
                                            if (val == "Delivered" &&
                                                order?.deliveryTime ==
                                                    "Delivered") {
                                              context
                                                  .read<OrdersCubit>()
                                                  .deleteOrder(order!.orderId!);
                                            } else {
                                              context
                                                  .read<OrdersCubit>()
                                                  .updateOrder(
                                                    order!.orderId!,
                                                    {'status': val},
                                                  );
                                            }
                                          }
                                        },
                                      ),
                                    ),
                                    Gap(12.w),
                                    Expanded(
                                      child: _buildDropdown(
                                        context: context,
                                        label: "Delivery Time",
                                        value: order?.deliveryTime,
                                        options: [
                                          "5 : 10 Min",
                                          "15 : 30 Min",
                                          "30 : 1 Hour",
                                          "1 : 2 Hour",
                                          "Delivered",
                                        ],
                                        onChanged: (val) {
                                          if (val != null &&
                                              order?.orderId != null) {
                                            if (val == "Delivered" &&
                                                order?.status == "Delivered") {
                                              context
                                                  .read<OrdersCubit>()
                                                  .deleteOrder(order!.orderId!);
                                              context
                                                  .read<CompletedOrdersCubit>()
                                                  .increment();
                                              context.read<SendDataCubit>().sendData(
                                                DataEntity(
                                                  completedOrdersCount: context
                                                      .read<
                                                        CompletedOrdersCubit
                                                      >()
                                                      .state,
                                                  activeUsers:
                                                      userState
                                                              is UsersLoaded &&
                                                          orderState
                                                              is OrdersLoaded
                                                      ? userState.users
                                                            .where(
                                                              (
                                                                user,
                                                              ) => orderState
                                                                  .orders
                                                                  .any(
                                                                    (order) =>
                                                                        order
                                                                            .userId ==
                                                                        user.userId,
                                                                  ),
                                                            )
                                                            .length
                                                      : 0,
                                                  totalOrders: context
                                                      .read<TotalOrdersCubit>()
                                                      .state,
                                                ),
                                              );
                                            } else {
                                              context
                                                  .read<OrdersCubit>()
                                                  .updateOrder(
                                                    order!.orderId!,
                                                    {'deliveryTime': val},
                                                  );
                                            }
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              );
            },
          ),
          Gap(100.h),
        ],
      ),
    );
  }

  Widget _buildDropdown({
    required BuildContext context,
    required String label,
    required String? value,
    required List<String> options,
    required void Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            color: ColorsManager.fourthColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        Gap(4.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: BoxDecoration(
            color: ColorsManager.holderColor,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: ColorsManager.primary.withValues(alpha: 0.1),
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: options.contains(value) ? value : null,
              isExpanded: true,
              hint: Text("Select $label", style: TextStyle(fontSize: 12.sp)),
              items: options.map((String val) {
                return DropdownMenuItem<String>(
                  value: val,
                  child: Text(
                    val,
                    style: TextStyle(fontSize: 13.sp, color: Colors.black),
                  ),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
