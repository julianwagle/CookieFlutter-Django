import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:frontend/l10n/L10n.dart';
import 'package:frontend/providers/locale_provider.dart';
import 'package:frontend/providers/login_provider.dart';
import 'package:frontend/router/router.gr.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _appRouter = AppRouter();
    context.read(loginProvider).init(context);
    context.read(localeProvider).init();
    return Consumer(builder: (context, watch, _) {
      return MaterialApp.router(
        title: 'Flutter Realworld App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          scrollbarTheme: ScrollbarThemeData(
            isAlwaysShown: true,
            thickness: MaterialStateProperty.resolveWith((states) => 10),
            showTrackOnHover: true,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
          ),
          primaryColor: const Color(0xFF5CB85C),
        ),
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
        supportedLocales: L10n.supportedLocales,
        locale: watch(localeProvider).locale,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
      );
    });
  }
}
