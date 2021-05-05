import 'package:smart_dustbin/app/locator.dart';
import 'package:smart_dustbin/app/router.gr.dart';
import 'package:smart_dustbin/datamodels/user_model.dart';
import 'package:smart_dustbin/services/auth_service.dart';
import 'package:smart_dustbin/services/fcm_service.dart';
import 'package:smart_dustbin/services/local_data_service.dart';
import 'package:smart_dustbin/services/rtdb_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SignInViewModel extends BaseViewModel {
  final AuthService _auth = locator<AuthService>();
  final LocalDataService _localData = locator<LocalDataService>();
  final NavigationService _navigator = locator<NavigationService>();
  final FCMService _fcm = locator<FCMService>();
  final RTDBService _rtdb = locator<RTDBService>();

  Future googleLogin() async {
    setBusy(true);
    UserModel user = await _auth.signInWithGoogle();
    String token = await _fcm.getNewToken("");
    UserModel _existingUser = await _rtdb.fetchUserFromDatabase(user);
    if(_existingUser == null){
      user.token = token;
      _localData.user = user;
      _navigator.replaceWith(Routes.login);
      return;
    }

    _existingUser.token = token;
    _localData.user = _existingUser;
    await _rtdb.updateDustbin(_existingUser, {
      "token": token,
    });
    _navigator.replaceWith(Routes.home);
  }
}