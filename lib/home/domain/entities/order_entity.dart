import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:food_chef/home/domain/entities/order_item_entity.dart';

class OrderEntity extends Equatable {
  final String? userId;
  final String? orderId;
  final String? deliveryTime;
  final String? status;
  final String? paymentMethod;
  final double? totalPrice;
  final Timestamp? orderTime;
  final List<OrderItemEntity>? items;

  const OrderEntity({
    required this.userId,
    required this.orderId,
    required this.deliveryTime,
    required this.status,
    required this.paymentMethod,
    required this.totalPrice,
    required this.orderTime,
    required this.items,
  });

  @override
  List<Object?> get props => [
    userId,
    orderId,
    deliveryTime,
    status,
    paymentMethod,
    totalPrice,
    orderTime,
    items,
  ];
}
