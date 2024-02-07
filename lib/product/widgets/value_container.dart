import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:weatherapp/product/extension/context/general.dart';
import 'package:weatherapp/product/extension/context/size.dart';

class ValueContainer extends StatelessWidget {
  const ValueContainer({Key? key, required this.valueName, this.percent, this.isPercentage, this.isRain}) : super(key: key);
  final String valueName;
  final double? percent;
  final bool? isPercentage;
  final bool? isRain;
  @override
  Widget build(BuildContext context) {
    const shadow = Shadow(
      offset: Offset(1.0, 1.0),
      blurRadius: 3.0,
      color: Colors.black,
    );
    return SizedBox(
      height: context.sized.dynamicHeigth(0.16),
      width: context.sized.dynamicWidth(0.25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(valueName,style: context.general.textTheme.titleLarge?.copyWith(color: Colors.white,shadows: <Shadow>[shadow,],),),
          Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
            Text("${percent ?? "unknown"}",style: context.general.textTheme.titleLarge?.copyWith(color: Colors.white, shadows: <Shadow>[shadow,],),),
            Text((isPercentage ?? false) ? 'km/h' : (isRain ?? false) ? "mm" : "%",
                style: context.general.textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  shadows: <Shadow>[shadow,],
                ),
              ),
            ],),
          LinearPercentIndicator(
            padding: EdgeInsets.zero,
            progressColor: Colors.red,
            percent: (percent ?? 0) / 100,
            backgroundColor: Colors.white24,
          ),
        ],
      ),
    );
  }
}
