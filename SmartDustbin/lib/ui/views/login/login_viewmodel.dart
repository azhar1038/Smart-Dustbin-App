import 'package:smart_dustbin/app/locator.dart';
import 'package:smart_dustbin/app/router.gr.dart';
import 'package:smart_dustbin/datamodels/user_model.dart';
import 'package:smart_dustbin/services/fcm_service.dart';
import 'package:smart_dustbin/services/local_data_service.dart';
import 'package:smart_dustbin/services/rtdb_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {
  LocalDataService _localData = locator<LocalDataService>();
  NavigationService _navigator = locator<NavigationService>();
  FCMService _fcm = locator<FCMService>();
  RTDBService _rtdb = locator<RTDBService>();

  String nameValidator(String s) {
    if (s?.isEmpty ?? true) {
      return "Name cannot be empty";
    }
    return null;
  }

  String addressValidator(String s) {
    if (s?.isEmpty ?? true) {
      return "Address cannot be empty";
    }else if(s.length < 5){
      return "Enter proper address";
    }
    return null;
  }

  String heightValidator(String s) {
    if (s?.isEmpty ?? true) {
      return "Please provide dustbin height";
    }
    double height;
    try {
      height = double.parse(s);
    } catch (e) {
      return "Please provide a proper height in number";
    }
    if (height <= 0) {
      return "Height must be greater than 0";
    }
    return null;
  }

  Future<void> register(
    String height,
    String name,
    String address,
  ) async {
    setBusy(true);
    UserModel _user = _localData.user;
    _user.dustbinHeight = double.parse(height);
    _user.name = name;
    _user.address = address;
    _localData.user = _user;
    _rtdb.createNewDustbin(_user);
    _navigator.replaceWith(Routes.home);
  }
}
