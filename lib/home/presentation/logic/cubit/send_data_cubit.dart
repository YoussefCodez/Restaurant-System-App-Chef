import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_chef/home/domain/entities/data_entity.dart';
import 'package:food_chef/home/domain/use_cases/send_data_use_case.dart';

part 'send_data_state.dart';

class SendDataCubit extends Cubit<SendDataState> {
  final SendDataUseCase _sendDataUseCase;
  SendDataCubit(this._sendDataUseCase) : super(SendDataInitial());

  Future<void> sendData(DataEntity dataEntity) async {
    emit(SendDataLoading());
    final result = await _sendDataUseCase.call(dataEntity);
    result.fold(
      (failure) => emit(SendDataError(failure)),
      (dataEntity) => emit(SendDataLoaded(dataEntity)),
    );
  }
}
