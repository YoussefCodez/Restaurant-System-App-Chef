import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_chef/home/domain/entities/order_entity.dart';
import 'package:food_chef/home/domain/use_cases/delete_order_use_case.dart';
import 'package:food_chef/home/domain/use_cases/get_orders_use_case.dart';
import 'package:food_chef/home/domain/use_cases/update_order_use_case.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final GetOrdersUseCase getOrdersUseCase;
  final UpdateOrderUseCase updateOrderUseCase;
  final DeleteOrderUseCase deleteOrderUseCase;
  OrdersCubit(
    this.getOrdersUseCase,
    this.updateOrderUseCase,
    this.deleteOrderUseCase,
  ) : super(OrdersInitial());

  StreamSubscription? _ordersSubscription;

  Future<void> deleteOrder(String orderId) async {
    try {
      await deleteOrderUseCase.call(orderId);
    } catch (e) {
      emit(OrdersFailure(message: e.toString()));
    }
  }

  Future<void> updateOrder(String orderId, Map<String, dynamic> data) async {
    try {
      await updateOrderUseCase.call(orderId: orderId, data: data);
    } catch (e) {
      emit(OrdersFailure(message: e.toString()));
    }
  }

  Future<void> getOrders() async {
    emit(OrdersLoading());
    _ordersSubscription?.cancel();
    _ordersSubscription = getOrdersUseCase.call().listen(
      (orders) {
        emit(OrdersLoaded(orders: orders));
      },
      onError: (error) {
        emit(OrdersFailure(message: error.toString()));
      },
    );
  }

  @override
  Future<void> close() {
    _ordersSubscription?.cancel();
    return super.close();
  }
}
