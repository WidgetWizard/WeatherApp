
import 'package:flutter/material.dart';

class _ContextGeneralExtension{
  _ContextGeneralExtension(BuildContext context) : _context = context;
  final BuildContext _context;

  MediaQueryData get mediaQuery => MediaQuery.of(_context);
  ThemeData get theme => Theme.of(_context);
  TextTheme get textTheme => Theme.of(_context).textTheme;
}

extension ContextExtension on BuildContext{
  _ContextGeneralExtension get general => _ContextGeneralExtension(this);
}