import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:food_chef/home/data/models/data_model.dart';
import 'package:food_chef/home/domain/entities/data_entity.dart';
import 'package:food_chef/home/domain/repositories/send_data_repo.dart';

class SendDataImpl implements SendDataRepo {
  final FirebaseFirestore _firestore;
  SendDataImpl(this._firestore);
  @override
  Future<Either<String, DataEntity>> sendData(DataEntity dataEntity) async {
    try {
      final dataModel = DataModel.fromEntity(dataEntity);
      await _firestore
          .collection("data")
          .doc("data")
          .set(dataModel.toDocument());
      return right(dataEntity);
    } catch (e) {
      return left(e.toString());
    }
  }
}
