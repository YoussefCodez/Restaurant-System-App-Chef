import 'package:food_chef/home/domain/repositories/get_orders_repo.dart';

class DeleteOrderUseCase {
  final GetOrdersRepo _repo;

  DeleteOrderUseCase(this._repo);

  Future<void> call(String orderId) {
    return _repo.deleteOrder(orderId);
  }
}
