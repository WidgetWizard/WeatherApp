import 'package:flutter/material.dart';
import 'package:weatherapp/product/extension/context/size.dart';


class _AppIconSize{
  _AppIconSize(BuildContext context) : _context = context;
  final BuildContext _context;
  double get small => _context.sized.dynamicHeigth(0.03);
  double get normal => _context.sized.dynamicHeigth(0.045);
  double get large => _context.sized.dynamicHeigth(0.06);
}

extension ContextAppIconSize on BuildContext{
  _AppIconSize get iconSize => _AppIconSize(this);
}