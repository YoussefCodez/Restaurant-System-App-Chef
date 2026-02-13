import 'package:equatable/equatable.dart';

class OrderItemEntity extends Equatable {
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

  const OrderItemEntity({
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

  @override
  List<Object?> get props => [
    mealId,
    mealImage,
    mealName,
    mealPrice,
    mealQuantity,
    mealTotalPrice,
    mealSize,
    mealSpicey,
    mealType,
    mealAddons,
  ];
}
