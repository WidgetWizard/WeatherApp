import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/product/global/cubit/global_manage_cubit.dart';
import 'package:weatherapp/product/global/cubit/global_manage_state.dart';
import 'package:weatherapp/service/shared_preferences.dart';

import '../global/provider/global_manage_provider.dart';

class ActiveOrPassiveButton extends StatefulWidget {
  const ActiveOrPassiveButton({Key? key, required this.sharedKeys})
      : super(key: key);
  final SharedKeys sharedKeys;

  @override
  State<ActiveOrPassiveButton> createState() => _ActiveOrPassiveButtonState();
}

class _ActiveOrPassiveButtonState extends State<ActiveOrPassiveButton> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalManageCubit, GlobalManageState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            GlobalManageProvider.globalManageCubit.changeDarkMode(widget.sharedKeys);
          },
          child: Container(
            width: 60,
            height: 30,
            decoration: BoxDecoration(
              color: (state.darkModeIsActive ?? false) ? Color(0xff0f1bbf) : Colors.grey,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Stack(
              alignment: (state.darkModeIsActive ?? false) ? Alignment.centerRight : Alignment
                  .centerLeft,
              children: [
                AnimatedPositioned(
                  left: (state.darkModeIsActive ?? false) ? 35 : 5,
                  right: (state.darkModeIsActive ?? false) ? 5 : 35,
                  duration: const Duration(milliseconds: 150),
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
