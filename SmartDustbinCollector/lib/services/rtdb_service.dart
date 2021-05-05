import 'package:firebase_database/firebase_database.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_dustbin/datamodels/dustbin_model.dart';
import 'package:smart_dustbin/datamodels/user_model.dart';
import 'package:smart_dustbin/services/local_data_service.dart';

@lazySingleton
class RTDBService{
  static final _database = FirebaseDatabase.instance;
  
  Future<void> updateToken(UserModel user) async {
    await _database.reference().child("collectors").child(user.id).update({
      "token": user.token
    });
  }

  Future<List<DustbinModel>> getAllDustbins() async {
    List<DustbinModel> l = [];
    await _database.reference().child("dustbins").once().then((DataSnapshot snapshot){
      snapshot.value.forEach((key, value) {
        l.add(DustbinModel.fromJson(key, Map.from(value)));
      });
    });
    return l;
  }
}