import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/core/custom_elevated_button.dart';
import 'package:weatherapp/product/extension/context/duration.dart';
import 'package:weatherapp/product/extension/context/general.dart';
import 'package:weatherapp/product/extension/context/navigation.dart';
import 'package:weatherapp/product/extension/context/padding.dart';
import 'package:weatherapp/product/extension/context/size.dart';
import 'package:weatherapp/product/global/cubit/global_manage_cubit.dart';
import 'package:weatherapp/product/global/cubit/global_manage_state.dart';
import 'package:weatherapp/product/global/provider/global_manage_provider.dart';
import 'package:weatherapp/product/widgets/active_or_passive_button.dart';
import 'package:weatherapp/service/shared_preferences.dart';
import 'package:weatherapp/view_model/settings_view_cubit/settings_view_cubit.dart';
import 'package:weatherapp/view_model/settings_view_cubit/settings_view_state.dart';

class SettingsView extends StatelessWidget with _SettingsViewUtility {
  const SettingsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext buildContext) {
    return BlocBuilder<GlobalManageCubit, GlobalManageState>(
      builder: (context, state) {
        return Scaffold(
          body: AnimatedContainer(
            color: state.themeData?.colorScheme.background,
            duration: context.duration.durationFast,
            child: SafeArea(
              child: Padding(
                padding: context.padding.mediumSymmetricHorizontal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _settingsTitleAndBackButton(buildContext),
                    _SettingsCard(
                      title: "Language".tr(),
                      leadingIcon: Icons.question_answer_outlined,
                      trailingWidget: _languageContent(context),
                      leadingColor: Color(0xff3b78c0),
                      circleAvatarBackgroundColor: Color(0xffe5eef9),
                    ),
                    _SettingsCard(
                      title: "Dark Mode",
                      circleAvatarBackgroundColor: Color(0xfff6e8d6),
                      leadingColor: Color(0xfff99417),
                      leadingIcon: Icons.dark_mode,
                      trailingWidget: ActiveOrPassiveButton(
                        sharedKeys: SharedKeys.darkMode,
                      ),
                    ),
                    _SettingsCard(
                      title: "Temperature Unit ",
                      circleAvatarBackgroundColor: Color(0xffebebf1),
                      leadingIcon: Icons.thermostat_outlined,
                      leadingColor: Color(0xffff5050),
                      trailingWidget:
                          _settingsCardButton(context, onPressed: () {
                        _showTemperatureUnitDialog(context);
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SettingsCard extends StatelessWidget {
  const _SettingsCard({
    Key? key,
    required this.title,
    required this.leadingIcon,
    required this.trailingWidget,
    required this.leadingColor,
    required this.circleAvatarBackgroundColor,
  }) : super(key: key);
  final String title;
  final IconData leadingIcon;
  final Color leadingColor;
  final Widget trailingWidget;
  final Color circleAvatarBackgroundColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      child: ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(title,
              style: GlobalManageProvider
                  .globalManageCubit.state.themeData?.textTheme.titleLarge),
          leading: CircleAvatar(
              backgroundColor: circleAvatarBackgroundColor,
              radius: 25,
              child: Icon(
                leadingIcon,
                color: leadingColor,
                size: 35,
              )),
          trailing: trailingWidget),
    );
  }
}

mixin _SettingsViewUtility {
  Padding _settingsCardButton(BuildContext context,
      {required void Function() onPressed}) {
    return Padding(
      padding: context.padding.dynamicOnly(left: 0.01),
      child: CustomElevatedButton(
        width: context.sized.width * 0.12,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Icon(
            size: 16, Icons.arrow_forward_ios_outlined, color: Colors.black),
        onPressed: onPressed,
        elevation: 0,
        backgroundColor: Color(0xffebebf1),
      ),
    );
  }

  Padding _settingsTitleAndBackButton(BuildContext context) {
    var buttonWidth = context.sized.dynamicWidth(0.12);
    return Padding(
      padding: context.padding.dynamicOnly(top: 0.18, bottom: 0.05),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: context.padding.rightOnlyNormal,
            child: CustomElevatedButton(
              height: buttonWidth,
              child: Icon(
                Icons.arrow_back_ios_new_outlined,
                color: Colors.black,
                size: 20,
              ),
              onPressed: () {
                context.route.pop();
              },
              width: buttonWidth,
              backgroundColor: Color(0xffebebf1),
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(buttonWidth / 2)),
            ),
          ),
          Text('Settings',
              style: GlobalManageProvider
                  .globalManageCubit.state.themeData?.textTheme.headlineMedium),
        ],
      ),
    );
  }

  Container _languageContent(BuildContext context) {
    return Container(
      padding: context.padding.dynamicOnly(left: 0.017),
      width: context.sized.width * 0.32,
      child: Row(
        children: [
          Text(
            'Güncel dil',
            style: context.general.textTheme.titleSmall
                ?.copyWith(color: Colors.grey),
          ),
          _settingsCardButton(context, onPressed: () {}),
        ],
      ),
    );
  }

  Card _temperatureUnitCard(
      {required String title,
      required void Function() onTap,
      required SettingsViewState settingsState,
      required int index}) {
    return Card(
      child: ListTile(
        title: Center(
            child: Text(
          title,
          style: GlobalManageProvider
              .globalManageCubit.state.themeData?.textTheme.titleLarge,
        )),
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: (settingsState.temperatureItems?[index].isSelected ?? false)
          ? Color(0xff0f1bbf)
          : GlobalManageProvider
              .globalManageCubit.state.themeData?.cardTheme.color,
    );
  }

  void _showTemperatureUnitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocBuilder<SettingsViewCubit, SettingsViewState>(
          builder: (context, state) {
            return AlertDialog(
              backgroundColor: GlobalManageProvider.globalManageCubit.state
                  .themeData?.dialogTheme.backgroundColor,
              title: Text(
                'Select Temperature Unit',
                style: GlobalManageProvider
                    .globalManageCubit.state.themeData?.textTheme.headlineSmall,
              ),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    SizedBox(
                      width: context.sized.dynamicWidth(0.6),
                      height: context.sized.dynamicHeigth(0.28),
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: state.temperatureItems?.length,
                        itemBuilder: (context, index) {
                          return _temperatureUnitCard(
                            index: index,
                            settingsState: state,
                            title: (state
                                    .temperatureItems?[index].temperatureName ??
                                "Unknown"),
                            onTap: () {
                              context
                                  .read<SettingsViewCubit>()
                                  .changeTemperatureUnitActiveValue(index);
                              GlobalManageProvider.globalManageCubit
                                  .getTemperatureUnit(index);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
