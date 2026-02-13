import 'package:food_chef/home/domain/entities/order_item_entity.dart';

class OrderItemModel {
  final String? mealId;
  final String? mealImage;
  final String? mealName;
  final double? mealPrice;
  final int? mealQuantity;
  final double? mealTotalPrice;
  final String? mealSize;
  final String? mealSpicey;
  final String? mealType;
  final List<String>? mealAddons;

  OrderItemModel({
    required this.mealId,
    required this.mealImage,
    required this.mealName,
    required this.mealPrice,
    required this.mealQuantity,
    required this.mealTotalPrice,
    required this.mealSize,
    required this.mealSpicey,
    required this.mealType,
    required this.mealAddons,
  });

  OrderItemEntity toEntity() {
    return OrderItemEntity(
      mealId: mealId ?? "",
      mealImage: mealImage ?? "",
      mealName: mealName ?? "",
      mealPrice: mealPrice ?? 0.0,
      mealQuantity: mealQuantity ?? 0,
      mealTotalPrice: mealTotalPrice ?? 0.0,
      mealSize: mealSize ?? "",
      mealSpicey: mealSpicey ?? "",
      mealType: mealType ?? "",
      mealAddons: mealAddons ?? [],
    );
  }

  factory OrderItemModel.fromDocument(Map<String, dynamic> doc) {
    return OrderItemModel(
      mealId: doc['mealId'] ?? "",
      mealImage: doc['mealImage'] ?? "",
      mealName: doc['mealName'] ?? "",
      mealPrice: doc['mealPrice'] ?? 0.0,
      mealQuantity: doc['orderItemQuantity'] ?? 0,
      mealTotalPrice: doc['orderItemTotalPrice'] ?? 0.0,
      mealSize: doc['mealSize'] ?? "",
      mealSpicey: doc['mealSpicey'] ?? "",
      mealType: doc['mealType'] ?? "",
      mealAddons: List<String>.from(doc['mealToAdd'] ?? <String>[]),
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'mealId': mealId ?? "",
      'mealImage': mealImage ?? "",
      'mealName': mealName ?? "",
      'mealPrice': mealPrice ?? 0.0,
      'mealQuantity': mealQuantity ?? 0,
      'mealTotalPrice': mealTotalPrice ?? 0.0,
      'mealSize': mealSize ?? "",
      'mealAddons': mealAddons ?? [],
    };
  }
}
