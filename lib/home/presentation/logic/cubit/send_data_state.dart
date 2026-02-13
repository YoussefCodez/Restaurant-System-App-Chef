part of 'send_data_cubit.dart';

sealed class SendDataState extends Equatable {
  const SendDataState();

  @override
  List<Object> get props => [];
}

final class SendDataInitial extends SendDataState {}

final class SendDataLoading extends SendDataState {}

final class SendDataLoaded extends SendDataState {
  final DataEntity dataEntity;
  const SendDataLoaded(this.dataEntity);
}

final class SendDataError extends SendDataState {
  final String error;
  const SendDataError(this.error);
}

