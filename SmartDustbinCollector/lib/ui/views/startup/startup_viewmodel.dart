import 'package:smart_dustbin/app/locator.dart';
import 'package:smart_dustbin/app/router.gr.dart';
import 'package:smart_dustbin/datamodels/user_model.dart';
import 'package:smart_dustbin/services/fcm_service.dart';
import 'package:smart_dustbin/services/local_data_service.dart';
import 'package:smart_dustbin/services/rtdb_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  LocalDataService _localData = locator<LocalDataService>();
  NavigationService _navigator = locator<NavigationService>();
  final FCMService _fcm = locator<FCMService>();
  final RTDBService _rtdb = locator<RTDBService>();

  Future<void> startupLogic() async {
    await Future.delayed(
      Duration(seconds: 2),
    );
    UserModel _user = _localData.user;
    if (_user == null) {
      _navigator.replaceWith(Routes.signin);
      return;
    }
    String token = await _fcm.getNewToken(_user.token);
    if(token != null){
      _user.token = token;
      await _rtdb.updateToken(_user);
    }
    _navigator.replaceWith(Routes.home);
  }
}
