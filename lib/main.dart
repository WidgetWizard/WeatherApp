import 'package:flutter/material.dart';
import 'package:weatherapp/view/weather_page_view.dart';
import 'package:weatherapp/product/widgets/no_network.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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

//todo:yüklenirkenki ekrandaki theme ayarlanıcak!
//todo:lottie ile loading barı ayarlıcaz!!
//todo:birincisi date çekmem gerek!
//todo:ikincisi havanın durumuna göre weatherIcons gif değişicek!