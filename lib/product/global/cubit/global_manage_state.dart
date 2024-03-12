import 'package:flutter/material.dart';

class GlobalManageState {
  bool? isLoading;
  bool? darkModeIsActive;
  ThemeData? themeData;
  String? temperatureUnit;

  GlobalManageState({
    this.isLoading = false,
    this.darkModeIsActive = false,
    this.themeData,
    this.temperatureUnit,
  });

  GlobalManageState copyWith(
      {bool? isLoading, bool? darkModeIsActive, ThemeData? themeData, String? temperatureUnit,}) {
    return GlobalManageState(
      isLoading: isLoading ?? this.isLoading,
      darkModeIsActive: darkModeIsActive ?? this.darkModeIsActive,
      themeData: themeData ?? this.themeData,
      temperatureUnit: temperatureUnit ?? this.temperatureUnit,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is GlobalManageState &&
          runtimeType == other.runtimeType &&
          isLoading == other.isLoading &&
          darkModeIsActive == other.darkModeIsActive &&
          themeData == other.themeData &&
          temperatureUnit == other.temperatureUnit ;

  @override
  int get hashCode =>
      isLoading.hashCode^
      darkModeIsActive.hashCode^
      themeData.hashCode^
      temperatureUnit.hashCode;


}
