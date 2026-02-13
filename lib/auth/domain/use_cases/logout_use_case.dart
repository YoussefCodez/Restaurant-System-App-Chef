import 'package:food_chef/auth/domain/repositories/auth_repo.dart';

class LogoutUseCase {
  final AuthRepo authRepo;
  LogoutUseCase({required this.authRepo});

  Future<void> call() {
    return authRepo.logOut();
  }
}