import 'package:food_chef/core/entities/chef_entity.dart';

abstract class ProfileRepo {
  Future<ChefEntity> getProfile(String uid);
  Future<void> updateProfile(ChefEntity chef);
}