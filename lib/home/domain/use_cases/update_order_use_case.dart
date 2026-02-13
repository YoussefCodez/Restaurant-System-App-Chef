import 'package:food_chef/home/domain/repositories/get_orders_repo.dart';

class UpdateOrderUseCase {
  final GetOrdersRepo _repo;

  UpdateOrderUseCase(this._repo);

  Future<void> call({
    required String orderId,
    required Map<String, dynamic> data,
  }) {
    return _repo.updateOrder(orderId, data);
  }
}
