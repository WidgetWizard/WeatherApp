import 'package:shared_preferences/shared_preferences.dart';

import '../product/exception/shared_not_initalize_exception.dart';

enum SharedKeys{
  darkMode,
}

abstract class ISharedManager{
  Future<void> saveString(SharedKeys key,String value);
  String? getString(SharedKeys key);
  Future<void> saveBool(SharedKeys key,bool value);
  bool? getBool(SharedKeys key);
  Future<bool> removeItems(SharedKeys key);
}

class SharedManager implements ISharedManager{
  SharedPreferences? preferences;

  Future<void> init() async {
    preferences = await SharedPreferences.getInstance();
  }
  SharedManager(){
    init();
  }
  void _checkPreferences(){
    if(preferences == null){
      throw SharedNotInitializeException();
    }
  }

  @override
  Future<void> saveString(SharedKeys key,String value) async {
    _checkPreferences();
    await preferences?.setString(key.name, value);
  }

  @override
  String? getString(SharedKeys key){
    _checkPreferences();
    return preferences?.getString(key.name);
  }

  @override
  Future<void> saveBool(SharedKeys key,bool value) async{
    _checkPreferences();
    await preferences?.setBool(key.name, value);
  }
  @override
  bool? getBool(SharedKeys key){
    _checkPreferences();
    return preferences?.getBool(key.name);
  }

  @override
  Future<bool> removeItems(SharedKeys key) async{
    _checkPreferences();
    return (await preferences?.remove(key.name)) ?? false;
  }
}