import 'package:smart_dustbin/app/locator.dart';
import 'package:smart_dustbin/datamodels/user_model.dart';
import 'package:smart_dustbin/services/local_data_service.dart';
import 'package:smart_dustbin/services/rtdb_service.dart';
import 'package:smart_dustbin/ui/views/settings/settings_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class DustbinViewModel extends StreamViewModel<double> {
  LocalDataService _localData = locator<LocalDataService>();
  RTDBService _rtdb = locator<RTDBService>();
  double trashLevel = 0;
  double rawValue = 0;

  UserModel _user;

  DustbinViewModel(){
    _user = _localData.user;
  }

  double getTrashLevel(double distance){
    if(distance == null){
      return 0;
    }else if(distance > _user.dustbinHeight){
      return 0;
    }
    trashLevel = 1 - distance / _user.dustbinHeight;
    trashLevel = trashLevel < 0 ? 0 : trashLevel;
    return trashLevel;
  }

  @override
  Stream<double> get stream => _rtdb.getDustbinStream(_user);
}
