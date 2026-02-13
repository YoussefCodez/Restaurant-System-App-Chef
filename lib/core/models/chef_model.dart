import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ChefModel extends Equatable {
  final String? uid;
  final String? name;
  final String? email;
  final String? phoneNumber;
  final String? address;
  final double? salary;

  const ChefModel({
    this.uid,
    this.name,
    this.email,
    this.phoneNumber,
    this.address,
    this.salary,
  });

  ChefModel toEntity() {
    return ChefModel(
      uid: uid ?? "",
      name: name ?? "",
      email: email ?? "",
      phoneNumber: phoneNumber ?? "",
      address: address ?? "",
      salary: salary ?? 0,
    );
  }

  factory ChefModel.fromEntity(ChefModel chef) {
    return ChefModel(
      uid: chef.uid,
      name: chef.name,
      email: chef.email,
      phoneNumber: chef.phoneNumber,
      address: chef.address,
      salary: chef.salary,
    );
  }

  factory ChefModel.fromDocument(DocumentSnapshot doc) {
    return ChefModel(
      uid: doc.id,
      name: doc['name'],
      email: doc['email'],
      phoneNumber: doc['phoneNumber'],
      address: doc['address'],
      salary: doc['salary'],
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'address': address,
      'salary': salary,
    };
  }

  static ChefModel empty = ChefModel(
    uid: "",
    name: "",
    email: "",
    phoneNumber: "",
    address: "",
    salary: 1500,
  );

  ChefModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? phoneNumber,
    String? address,
    double? salary,
  }) {
    return ChefModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      salary: salary ?? this.salary,
    );
  }

  @override
  List<Object?> get props => [uid, name, email, phoneNumber, address, salary];
}
