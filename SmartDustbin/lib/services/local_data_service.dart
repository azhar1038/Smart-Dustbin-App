// A service class implementing SharedPreferences

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_dustbin/datamodels/user_model.dart';

@preResolve
@lazySingleton
class LocalDataService {
  static LocalDataService _instance;
  static SharedPreferences _preferences;

  static const String _userKey = "user";

  @factoryMethod
  static Future<LocalDataService> getInstance() async {
    _instance ??= LocalDataService();
    _preferences ??= await SharedPreferences.getInstance();
    return _instance;
  }

  /// Getter for [UserModel]
  UserModel get user {
    final String userJson = _getFromDisk(_userKey) as String;
    if (userJson == null) return null;
    return UserModel.fromJson(jsonDecode(userJson) as Map<String, dynamic>);
  }

  /// Setter for [UserModel]
  set user(UserModel userToSave) {
    if (userToSave == null) {
      _deleteUser();
      return;
    }
    _saveToDisk<String>(_userKey, jsonEncode(userToSave.toJson()));
  }

  /// Deletes the locally stored [UserModel]
  void _deleteUser() {
    _preferences.remove(_userKey);
  }

  dynamic _getFromDisk(String key) {
    final value = _preferences.get(key);
    debugPrint(
        '(TRACE) SharedPrefService: _getFromDisk. key: $key value: $value');
    return value;
  }

  void _saveToDisk<T>(String key, T value) {
    debugPrint(
        '(TRACE) SharedPrefService:_saveStringToDisk. key: $key value: $value');
    if (value is String) {
      _preferences.setString(key, value);
    } else if (value is int) _preferences.setInt(key, value);
  }
}
