import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/view_model/settings_view_cubit/settings_view_state.dart';

import '../../model/temperature_model.dart';

class SettingsViewCubit extends Cubit<SettingsViewState> {
  SettingsViewCubit() : super(SettingsViewState()){
    setDefaultTemperatureItems();
  }

  void changeTemperatureUnitValue(int index){
    emit(state.copyWith(isLoading: true));
    final tempItems = state.temperatureItems ?? [];
    if((tempItems[index].isSelected) == false){
      tempItems[index].isSelected = true;
    }
    else if(tempItems[index].isSelected){
      tempItems[index].isSelected = true;
    }
    for(var item in tempItems){
      if(tempItems.indexOf(item) != index){
        item.isSelected = false;
      }
    }
    emit(state.copyWith(temperatureItems: tempItems,isLoading: false));
  }

  void setDefaultTemperatureItems(){
    emit(state.copyWith(isLoading: true));
    final temperatureItems = [
      TemperatureModel(temperatureName: 'Celsius (°C)', isSelected: true),
      TemperatureModel(temperatureName: "Fahrenheit (°F)", isSelected: false),
      TemperatureModel(temperatureName: "Kelvin (K)", isSelected: false),
    ];
    emit(state.copyWith(temperatureItems: temperatureItems,isLoading: false));
  }
}

//todo:sıcaklık birimi değişim kodunu yazmam gerekiyor şuanda burda! ondan sonra değişimi ui de denicem
