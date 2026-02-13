import 'package:food_chef/home/domain/entities/user_entity.dart';

abstract class GetUsersRepo {
  Stream<List<MyUserEntity>> getUsers([String? uid]);
}
