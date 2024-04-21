import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/product/extension/temperature_units.dart';
import 'package:weatherapp/view_model/settings_view_cubit/settings_view_state.dart';

import '../../model/temperature_model.dart';
import '../../service/shared_preferences.dart';

class SettingsViewCubit extends Cubit<SettingsViewState> {
  SettingsViewCubit() : super(SettingsViewState()){
    setCachedAndDefaultTemperatureItems();
  }

  void changeTemperatureUnitActiveValue(int index) {
    emit(state.copyWith(isLoading: true));
    final tempItems = state.temperatureItems ?? [];
    for (var i = 0; i < tempItems.length; i++) {
      if (i == index) {
        tempItems[i].isSelected = true;
        SharedManager.instance.saveString(SharedKeys.temperatureUnit, tempItems[index].temperatureName);
      } else {
        tempItems[i].isSelected = false;
      }
    }
    emit(state.copyWith(temperatureItems: tempItems, isLoading: false));
  }

  void setCachedAndDefaultTemperatureItems() {
    emit(state.copyWith(isLoading: true));
    final temperatureItems = [
      TemperatureModel(temperatureName: TemperatureUnit.Metric.name, isSelected: false),
      TemperatureModel(temperatureName: TemperatureUnit.Imperial.name, isSelected: false),
      TemperatureModel(temperatureName: TemperatureUnit.Default.name, isSelected: false),
    ];
    final tempValue = SharedManager.instance.getString(SharedKeys.temperatureUnit);
    if (tempValue != null) {
      final selectedUnit = TemperatureUnit.values.firstWhere(
            (unit) => unit.name.toLowerCase() == tempValue.toLowerCase(),
        orElse: () => TemperatureUnit.Default,
      );
      for (var item in temperatureItems) {
        item.isSelected = item.temperatureName == selectedUnit.name;
      }
    }
    emit(state.copyWith(temperatureItems: temperatureItems, isLoading: false));
  }
}
