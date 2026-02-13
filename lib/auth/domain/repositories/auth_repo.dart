import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_chef/core/entities/chef_entity.dart';

abstract class AuthRepo {
  Future<ChefEntity> signUp({
    required ChefEntity chefEntity,
    required String password,
  });
  Future<ChefEntity> logIn({required String email, required String password});
  Future<void> logOut();
  Stream<User?> get user;
}
