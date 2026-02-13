import 'package:food_chef/home/domain/entities/order_entity.dart';
import 'package:food_chef/home/domain/repositories/get_orders_repo.dart';

class GetOrdersUseCase {
  final GetOrdersRepo getOrdersRepo;
  GetOrdersUseCase(this.getOrdersRepo);
  Stream<List<OrderEntity>> call() {
    return getOrdersRepo.getOrders();
  }
}
