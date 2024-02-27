import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/model/city_name_model.dart';
import 'package:weatherapp/product/extension/context/general.dart';
import 'package:weatherapp/product/extension/context/icon_size.dart';
import 'package:weatherapp/product/extension/context/navigation.dart';
import 'package:weatherapp/product/extension/context/padding.dart';
import 'package:weatherapp/product/extension/context/size.dart';
import 'package:weatherapp/service/city_name_sevice.dart';
import 'package:weatherapp/view/%C5%9Fehirler.dart';
import 'package:weatherapp/view/about_us_view.dart';
import 'package:weatherapp/view/settings_view.dart';

import '../model/weather_model.dart';

import 'package:weatherapp/product/extension/weather_condition.dart';
import 'package:weatherapp/service/weather_service.dart';
import 'package:weatherapp/view_model/weather_page_view_model.dart';
import 'package:lottie/lottie.dart';

import '../product/api/project_api.dart';
import '../product/widgets/value_container.dart';

class WeatherPageView extends StatefulWidget {
  const WeatherPageView({super.key});

  @override
  State<WeatherPageView> createState() => _WeatherPageViewState();
}

class _WeatherPageViewState extends WeatherPageViewModel with _PageUtility {
  Future<void> get refresh async {
    await initCurrentWeatherData();
    setState(() {});
    if (isLoading) {
      while (isLoading) {
        await Future.delayed(const Duration(seconds: 1));
      }
    }
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var stringUnknown = "Unknown";
    return CustomMaterialIndicator(
      onRefresh: () => refresh,
      indicatorBuilder: (context, controller) {
        return const Icon(
          Icons.ac_unit,
          color: Colors.blue,
          size: 30,
        );
      },
      scrollableBuilder: (context, child, controller) {
        return FadeTransition(
          opacity:
              Tween(begin: 1.0, end: 0.3).animate(controller.clamp(0.0, 1.0)),
          child: child,
        );
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: isLoading
                  ? _loadingBarPlace()
                  : Stack(
                      children: [
                        _weatherPageBackgroundImage(context),
                        Scaffold(
                          key: _scaffoldKey,
                          endDrawer: buildEndDrawer(context),
                          backgroundColor: Colors.transparent,
                          appBar: _weatherPageAppBar(context),
                          body: Padding(
                            padding: context.padding.mediumSymmetricHorizontal,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _cityText(context,
                                    cityName: weatherModel?.cityName ??
                                        stringUnknown),
                                _dateText(context),
                                _degreeText(context,
                                    temp: weatherModel?.temp?.toInt()),
                                _assetsAndWeatherInfoText(context,
                                    mainCondition:
                                        weatherModel?.mainCondition ??
                                            stringUnknown,
                                    weatherModel: weatherModel),
                                _divider(context),
                                _bottomComponent(context,
                                    weatherModel: weatherModel)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }


  void _openDrawer() {
    _scaffoldKey.currentState!.openEndDrawer();
  }

  Widget buildEndDrawer(BuildContext context) {
    return Drawer(
      width: context.sized.width * 0.5,
      backgroundColor: context.general.theme.colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.settings,color: context.general.theme.primaryColor,),
            title: Text('Settings',style: context.general.textTheme.titleLarge?.copyWith(color: context.general.theme.primaryColor),),
            onTap: () {
              context.route.pop();
              context.route.navigatePush(SettingsView());
            },
          ),
          ListTile(
            leading: Icon(Icons.person,color: context.general.theme.primaryColor,),
            title: Text('About Us',style: context.general.textTheme.titleLarge?.copyWith(color: context.general.theme.primaryColor),),
            onTap: () {
              context.route.pop();
              context.route.navigatePush(AboutUsView());
            },
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
          onPressed: () {
            showSearch(context: context, delegate: MyDelegate());
          },
          icon: Icon(
            Icons.search_outlined,
            shadows: <Shadow>[shadow],
          )),
      actions: [
        IconButton(
            iconSize: context.iconSize.large,
            color: Colors.white,
            onPressed: () {
              _openDrawer();
            },
            icon: Icon(Icons.drag_handle_outlined, shadows: <Shadow>[shadow]))
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

class MyDelegate extends SearchDelegate {
  final CityWeatherService _cityWeatherService = CityWeatherService(
      apiKey: ProjectApi().getWeatherApi,
      baseUrl: "https://api.openweathermap.org/data/2.5");

  //? şehir isimlerini db mi yapalım uygulama içinde yoksa api mi kullanalım?
  List<String> searchResult = Searchresult;
  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          onPressed: () => query = "",
          icon: const Icon(Icons.clear),
        )
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.arrow_back_ios_outlined),
      );

  @override
  Widget buildResults(BuildContext context) {
    // FutureBuilder kullanarak asenkron veri çekme işlemi
    return FutureBuilder<WeatherModel?>(
      future: _cityWeatherService.getCityWeatherData(query),
      builder: (BuildContext context, AsyncSnapshot<WeatherModel?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Hata: ${snapshot.error}'));
        } else {
          // Veri çekme işlemi başarılı olduysa, veriyi göster
          WeatherModel? weatherData = snapshot.data;
          return weatherData == null
              ? const Center(child: Text(""))
              : Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ListTile(
                          title: Center(
                              child: Text(weatherData.cityName ?? "Unknown")),
                        ),
                        ListTile(
                          leading: const Icon(Icons.thermostat_outlined),
                          title: const Text("Sıcaklık"),
                          trailing: Text("${weatherData.temp}"),
                        ),
                        ListTile(
                          leading: const Icon(Icons.cloud),
                          title: const Text("Durum"),
                          trailing: Text("${weatherData.mainCondition}"),
                        ),
                        ListTile(
                          leading: const Icon(Icons.air),
                          title: const Text("Rüzgar"),
                          trailing: Text("${weatherData.wind}"),
                        ),
                        ListTile(
                          leading: const Icon(Icons.water_damage),
                          title: const Text("Nem"),
                          trailing: Text("${weatherData.humidity}"),
                        ),
                        ListTile(
                          leading: const Icon(Icons.umbrella),
                          title: const Text("Yağmur Oranı"),
                          trailing: Text("${weatherData.rain ?? 0.0}"),
                        ),
                      ],
                    ),
                  ),
                );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<CityNameModel>>(
      future: fetchCityName(query), // your Future<List<String>> function
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ListView.builder(
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [ListTile(title: Text("  ")), Divider()],
              );
            },
          ); // show a loading spinner while waiting
        } else if (snapshot.hasError) {
          return Text(
              'Error: ${snapshot.error}'); // show an error message if something went wrong
        } else {
          // build a list of widgets based on the List<String>
          return ListView.builder(
            itemCount: snapshot.data!
                .length, // todo: bütün itemleri tut listeye çevir ve onu döndür yoksa her seferinde apiye istek atar
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(snapshot.data![index].cityName!),
                onTap: () {
                  query = snapshot.data![index].cityName!;
                  showResults(context);
                },
              );
            },
          );
        }
      },
    );
  }
}

