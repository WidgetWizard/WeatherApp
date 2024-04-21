import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/product/constant/const.dart';
import 'package:weatherapp/product/global/cubit/global_manage_cubit.dart';
import 'package:weatherapp/product/global/cubit/global_manage_state.dart';
import 'package:weatherapp/product/global/provider/global_manage_provider.dart';

import 'package:weatherapp/product/init/initialize.dart';
import 'package:weatherapp/view/weather_page_view.dart';
import 'package:weatherapp/product/widgets/no_network.dart';
import 'package:weatherapp/view_model/settings_view_cubit/settings_view_cubit.dart';

Future<void> main() async {
  // Todo: init leri ayır
  final MainInitialize mainInitialize = MainInitialize();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await mainInitialize.sharedInit();
  mainInitialize.globalCubitInit();
  mainInitialize.cacheInit();
  await mainInitialize.getLocationPermission();
  mainInitialize.initNotificationServiceInstanceAndNotificationFeats();
  runApp(
    MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => GlobalManageProvider.globalManageCubit,
          ),
          BlocProvider(
            create: (context) => SettingsViewCubit(),
          ),
        ],
        child: EasyLocalization(
            child: Main(),
            supportedLocales: Appconst.supportedLocales,
            path: Appconst.path)),
  );
}

class Main extends StatelessWidget {
  Main({Key? key}) : super(key: key);
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
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
