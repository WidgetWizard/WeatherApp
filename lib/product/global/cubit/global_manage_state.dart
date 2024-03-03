import 'package:flutter/material.dart';

class GlobalManageState {
  bool? isLoading;
  bool? darkModeIsActive;
  ThemeData? themeData;

  GlobalManageState({
    this.isLoading = false,
    this.darkModeIsActive = false,
    this.themeData,
  });

  GlobalManageState copyWith({bool? isLoading,bool? darkModeIsActive,ThemeData? themeData}){
    return GlobalManageState(
      isLoading: isLoading ?? this.isLoading,
      darkModeIsActive: darkModeIsActive ?? this.darkModeIsActive,
      themeData: themeData ?? this.themeData,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is GlobalManageState &&
          runtimeType == other.runtimeType &&
          isLoading == other.isLoading &&
          darkModeIsActive == other.darkModeIsActive &&
          themeData == other.themeData;

  @override
  int get hashCode =>
      isLoading.hashCode^
      darkModeIsActive.hashCode^
      themeData.hashCode;


}
