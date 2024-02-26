import 'package:flutter/material.dart';
import 'package:weatherapp/service/shared_preferences.dart';

class ActiveOrPassiveButton extends StatefulWidget {
  const ActiveOrPassiveButton({Key? key, required this.sharedKeys})
      : super(key: key);
  final SharedKeys sharedKeys;

  @override
  State<ActiveOrPassiveButton> createState() => _ActiveOrPassiveButtonState();
}

class _ActiveOrPassiveButtonState extends State<ActiveOrPassiveButton> {
  late bool isActive = false;
  bool isLoading = false;

  @override
  void initState() {
    _initialize();
    super.initState();
  }

  Future<void> _initialize() async {
    changeLoading();
    if(SharedManager.instance.preferences != null){
      switch(widget.sharedKeys){
        case SharedKeys.darkMode:
          isActive = SharedManager.instance.getBool(SharedKeys.darkMode) ?? false;
      }
    }
    changeLoading();
  }

  void changeLoading() {
    setState(() {
      isLoading == !isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isActive = !isActive;
          switch (widget.sharedKeys) {
            case SharedKeys.darkMode:
              SharedManager.instance.saveBool(SharedKeys.darkMode, isActive);
          }
        });
      },
      child: Container(
        width: 60,
        height: 30,
        decoration: BoxDecoration(
          color: isActive ? Color(0xff0f1bbf) : Colors.grey,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          alignment: isActive ? Alignment.centerRight : Alignment.centerLeft,
          children: [
            AnimatedPositioned(
              left: isActive ? 35 : 5,
              right: isActive ? 5 : 35,
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
  }
}
