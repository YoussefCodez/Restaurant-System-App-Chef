import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_chef/home/domain/entities/user_entity.dart';
import 'package:food_chef/home/domain/use_cases/get_users_use_case.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  final GetUsersUseCase _getUsersUseCase;
  UsersCubit(this._getUsersUseCase) : super(UsersInitial());

  StreamSubscription? _usersSubscription;

  Future<void> getUsers([String? uid]) async {
    emit(UsersLoading());
    _usersSubscription?.cancel();
    _usersSubscription = _getUsersUseCase
        .call(uid)
        .listen(
          (users) {
            emit(UsersLoaded(users));
          },
          onError: (e) {
            emit(UsersError(e.toString()));
          },
        );
  }

  @override
  Future<void> close() {
    _usersSubscription?.cancel();
    return super.close();
  }
}
