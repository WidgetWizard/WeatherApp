

import 'package:flutter/cupertino.dart';
import 'package:weather_app/product/extension/context/size.dart';

class _ContextBorderRadiusExtension{
  _ContextBorderRadiusExtension(BuildContext context) : _context = context;
  final BuildContext _context;

  BorderRadius get smallBorderRadius => BorderRadius.circular(_context.sized.height * 0.02); //12
  BorderRadius get largeBorderRadius => BorderRadius.circular(_context.sized.height * 0.04); //20
}

extension ContextBorderRadiusExtension on BuildContext{
  _ContextBorderRadiusExtension get border => _ContextBorderRadiusExtension(this);
}