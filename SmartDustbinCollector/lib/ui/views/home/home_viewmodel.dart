import 'package:smart_dustbin/app/locator.dart';
import 'package:smart_dustbin/app/router.gr.dart';
import 'package:smart_dustbin/datamodels/dustbin_model.dart';
import 'package:smart_dustbin/services/auth_service.dart';
import 'package:smart_dustbin/services/local_data_service.dart';
import 'package:smart_dustbin/services/rtdb_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  RTDBService _rtdb = locator<RTDBService>();
  NavigationService _navigator = locator<NavigationService>();
  LocalDataService _localDataService = locator<LocalDataService>();
  AuthService _auth = locator<AuthService>();

  List<DustbinModel> dustbins = [];

  Future<void> loadDustbins() async {
    setBusy(true);
    List<DustbinModel> l = await _rtdb.getAllDustbins();
    l.sort((a, b)=>-1*(a.percentFull.compareTo(b.percentFull)));
    dustbins = l;
    setBusy(false);
    notifyListeners();
  }
  
  void navigateToDustbin(DustbinModel dustbin){
    _navigator.navigateTo(Routes.dustbin, arguments: DustbinViewArguments(dustbin: dustbin));
  }

  void logout() async {
    await _auth.logout();
    _localDataService.user = null;
    _navigator.clearStackAndShow(Routes.signin);
  }
}