import 'package:flutter/material.dart';

class _ContextNavigationExtension {
  _ContextNavigationExtension(BuildContext context) : _context = context;
  final BuildContext _context;

  NavigatorState get navigation => Navigator.of(_context);

  Future<bool> maybePop<T extends Object?>([T? data]) => navigation.maybePop(data);
  void pop<T extends Object?>([T? result]) => navigation.pop();

  Future<Object?> navigatePushNamed<T extends Object?> (
      String path,
      {Object? data,
      }) => navigation.pushNamed<T>(path,arguments: data);

  Future<Object?> navigatePushAndRemoveUntil<T extends Object?>(
          String path, {Object? data}) =>
      navigation.pushNamedAndRemoveUntil<T>(path, (route) => false,
          arguments: data);

  Future<T?> navigatePush<T extends Object?>(Widget page, {Object? data}) =>
      navigation.push<T>(MaterialPageRoute(
          builder: (context) => page,
          settings: RouteSettings(arguments: data)));

  Future<T?> pushReplacement<T extends Object?,T0 extends Object?>(Widget page,{T0? result}) =>
      navigation.pushReplacement(MaterialPageRoute(builder: (context) => page,),result: result);
}

extension NavigationExtension on BuildContext{
  _ContextNavigationExtension get route => _ContextNavigationExtension(this);
}