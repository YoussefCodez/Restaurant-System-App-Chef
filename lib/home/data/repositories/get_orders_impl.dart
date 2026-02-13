import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_chef/home/data/models/order_model.dart';
import 'package:food_chef/home/domain/entities/order_entity.dart';
import 'package:food_chef/home/domain/repositories/get_orders_repo.dart';

class GetOrdersImpl implements GetOrdersRepo {
  final FirebaseFirestore _firestore;

  GetOrdersImpl(this._firestore);

  @override
  Stream<List<OrderEntity>> getOrders() {
    return _firestore
        .collection('orders')
        .orderBy('orderedAt', descending: false)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return OrderModel.fromDocument(doc.data(), doc.id).toEntity();
          }).toList();
        });
  }

  @override
  Future<void> updateOrder(String orderId, Map<String, dynamic> data) {
    return _firestore.collection('orders').doc(orderId).update(data);
  }

  @override
  Future<void> deleteOrder(String orderId) {
    return _firestore.collection('orders').doc(orderId).delete();
  }
}
