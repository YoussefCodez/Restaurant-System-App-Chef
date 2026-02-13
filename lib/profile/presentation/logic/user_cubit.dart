import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_chef/core/entities/chef_entity.dart';
import 'package:food_chef/profile/domain/use_cases/get_user_data.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final GetUserData getUserDataUseCase;
  UserCubit({required this.getUserDataUseCase}) : super(UserInitial());

  Future<void> getUserData(String uid) async {
    emit(UserLoading());
    try {
      final chef = await getUserDataUseCase.call(uid);
      emit(UserLoaded(chef: chef));
    } catch (e) {
      emit(UserError(message: e.toString()));
    }
  }
}
