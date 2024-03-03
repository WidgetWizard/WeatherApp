import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/product/global/cubit/global_manage_cubit.dart';
import 'package:weatherapp/product/global/cubit/global_manage_state.dart';
import 'package:weatherapp/product/global/provider/global_manage_provider.dart';
import 'package:weatherapp/product/init/initialize.dart';
import 'package:weatherapp/product/theme/dark_theme.dart';
import 'package:weatherapp/product/theme/light_theme.dart';
import 'package:weatherapp/view/weather_page_view.dart';
import 'package:weatherapp/product/widgets/no_network.dart';

Future<void> main() async {
  final MainInitialize mainInitialize = MainInitialize();
  await mainInitialize.sharedInit();
  mainInitialize.globalCubitInit();
  mainInitialize.cacheInit();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GlobalManageProvider.globalManageCubit,
        ),
      ],
      child: Main(),
    ),
  );
}

class Main extends StatelessWidget {
  Main({Key? key}) : super(key: key);
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final DarkTheme _darkTheme = DarkTheme();
  final LightTheme _lightTheme = LightTheme();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
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
      home: BlocBuilder<GlobalManageCubit, GlobalManageState>(
        builder: (context, state) {
          return Theme(
            data: context.read<GlobalManageCubit>().changeThemeDataValue(),
            child: WeatherPageView(),
          );
        },
      ),
    );
  }
}

//todo:bug => bildirim izni istedikten sonra konum izni almıyor!
//todo: drizzle diye bi hava durumu fotosu eklenmemiş yani images i yok!
//todo: providerda cache ediliyor mu bu darkModeActive bilmiyorum ama uygulamayı geri çalıştırdıgımda false
//todo: value_container a bir bak ve burda rain in degerini çarparak ekle!
//todo: burda blocBuilder ie yapıldıgında sürekli olarak o metodu okuor galiba buna bir baksana!
