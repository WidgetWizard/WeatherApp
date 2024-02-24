import 'package:flutter/material.dart';
import 'package:weatherapp/core/custom_elevated_button.dart';
import 'package:weatherapp/product/extension/context/general.dart';
import 'package:weatherapp/product/extension/context/navigation.dart';
import 'package:weatherapp/product/extension/context/padding.dart';
import 'package:weatherapp/product/extension/context/size.dart';
import 'package:weatherapp/product/widgets/active_or_passive_button.dart';
import 'package:weatherapp/service/shared_preferences.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: context.padding.mediumSymmetricHorizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _settingsTitleAndBackButton(context),
              _SettingsCard(
                title: "Language",
                leadingIcon: Icons.question_answer_outlined,
                trailingWidget: _languageContent(context),
                leadingColor: Color(0xff3b78c0), circleAvatarBackgroundColor: Color(0xffe5eef9),),
              _SettingsCard(
                title: "Notification",
                leadingIcon: Icons.notifications,
                circleAvatarBackgroundColor: Color(0xffffe9e9),
                leadingColor: Color(0xffff6969),
                trailingWidget: _settingsCardButton(context),
              ),
              _SettingsCard(
                title: "Dark Mode",
                circleAvatarBackgroundColor: Color(0xfff6e8d6),
                leadingColor: Color(0xfff99417),
                leadingIcon: Icons.dark_mode,
                trailingWidget: ActiveOrPassiveButton(sharedKeys: SharedKeys.darkMode,),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding _settingsTitleAndBackButton(BuildContext context) {
    var buttonWidth = context.sized.dynamicWidth(0.12);
    return Padding(
              padding: context.padding.dynamicOnly(top: 0.18,bottom: 0.05),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: context.padding.rightOnlyNormal,
                    child: CustomElevatedButton(
                      height: buttonWidth,
                        child: Icon(Icons.arrow_back_ios_new_outlined,color: Colors.black,size: 20,),
                        onPressed: () {context.route.pop();},
                      width: buttonWidth,
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(buttonWidth / 2)),
                    ),
                  ),
                  Text('Settings',
                  style: context.general.textTheme.headlineMedium?.copyWith(color: Colors.black,fontWeight: FontWeight.w500),),
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
          Text('Güncel dil',style: context.general.textTheme.titleSmall?.copyWith(color: Colors.grey),),
          _settingsCardButton(context),
        ],
      ),
    );
  }

  Padding _settingsCardButton(BuildContext context) {
    return Padding(
      padding: context.padding.dynamicOnly(left: 0.01),
      child: CustomElevatedButton(
        width: context.sized.width * 0.12,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Icon(
          size: 16,
          Icons.arrow_forward_ios_outlined,
          color: Colors.black,
        ),
        onPressed: () {},
        elevation: 0,
        backgroundColor: Color(0xffebebf1),
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  const _SettingsCard({Key? key, required this.title, required this.leadingIcon, required this.trailingWidget, required this.leadingColor, required this.circleAvatarBackgroundColor}) : super(key: key);
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
        title: Text(title,style: context.general.textTheme.titleLarge?.copyWith(color: Colors.black),),
        leading: CircleAvatar(
          backgroundColor: circleAvatarBackgroundColor,
            radius: 25,
            child: Icon(
              leadingIcon,
              color: leadingColor,
              size: 35,
            )),
        trailing: trailingWidget
      ),
    );
  }
}
