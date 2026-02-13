import 'package:food_chef/core/entities/chef_entity.dart';
import 'package:food_chef/auth/domain/repositories/auth_repo.dart';

class LoginUseCase {
  final AuthRepo authRepo;
  LoginUseCase({required this.authRepo});

  Future<ChefEntity> call({required String email, required String password}) async {
    return await authRepo.logIn(email: email, password: password);
  }
}