import 'package:firebase_database/firebase_database.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_dustbin/datamodels/user_model.dart';
import 'package:smart_dustbin/services/local_data_service.dart';

@lazySingleton
class RTDBService{
  static final _database = FirebaseDatabase.instance;

  Future<UserModel> fetchUserFromDatabase(UserModel user) async {
    return _database.reference()
        .child('dustbins')
        .child(user.id)
        .once().then((snapshot){
          if(snapshot.value ==  null){
            return null;
          }
          Map<String, dynamic> m = Map.from(snapshot.value);
          m['id'] = snapshot.key;
          return UserModel.fromJson(m);
    });
  }

  Future createNewDustbin(UserModel user) async {
    await _database.reference().child('dustbins').child(user.id).set({
      "email": user.email,
      "name": user.name,
      "address": user.address,
      "height": user.dustbinHeight,
      "token": user.token,
      "distance": user.dustbinHeight,
      "notified": false,
    });
  }

  Future updateDustbin(UserModel user, Map<String, dynamic> updates) async {
    await _database.reference().child("dustbins").child(user.id).update(updates);
  }

  Stream<double> getDustbinStream(UserModel user) {
    Stream<Event> stream = _database.reference()
        .child("dustbins")
        .child(user.id)
        .child("distance").onValue;
    return stream.map((event){
      return event.snapshot.value?.toDouble()??0;
    });
  }
}