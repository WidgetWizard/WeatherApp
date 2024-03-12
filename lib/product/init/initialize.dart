
import 'package:flutter/cupertino.dart';
import 'package:weatherapp/product/global/cubit/global_manage_cubit.dart';
import 'package:weatherapp/product/global/provider/global_manage_provider.dart';
import 'package:weatherapp/service/notification_service.dart';

import '../../service/shared_preferences.dart';

class MainInitialize{
  late final GlobalManageCubit _globalManageCubit;
  Future<void> sharedInit() async {
    WidgetsFlutterBinding.ensureInitialized();
    await SharedManager().init(); // init yöntemini çağırarak SharedManager'ı başlat
    SharedManager.initializeInstance();
  }

  void globalCubitInit(){
    _globalManageCubit = GlobalManageCubit();
    GlobalManageProvider.init(_globalManageCubit);
  }
  void cacheInit(){
    _globalManageCubit.getCacheValues(SharedKeys.darkMode);
  }

  void initNotificationServiceInstanceAndNotificationFeats(){
    NotificationService.init(NotificationService());
    NotificationService.instance.initializeNotification(null);
  }
}