

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

AutoRoute autoRouteComponent(
    {required PageInfo page,
      bool? initial,
      List<AutoRoute>? children}) {
  return CustomRoute(
      page: page,
      durationInMilliseconds: 300,
      transitionsBuilder: _slideTransition,
      initial: initial ?? false,
      children: children);
}

Widget _slideTransition(BuildContext context, Animation<double> animation,
    Animation<double> secondaryAnimation, Widget child) {
  return SlideTransition(
    position: Tween<Offset>(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).animate(animation),
    child: child,
  );
}