mixin _PageUtility on State<WeatherPageView> {
  final shadow = const Shadow(
    offset: Offset(1.0, 1.0),
    blurRadius: 3.0,
    color: Colors.black,
  );

  Padding _bottomComponent(BuildContext context, {WeatherModel? weatherModel}) {
    return Padding(
      padding: context.padding.topOnlyMedium,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ValueContainer(
              valueName: "Wind",
              percent: weatherModel?.wind,
              isPercentage: true),
          ValueContainer(
              valueName: "Rain",
              percent: _setPercent(weatherModel),
              isRain: true),
          ValueContainer(
            valueName: "Humidity",
            percent: weatherModel?.humidity?.toDouble(),
          ),
        ],
      ),
    );
  }

  double _setPercent(WeatherModel? weatherModel) =>
      (weatherModel?.rain != null ? (weatherModel!.rain! * 100) : (0.00));

  Padding _divider(BuildContext context) {
    return Padding(
      padding: context.padding.topOnlyMedium,
      child: const Divider(color: Colors.white),
    );
  }

  Padding _assetsAndWeatherInfoText(BuildContext context,
      {required String mainCondition, WeatherModel? weatherModel}) {
    return Padding(
      padding: context.padding.dynamicOnly(top: 0.02),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: context.padding.rightOnlyNormal,
            child: Image.asset(
                WeatherCondition.rain.getWeatherConditionGif(weatherModel) ??
                    ""),
          ),
          Text(
            mainCondition,
            style: context.general.textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontSize: context.sized.dynamicHeigth(0.037),
              shadows: <Shadow>[
                shadow,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding _degreeText(BuildContext context, {required int? temp}) {
    return Padding(
      padding: context.padding.dynamicOnly(top: 0.15),
      child: Text(
        '${temp ?? "unknown"}°',
        style: context.general.textTheme.displayLarge?.copyWith(
          color: Colors.white,
          fontSize: temp == null
              ? context.sized.dynamicHeigth(0.05)
              : context.sized.dynamicHeigth(0.12),
          shadows: <Shadow>[
            shadow,
          ],
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
        shadows: <Shadow>[
          shadow,
        ],
      ),
    );
  }

  Padding _cityText(BuildContext context, {required String cityName}) {
    return Padding(
      padding: context.padding.dynamicOnly(top: 0.1),
      child: Text(
        cityName,
        style: context.general.textTheme.displaySmall?.copyWith(
          fontWeight: FontWeight.w500,
          color: Colors.white,
          shadows: <Shadow>[
            shadow,
          ],
        ),
      ),
    );
  }

  Widget _loadingBarPlace() {
    return Center(
      child: Lottie.asset("assets/lottie/loading.json", animate: true),
    );
  }
}


//todo: settings de dil, theme, sıcaklık ayarları olucak!
//dark mode a göre theme ayarlanıcak,
//dil seçenegi ingilizce ve türkçe yapılcak
//bildirim sorulucak
//sıcaklık seçeneği seçimi yapılıcak!

///todo: şimdi bloc ile state yönetimini yapıcam!
///yarın mustiye languageyi yapmasını söylemeliyim!
///buran itibaren bloc ile ayrı bir yol,dil seçeneği ile ayrı bi yol oluşturulmalı
///