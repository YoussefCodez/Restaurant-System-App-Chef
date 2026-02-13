import 'package:dartz/dartz.dart';
import 'package:food_chef/home/domain/entities/data_entity.dart';
import 'package:food_chef/home/domain/repositories/send_data_repo.dart';

class SendDataUseCase {
  final SendDataRepo _sendDataRepo;
  SendDataUseCase(this._sendDataRepo);
  Future<Either<String, DataEntity>> call(DataEntity dataEntity) async {
    return await _sendDataRepo.sendData(dataEntity);
  }
}