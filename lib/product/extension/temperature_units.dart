
enum TemperatureUnit{
  Metric,Imperial,Default
}

extension TemperatureUnitExtension on TemperatureUnit{
  String getTemperatureUnit(){
    switch(this){
      case TemperatureUnit.Metric:
      case TemperatureUnit.Imperial:
      case TemperatureUnit.Default:
        return name;
    }
  }
}