
import 'package:flutter/material.dart';
import 'package:weather_app/product/extension/context/general.dart';

class _ContextSizeExtension{
  _ContextSizeExtension(BuildContext context) : _context = context;
  final BuildContext _context;

  double get width => _context.general.mediaQuery.size.width;
  double get height => _context.general.mediaQuery.size.height;

  double get kZero => 0;
  double get smallValue => height * 0.0075;
  double get normalValue => height * 0.015;
  double get mediumValue => height * 0.03;
  double get littleLargeValue => height * 0.04;
  double get largeValue => height * 0.1;
  double get floatActionButtonSize => height * 0.08;
  double get middleButtonSize => height * 0.06;

  double dynamicWidth(double value) => width * value;
  double dynamicHeigth(double value) => height * value;
}

extension ContextSizeExtension on BuildContext{
  _ContextSizeExtension get sized => _ContextSizeExtension(this);
}