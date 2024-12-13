
import 'package:acuro/app.dart';
import 'package:flutter/material.dart';

BuildContext _context = appRouter.navigatorKey.currentState!.context;

class GlobalConstant{
  static FocusScopeNode focusScopeNode = FocusScope.of(_context);
  static GlobalKey<ScaffoldState> globalScaffoldKey = GlobalKey<ScaffoldState>();
  static BuildContext currentPageContext = _context;

}