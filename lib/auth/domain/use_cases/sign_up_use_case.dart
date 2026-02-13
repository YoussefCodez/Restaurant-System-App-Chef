import 'package:food_chef/core/entities/chef_entity.dart';
import 'package:food_chef/auth/domain/repositories/auth_repo.dart';

class SignUpUseCase {
  final AuthRepo authRepo;
  SignUpUseCase({required this.authRepo});

  Future<ChefEntity> call({required ChefEntity chefEntity, required String password}) async {
    return await authRepo.signUp(chefEntity: chefEntity, password: password);
  }
}