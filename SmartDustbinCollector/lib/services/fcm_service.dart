import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';


@lazySingleton
class FCMService{
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  Future<String> getNewToken(String oldToken) async {
    String newToken = await _messaging.getToken();
    if(oldToken != newToken){
      print('NEW TOKEN FOUND');
      return newToken;
    }else{
      return null;
    }
  }
}