import 'package:flutter/material.dart';
import 'package:weatherapp/view/weather_page_view.dart';
import 'package:weatherapp/product/widgets/no_network.dart';


void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(
        useMaterial3: true,
      ),
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
      home: const WeatherPageView(),
    );
  }
}

//todo: knk uygulama yuklenirken yeniden bir uyumsuzluk var burda.
//veriler sonradan geliyor yine! ama ekran erken yükleniyor