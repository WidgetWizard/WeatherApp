
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherapp/product/global/cubit/global_manage_cubit.dart';
import 'package:weatherapp/product/global/provider/global_manage_provider.dart';
import 'package:weatherapp/service/notification_service.dart';

import '../../service/shared_preferences.dart';

class MainInitialize{
  late final GlobalManageCubit _globalManageCubit;
  Future<void> sharedInit() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedManager.initializeInstance();
    await SharedManager.instance.init();
    print("init işlemleri tammalandı!");
  }

  void globalCubitInit(){
    _globalManageCubit = GlobalManageCubit();
    GlobalManageProvider.init(_globalManageCubit);
  }
  void cacheInit(){
    _globalManageCubit.getCacheValues(SharedKeys.darkMode);
  }

  Future<void> initNotificationServiceInstanceAndNotificationFeats() async {
    NotificationService.init(NotificationService());
    await NotificationService.instance.initializeNotification(null);
  }

  Future<void> getLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
  }
}