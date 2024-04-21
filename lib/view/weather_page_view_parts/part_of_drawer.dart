import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/product/extension/context/general.dart';
import 'package:weatherapp/product/extension/context/navigation.dart';
import 'package:weatherapp/product/extension/context/size.dart';
import 'package:weatherapp/product/global/cubit/global_manage_cubit.dart';
import 'package:weatherapp/product/global/cubit/global_manage_state.dart';

import '../about_us_view.dart';
import '../settings_view.dart';

class PartOfWeatherPageDrawer extends StatelessWidget {
  const PartOfWeatherPageDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalManageCubit, GlobalManageState>(
      builder: (context, state) {
        return Drawer(
          width: context.sized.width * 0.5,
          backgroundColor: context.general.theme.colorScheme.background,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ListTile(
                leading: Icon(
                  Icons.settings,
                  color: context.general.theme.primaryColor,
                ),
                title: Text(
                  'Settings',
                  style: context.general.textTheme.titleLarge
                ),
                onTap: () {
                  context.route.pop();
                  context.route.navigatePush(SettingsView());
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.person,
                  color: context.general.theme.primaryColor,
                ),
                title: Text(
                  'About Us',
                  style: context.general.textTheme.titleLarge
                ),
                onTap: () {
                  context.route.pop();
                  context.route.navigatePush(AboutUsView());
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
