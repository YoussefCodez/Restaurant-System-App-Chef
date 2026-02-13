import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_chef/core/entities/chef_entity.dart';
import 'package:food_chef/auth/domain/repositories/auth_repo.dart';
import 'package:food_chef/auth/domain/use_cases/login_use_case.dart';
import 'package:food_chef/auth/domain/use_cases/logout_use_case.dart';
import 'package:food_chef/auth/domain/use_cases/sign_up_use_case.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignUpUseCase signUpUseCase;
  final LoginUseCase logInUseCase;
  final LogoutUseCase logOutUseCase;
  final AuthRepo authRepo;

  AuthCubit(
    this.signUpUseCase,
    this.logInUseCase,
    this.logOutUseCase,
    this.authRepo,
  ) : super(AuthInitial()) {
    authRepo.user.listen((user) async {
      if (user == null) {
        if (state is! AuthInitial) emit(AuthSignedOut());
      } else {
        try {
          await user.reload();
        } catch (e) {
          emit(AuthSignedOut());
        }
      }
    });
  }

  Stream<User?> get user => authRepo.user;

  Future<void> signUp({
    required ChefEntity chef,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      final result = await signUpUseCase.call(
        chefEntity: chef,
        password: password,
      );
      emit(AuthSuccess(chefEntity: result));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> logIn({required String email, required String password}) async {
    emit(AuthLoading());
    try {
      final result = await logInUseCase.call(email: email, password: password);
      emit(AuthSuccess(chefEntity: result));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> signOut() async {
    emit(AuthLoading());
    try {
      await logOutUseCase.call();
      emit(AuthSignedOut());
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }
}
