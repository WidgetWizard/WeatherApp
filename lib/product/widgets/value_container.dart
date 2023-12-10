import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:weatherapp/product/extension/context/general.dart';
import 'package:weatherapp/product/extension/context/size.dart';

class ValueContainer extends StatelessWidget {
  const ValueContainer({Key? key, required this.valueName, required this.percent, this.isPercentage}) : super(key: key);
  final String valueName;
  final double percent;
  final bool? isPercentage;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.sized.dynamicHeigth(0.16),
      width: context.sized.dynamicWidth(0.25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(valueName,style: context.general.textTheme.titleLarge?.copyWith(color: Colors.white),),
          Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
            Text("$percent",style: context.general.textTheme.titleLarge?.copyWith(color: Colors.white),),
            Text((isPercentage ?? false) ? 'km/h' : "%",style: context.general.textTheme.titleLarge?.copyWith(color: Colors.white),),
          ],),
          LinearPercentIndicator(
            padding: EdgeInsets.zero,
            progressColor: Colors.red,
            percent: percent / 100,
            backgroundColor: Colors.white24,
          ),
        ],
      ),
    );
  }
}
