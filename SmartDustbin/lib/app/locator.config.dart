// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:stacked_services/stacked_services.dart' as _i4;

import '../services/auth_service.dart' as _i3;
import '../services/fcm_service.dart' as _i5;
import '../services/local_data_service.dart' as _i6;
import '../services/rtdb_service.dart' as _i7;
import '../services/stacked_services_module.dart'
    as _i8; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String environment, _i2.EnvironmentFilter environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final stackedServicesModule = _$StackedServicesModule();
  gh.lazySingleton<_i3.AuthService>(() => _i3.AuthService());
  gh.lazySingleton<_i4.DialogService>(
      () => stackedServicesModule.dialogService);
  gh.lazySingleton<_i5.FCMService>(() => _i5.FCMService());
  await gh.lazySingletonAsync<_i6.LocalDataService>(
      () => _i6.LocalDataService.getInstance(),
      preResolve: true);
  gh.lazySingleton<_i4.NavigationService>(
      () => stackedServicesModule.navigationService);
  gh.lazySingleton<_i7.RTDBService>(() => _i7.RTDBService());
  return get;
}

class _$StackedServicesModule extends _i8.StackedServicesModule {
  @override
  _i4.DialogService get dialogService => _i4.DialogService();
  @override
  _i4.NavigationService get navigationService => _i4.NavigationService();
}
