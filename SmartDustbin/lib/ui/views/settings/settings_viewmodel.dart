import 'package:smart_dustbin/app/locator.dart';
import 'package:smart_dustbin/app/router.gr.dart';
import 'package:smart_dustbin/datamodels/user_model.dart';
import 'package:smart_dustbin/services/local_data_service.dart';
import 'package:smart_dustbin/services/rtdb_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SettingsViewModel extends BaseViewModel {
  LocalDataService _localData = locator<LocalDataService>();
  DialogService _dialog = locator<DialogService>();
  NavigationService _navigator = locator<NavigationService>();
  RTDBService _rtdb = locator<RTDBService>();

  UserModel user;

  SettingsViewModel() {
    user = _localData.user;
  }

  Future<void> update(
    String height,
    String name,
    String address,
  ) async {
    UserModel _user = _localData.user;
    await _rtdb.updateDustbin(_user, {
      "height": double.parse(height),
      "name": name,
      "address": address,
    });
    _user.dustbinHeight = double.parse(height);
    _user.address = address;
    _user.name = name;
    _dialog.showDialog(
      title: "Updated Successfully",
      description: "IoT details have been updated",
    );
    _localData.user = _user;
  }

  Future<void> logout() async {
    DialogResponse _res = await _dialog.showConfirmationDialog(
      title: "Logout",
      description: "Your saved details will be deleted. Do you want to logout?",
    );
    if (_res?.confirmed ?? false) {
      _localData.user = null;
      _navigator.clearStackAndShow(Routes.signin);
    }
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

  String nameValidator(String s) {
    if (s?.isEmpty ?? true) {
      return "Name cannot be empty";
    }
    return null;
  }

  String addressValidator(String s) {
    if (s?.isEmpty ?? true) {
      return "Address cannot be empty";
    } else if (s.length < 5) {
      return "Enter proper address";
    }
    return null;
  }
}
