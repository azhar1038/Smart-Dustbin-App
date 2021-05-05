import 'package:smart_dustbin/app/locator.dart';
import 'package:smart_dustbin/app/router.gr.dart';
import 'package:smart_dustbin/datamodels/user_model.dart';
import 'package:smart_dustbin/services/local_data_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  LocalDataService _localData = locator<LocalDataService>();
  NavigationService _navigator = locator<NavigationService>();

  Future<void> startupLogic() async {
    await Future.delayed(
      Duration(seconds: 2),
    );
    UserModel _user = _localData.user;
    if (_user == null) {
      _navigator.replaceWith(Routes.signin);
      return;
    }
    // TODO: Check if keys is valid
    _navigator.replaceWith(Routes.home);
  }
}
