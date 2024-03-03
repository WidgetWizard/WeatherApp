import '../../model/temperature_model.dart';

class SettingsViewState {
  List<TemperatureModel>? temperatureItems;
  bool? isLoading;

  SettingsViewState({
    this.temperatureItems,
    this.isLoading = false,
  });

  SettingsViewState copyWith({List<TemperatureModel>? temperatureItems,bool? isLoading}) {
    return SettingsViewState(
      temperatureItems: temperatureItems ?? this.temperatureItems,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingsViewState &&
          runtimeType == other.runtimeType &&
          temperatureItems == other.temperatureItems &&
          isLoading == other.isLoading;

  @override
  int get hashCode => temperatureItems.hashCode ^ isLoading.hashCode;
}
