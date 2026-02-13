import 'package:equatable/equatable.dart';
import 'package:food_chef/home/domain/entities/user_entity.dart';

class UserModel extends Equatable {
  final String userId;
  final String name;
  final String email;
  final String? phone;
  final String? address;
  final String? governorate;
  const UserModel({
    required this.userId,
    required this.name,
    required this.email,
    this.phone,
    this.address,
    this.governorate,
  });


  static UserModel fromDocument(Map<String, dynamic> doc) {
    return UserModel(userId: doc['userId']??"", name: doc['name']??"", email: doc['email']??"", phone: doc['phone']??"", address: doc['address']??"", governorate: doc['governorate']??"");
  }


  MyUserEntity toEntity() {
    return MyUserEntity(userId: userId, email: email, name: name, phone: phone ?? "", address: address ?? "", governorate: governorate ?? "");
  }

  @override
  List<Object?> get props => [userId, name, email, phone, address, governorate];
}
