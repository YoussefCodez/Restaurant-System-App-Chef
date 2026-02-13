import 'package:food_chef/home/domain/entities/user_entity.dart';
import 'package:food_chef/home/domain/repositories/get_users_repo.dart';

class GetUsersUseCase {
  final GetUsersRepo _repo;
  GetUsersUseCase(this._repo);
  Stream<List<MyUserEntity>> call([String? uid]) {
    return _repo.getUsers(uid);
  }
}
