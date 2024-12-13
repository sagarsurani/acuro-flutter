import 'package:acuro/application/application/auth/bloc/AuthBloc.dart';
import 'package:acuro/core/di/Injectable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/constants/Constants.dart';
import 'core/navigator/AppRouter.dart';
import 'core/theme/AppTheme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final appRouter = AppRouter();

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
      ),
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<AuthBloc>()),
      ],
      child: ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (BuildContext context, Widget? child) {
            return MaterialApp.router(
              title: ACURO,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              backButtonDispatcher: RootBackButtonDispatcher(),
              routeInformationParser: appRouter.defaultRouteParser(),
              routerDelegate: appRouter.delegate(
                navigatorObservers: () => [],
              ),
              locale: const Locale("en"),
              debugShowCheckedModeBanner: false,
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
            );
          }),
    );
  }
}
