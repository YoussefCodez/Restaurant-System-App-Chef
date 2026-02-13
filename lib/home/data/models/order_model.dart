import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_chef/home/data/models/order_item_model.dart';
import 'package:food_chef/home/domain/entities/order_entity.dart';
import 'package:food_chef/home/domain/entities/order_item_entity.dart';

class OrderModel {
  final String? userId;
  final String? orderId;
  final String? paymentMethod;
  final String? deliveryTime;
  final String? status;
  final double? totalPrice;
  final Timestamp? orderTime;
  final List<OrderItemModel>? items;

  OrderModel({
    required this.userId,
    required this.orderId,
    required this.paymentMethod,
    required this.deliveryTime,
    required this.status,
    required this.totalPrice,
    required this.orderTime,
    required this.items,
  });

  OrderModel copyWith({
    String? userId,
    String? orderId,
    String? paymentMethod,
    String? deliveryTime,
    String? status,
    double? totalPrice,
    Timestamp? orderTime,
    List<OrderItemModel>? items,
  }) {
    return OrderModel(
      userId: userId ?? this.userId,
      orderId: orderId ?? this.orderId,
      deliveryTime: deliveryTime ?? this.deliveryTime,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      status: status ?? this.status,
      totalPrice: totalPrice ?? this.totalPrice,
      orderTime: orderTime ?? this.orderTime,
      items: items ?? this.items,
    );
  }

  factory OrderModel.fromDocument(Map<String, dynamic> doc, [String? id]) {
    return OrderModel(
      userId: doc['userId'] ?? "",
      orderId: id ?? doc['orderId'] ?? "",
      deliveryTime: doc['deliveryTime'] ?? "",
      paymentMethod: doc['paymentMethod'] ?? "",
      status: doc['status'] ?? "",
      totalPrice: (doc['totalOrderPrice'] as num?)?.toDouble() ?? 0.0,
      orderTime: doc['orderTime'] ?? Timestamp.now(),
      items: doc['items'] != null
          ? (doc['items'] as List)
                .map<OrderItemModel>(
                  (e) =>
                      OrderItemModel.fromDocument(Map<String, dynamic>.from(e)),
                )
                .toList()
          : <OrderItemModel>[],
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'userId': userId ?? "",
      'orderId': orderId ?? "",
      'deliveryTime': deliveryTime ?? "",
      'paymentMethod': paymentMethod ?? "",
      'status': status ?? "",
      'totalPrice': totalPrice ?? 0.0,
      'orderTime': orderTime ?? Timestamp.now(),
      'items': items != null
          ? items!.map((e) => e.toDocument()).toList()
          : <Map<String, dynamic>>[],
    };
  }

  OrderEntity toEntity() {
    return OrderEntity(
      userId: userId ?? "",
      orderId: orderId ?? "",
      deliveryTime: deliveryTime ?? "",
      paymentMethod: paymentMethod ?? "",
      status: status ?? "",
      totalPrice: totalPrice ?? 0.0,
      orderTime: orderTime ?? Timestamp.now(),
      items: items != null
          ? items!.map<OrderItemEntity>((item) => item.toEntity()).toList()
          : <OrderItemEntity>[],
    );
  }
}
