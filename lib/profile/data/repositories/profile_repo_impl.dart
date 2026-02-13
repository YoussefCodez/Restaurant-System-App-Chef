import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_chef/core/models/chef_model.dart';
import 'package:food_chef/core/entities/chef_entity.dart';
import 'package:food_chef/profile/domain/repositories/profile_repo.dart';

class ProfileRepoImpl implements ProfileRepo {
  final FirebaseFirestore _firestore;
  ProfileRepoImpl(this._firestore);
  @override
  Future<ChefEntity> getProfile(String uid) {
    final data = _firestore.collection("chefs").doc(uid).get();
    return data
        .then((value) => ChefModel.fromDocument(value))
        .then(
          (value) => ChefEntity(
            name: value.name!,
            email: value.email!,
            phoneNumber: value.phoneNumber!,
            address: value.address!,
            salary: value.salary,
          ),
        );
  }

  @override
  Future<void> updateProfile(ChefEntity chef) {
    // TODO: implement updateProfile
    throw UnimplementedError();
  }
}
