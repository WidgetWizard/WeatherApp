import 'package:flutter/material.dart';
import 'package:weatherapp/product/init/initialize.dart';
import 'package:weatherapp/product/theme/dark_theme.dart';
import 'package:weatherapp/product/theme/light_theme.dart';
import 'package:weatherapp/service/shared_preferences.dart';
import 'package:weatherapp/view/weather_page_view.dart';
import 'package:weatherapp/product/widgets/no_network.dart';

Future<void> main() async {
  await MainInitialize().sharedInit();
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: SharedManager.instance.getBool(SharedKeys.darkMode) == true ? DarkTheme().theme : LightTheme().theme,
      builder: (context, child) {
        return SafeArea(
          child: Column(
            children: [
              Expanded(
                child: child ?? const SizedBox(),
              ),
              const NoNetworkWidget(),
            ],
          ),
        );
      },
      home: WeatherPageView(),
    );
  }
}
