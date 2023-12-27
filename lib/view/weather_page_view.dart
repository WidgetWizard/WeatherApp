import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/model/weather_model.dart';
import 'package:weatherapp/product/extension/context/general.dart';
import 'package:weatherapp/product/extension/context/icon_size.dart';
import 'package:weatherapp/product/extension/context/padding.dart';
import 'package:weatherapp/product/extension/context/size.dart';
import 'package:weatherapp/product/extension/weather_condition.dart';
import 'package:weatherapp/view_model/weather_page_view_model.dart';

import '../product/api/project_api.dart';
import '../product/widgets/value_container.dart';

class WeatherPageView extends StatefulWidget {
  const WeatherPageView({super.key});

  @override
  State<WeatherPageView> createState() => _WeatherPageViewState();
}

class _WeatherPageViewState extends WeatherPageViewModel with _PageUtility {
  @override
  Widget build(BuildContext context) {
    var stringUnknown = "Unknown";
    return SafeArea(
      child: Stack(
        children: [
          _weatherPageBackgroundImage(context),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: _weatherPageAppBar(context),
            body: isLoading
                ? _loadingBarPlace()
                : Padding(
                    padding: context.padding.mediumSymmetricHorizontal,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _cityText(context,cityName: weatherModel?.cityName ?? stringUnknown),
                        _dateText(context),
                        _degreeText(context,temp: weatherModel?.temp?.toInt()),
                        _assetsAndWeatherInfoText(context,mainCondition: weatherModel?.mainCondition ?? stringUnknown,weatherModel: weatherModel),
                        _divider(context),
                        _bottomComponent(context,weatherModel: weatherModel)
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  AppBar _weatherPageAppBar(BuildContext context) {
    return AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
                iconSize: context.iconSize.normal,
                color: Colors.white,
                onPressed: () {},
                icon: Icon(Icons.search_outlined,shadows: <Shadow>[shadow],)),
            actions: [
              IconButton(
                  iconSize: context.iconSize.large,
                  color: Colors.white,
                  onPressed: () {},
                  icon: Icon(Icons.drag_handle_outlined,shadows: <Shadow>[shadow]))
            ],
          );
  }
  Image _weatherPageBackgroundImage(BuildContext context) {
    return Image.network(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          randomImageUrl,
          headers: ProjectApi().getHeaders,
          fit: BoxFit.cover,
        );
  }
}

mixin _PageUtility on State<WeatherPageView>{
  final shadow = const Shadow(
    offset: Offset(1.0, 1.0),
    blurRadius: 3.0,
    color: Colors.black,
  );

  Padding _bottomComponent(BuildContext context,{WeatherModel? weatherModel}) {
    return Padding(
      padding: context.padding.topOnlyMedium,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ValueContainer(valueName: "Wind", percent: weatherModel?.wind,isPercentage: true),
          ValueContainer(valueName: "Rain", percent: _setPercent(weatherModel),isRain: true),
          ValueContainer(valueName: "Humidity", percent: weatherModel?.humidity?.toDouble(),),
        ],
      ),
    );
  }

  double _setPercent(WeatherModel? weatherModel) => (weatherModel?.rain != null ? (weatherModel!.rain! * 100) : (0.00));

  Padding _divider(BuildContext context) {
    return Padding(
      padding: context.padding.topOnlyMedium,
      child: const Divider(color: Colors.white),
    );
  }

  Padding _assetsAndWeatherInfoText(BuildContext context,{required String mainCondition,WeatherModel? weatherModel}) {
    return Padding(
      padding: context.padding.dynamicOnly(top: 0.02),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: context.padding.rightOnlyNormal,
            child: Image.asset(WeatherCondition.rain.getWeatherConditionGif(weatherModel) ?? ""),
          ),
          Text(
            mainCondition,
            style: context.general.textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontSize: context.sized.dynamicHeigth(0.037),
              shadows: <Shadow>[shadow,],
            ),
          ),
        ],
      ),
    );
  }

  Padding _degreeText(BuildContext context,{required int? temp}) {
    return Padding(
      padding: context.padding.dynamicOnly(top: 0.15),
      child: Text(
        '${temp ?? "unknown"}°',
        style: context.general.textTheme.displayLarge?.copyWith(
          color: Colors.white,
          fontSize: temp == null ? context.sized.dynamicHeigth(0.05) : context.sized.dynamicHeigth(0.12),
          shadows: <Shadow>[shadow,],
        ),
      ),
    );
  }

  Text _dateText(BuildContext context) {
    final now = DateTime.now();
    String formattedDate = DateFormat('EEEE d MMMM y').format(now);
    return Text(
      formattedDate,
      style: context.general.textTheme.titleMedium?.copyWith(
        color: Colors.white,
        fontWeight: FontWeight.w400,
        shadows: <Shadow>[shadow,],
      ),
    );
  }

  Padding _cityText(BuildContext context,{required String cityName}) {
    return Padding(
      padding: context.padding.dynamicOnly(top: 0.1),
      child: Text(
        cityName,
        style: context.general.textTheme.displaySmall?.copyWith(
          fontWeight: FontWeight.w500,
          color: Colors.white,
          shadows: <Shadow>[shadow,],
        ),
      ),
    );
  }

  Center _loadingBarPlace() {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.white,
      ),
    );
  }
}

