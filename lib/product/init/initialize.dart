
import 'package:flutter/cupertino.dart';

import '../../service/shared_preferences.dart';

class MainInitialize{
  Future<void> sharedInit() async {
    WidgetsFlutterBinding.ensureInitialized();
    await SharedManager().init(); // init yöntemini çağırarak SharedManager'ı başlat
    SharedManager.initializeInstance();
  }
}