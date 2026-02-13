import 'package:food_chef/core/entities/chef_entity.dart';
import 'package:food_chef/profile/domain/repositories/profile_repo.dart';

class GetUserData {
  final ProfileRepo profileRepo;
  GetUserData({required this.profileRepo});

  Future<ChefEntity> call(String uid) {
    return profileRepo.getProfile(uid);
  }
}