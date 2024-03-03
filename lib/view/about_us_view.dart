import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/product/extension/context/general.dart';
import 'package:weatherapp/product/extension/context/navigation.dart';
import 'package:weatherapp/product/extension/context/padding.dart';
import 'package:weatherapp/product/extension/context/size.dart';
import 'package:weatherapp/product/global/cubit/global_manage_cubit.dart';
import 'package:weatherapp/product/global/cubit/global_manage_state.dart';
import 'package:weatherapp/product/global/provider/global_manage_provider.dart';

import '../core/custom_elevated_button.dart';

class AboutUsView extends StatelessWidget {
  const AboutUsView({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalManageCubit, GlobalManageState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: state.themeData?.colorScheme.background,
          body: Padding(
            padding: context.padding.mediumSymmetricHorizontal,
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _aboutUsTitleAndBackButton(context),
                  _biographyText(context),
                  _biographyContent(context),
                  _contactUsText(context),
                  _contactUsContent(context,
                      text: "fy454525@gmail.com => Furkan Yıldırım"),
                  _contactUsContent(context,
                      text: "fy454525@gmail.com => Furkan Yıldırım"),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Padding _contactUsContent(BuildContext context, {required String text}) {
    return Padding(
      padding: context.padding.topOnlySmall,
      child: RichText(
        text: TextSpan(children: [
          WidgetSpan(
              child: Padding(
            padding: context.padding.rightOnlyNormal,
            child: Icon(
              Icons.mail_outline_outlined,
              color: Colors.grey,
            ),
          )),
          TextSpan(
              text: text,
              style: context.general.textTheme.titleMedium
                  ?.copyWith(color: Colors.grey)),
        ]),
      ),
    );
  }

  Padding _contactUsText(BuildContext context) {
    return Padding(
      padding: context.padding.topOnlyNormal,
      child: Text(
        'İletişime geç',
          style: GlobalManageProvider.globalManageCubit.state.themeData?.textTheme.titleLarge
      ),
    );
  }

  Text _biographyText(BuildContext context) {
    return Text(
      'Biyografi',
      style: GlobalManageProvider.globalManageCubit.state.themeData?.textTheme.titleLarge
    );
  }

  Padding _biographyContent(BuildContext context) {
    return Padding(
      padding: context.padding.topOnlyNormal,
      child: RichText(
        text: TextSpan(
          children: [
            WidgetSpan(
              child: Padding(
                padding: context.padding.rightOnlyNormal,
                child: Icon(
                  Icons.school_outlined,
                  color: Colors.grey,
                ),
              ),
            ),
            TextSpan(
              style: context.general.textTheme.titleMedium
                  ?.copyWith(color: Colors.grey),
              text:
                  'Balıkesir Universitesi Bilgisayar Mühendisliği 3. sınıf öğrencileri',
            ),
            TextSpan(
                text:
                    " \n\nFlutter ile mobil programlama geliştirme konusunda kendilerini geliştiren Furkan yıldırım ve Mustafa Al tarafından geliştirilmiştir.",
                style: context.general.textTheme.titleMedium
                    ?.copyWith(color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Padding _aboutUsTitleAndBackButton(BuildContext context) {
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
                color: GlobalManageProvider.globalManageCubit.state.themeData?.primaryColor,
                size: 20,
              ),
              onPressed: () {
                context.route.pop();
              },
              width: buttonWidth,
              backgroundColor: Colors.transparent,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(buttonWidth / 2)),
            ),
          ),
          Text(
            'Hakkımızda',
            style: GlobalManageProvider.globalManageCubit.state.themeData?.textTheme.headlineMedium
          ),
        ],
      ),
    );
  }
}
