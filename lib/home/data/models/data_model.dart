import 'package:food_chef/home/domain/entities/data_entity.dart';

class DataModel {
  final int? completedOrdersCount;
  final int? activeUsers;
  final int? totalOrders;
  DataModel({
    required this.completedOrdersCount,
    required this.activeUsers,
    required this.totalOrders,
  });

  factory DataModel.fromEntity(DataEntity entity) {
    return DataModel(
      completedOrdersCount: entity.completedOrdersCount,
      activeUsers: entity.activeUsers,
      totalOrders: entity.totalOrders,
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'completedOrdersCount': completedOrdersCount ?? 0,
      'activeUsers': activeUsers ?? 0,
      'totalOrders': totalOrders ?? 0,
    };
  }

  DataEntity toEntity() {
    return DataEntity(
      completedOrdersCount: completedOrdersCount,
      activeUsers: activeUsers,
      totalOrders: totalOrders,
    );
  }
}
