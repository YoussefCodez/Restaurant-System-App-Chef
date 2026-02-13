import 'package:equatable/equatable.dart';

class MyUserEntity extends Equatable {
  final String userId;
  final String name;
  final String email;
  final String? phone;
  final String? address;
  final String? governorate;
  const MyUserEntity({
    required this.userId,
    required this.name,
    required this.email,
    this.phone,
    this.address,
    this.governorate,
  });
  @override
  List<Object?> get props => [userId, email, name, phone, address, governorate];
}
