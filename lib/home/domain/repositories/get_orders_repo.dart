import 'package:food_chef/home/domain/entities/order_entity.dart';

abstract class GetOrdersRepo {
  Stream<List<OrderEntity>> getOrders();
  Future<void> updateOrder(String orderId, Map<String, dynamic> data);
  Future<void> deleteOrder(String orderId);
}
