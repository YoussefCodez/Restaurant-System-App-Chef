import 'package:dartz/dartz.dart';
import 'package:food_chef/home/domain/entities/data_entity.dart';

abstract class SendDataRepo {
  Future<Either<String, DataEntity>> sendData(DataEntity dataEntity);
}