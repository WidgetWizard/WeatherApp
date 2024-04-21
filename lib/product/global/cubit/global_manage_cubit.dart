import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:weatherapp/product/extension/temperature_units.dart';
import 'package:weatherapp/product/global/cubit/global_manage_state.dart';
import 'package:weatherapp/service/shared_preferences.dart';

import '../../theme/dark_theme.dart';
import '../../theme/light_theme.dart';

class GlobalManageCubit extends Cubit<GlobalManageState> {
  GlobalManageCubit() : super(GlobalManageState());

  void getCacheValues(SharedKeys sharedKeys){
    emit(state.copyWith(isLoading: true));
    if(SharedManager.instance.preferences != null){
      emit(state.copyWith(darkModeIsActive: SharedManager.instance.getBool(SharedKeys.darkMode)));
      emit(state.copyWith(temperatureUnit: SharedManager.instance.getString(SharedKeys.temperatureUnit)));
    }
    emit(state.copyWith(isLoading: false));
  }

  void changeDarkMode(SharedKeys sharedKeys){
    emit(state.copyWith(isLoading: true));
    final tempDarkModeValue = !(state.darkModeIsActive ?? false);
    if(sharedKeys == SharedKeys.darkMode){
      SharedManager.instance.saveBool(sharedKeys, tempDarkModeValue);

    }
    emit(state.copyWith(darkModeIsActive: tempDarkModeValue));
    emit(state.copyWith(isLoading: false));
  }

  ThemeData changeThemeDataValue(){
    final DarkTheme _darkTheme = DarkTheme();
    final LightTheme _lightTheme = LightTheme();
    emit(state.copyWith(isLoading: true));
    ThemeData tempThemeData = ThemeData();
    if(state.darkModeIsActive ?? false){
      tempThemeData = _darkTheme.theme;
      emit(state.copyWith(themeData: tempThemeData));
    }
    else{
      tempThemeData = _lightTheme.theme;
      emit(state.copyWith(themeData: tempThemeData));
    }
    emit(state.copyWith(isLoading: false));
    return tempThemeData;
  }

  void getTemperatureUnit(int index){
    emit(state.copyWith(isLoading: true));
    final tempUnit = TemperatureUnit.values[index].getTemperatureUnit();
    print(tempUnit);
    emit(state.copyWith(temperatureUnit: tempUnit,isLoading: false,));
  }

}
