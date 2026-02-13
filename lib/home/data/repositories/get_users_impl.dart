import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_chef/home/data/models/user_model.dart';
import 'package:food_chef/home/domain/entities/user_entity.dart';
import 'package:food_chef/home/domain/repositories/get_users_repo.dart';

class GetUsersImpl implements GetUsersRepo {
  final FirebaseFirestore _firestore;
  GetUsersImpl(this._firestore);
  @override
  Stream<List<MyUserEntity>> getUsers([String? uid]) {
    Query query = _firestore.collection("users");
    if (uid != null) {
      query = query.where("userId", isEqualTo: uid);
    }
    return query.snapshots().map((snapshot) {
      return snapshot.docs
          .map(
            (e) => UserModel.fromDocument(
              e.data() as Map<String, dynamic>,
            ).toEntity(),
          )
          .toList();
    });
  }
}
