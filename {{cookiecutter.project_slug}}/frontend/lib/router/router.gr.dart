// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;

import '../pages/article/article_page.dart' as _i6;
import '../pages/login/login_page.dart' as _i4;
import '../pages/main/main_page.dart' as _i3;
import '../pages/register/register_page.dart' as _i5;
import '../pages/settings/settings_page.dart' as _i7;

class AppRouter extends _i1.RootStackRouter {
  AppRouter([_i2.GlobalKey<_i2.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    MainRoute.name: (routeData) => _i1.CustomPage<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i3.MainPage();
        },
        opaque: true,
        barrierDismissible: false),
    LoginRoute.name: (routeData) => _i1.CustomPage<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i4.LoginPage();
        },
        opaque: true,
        barrierDismissible: false),
    RegisterRoute.name: (routeData) => _i1.CustomPage<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i5.RegisterPage();
        },
        opaque: true,
        barrierDismissible: false),
    ArticleRoute.name: (routeData) => _i1.CustomPage<dynamic>(
        routeData: routeData,
        builder: (data) {
          final pathParams = data.pathParams;
          final args = data.argsAs<ArticleRouteArgs>(
              orElse: () => ArticleRouteArgs(id: pathParams.getString('id')));
          return _i6.ArticlePage(id: args.id);
        },
        opaque: true,
        barrierDismissible: false),
    SettingsRoute.name: (routeData) => _i1.CustomPage<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i7.SettingsPage();
        },
        opaque: true,
        barrierDismissible: false)
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(MainRoute.name, path: '/'),
        _i1.RouteConfig(LoginRoute.name, path: '/login'),
        _i1.RouteConfig(RegisterRoute.name, path: '/register'),
        _i1.RouteConfig(ArticleRoute.name, path: '/article/:id'),
        _i1.RouteConfig(SettingsRoute.name, path: '/settings')
      ];
}

class MainRoute extends _i1.PageRouteInfo {
  const MainRoute() : super(name, path: '/');

  static const String name = 'MainRoute';
}

class LoginRoute extends _i1.PageRouteInfo {
  const LoginRoute() : super(name, path: '/login');

  static const String name = 'LoginRoute';
}

class RegisterRoute extends _i1.PageRouteInfo {
  const RegisterRoute() : super(name, path: '/register');

  static const String name = 'RegisterRoute';
}

class ArticleRoute extends _i1.PageRouteInfo<ArticleRouteArgs> {
  ArticleRoute({required String id})
      : super(name,
            path: '/article/:id',
            args: ArticleRouteArgs(id: id),
            rawPathParams: {'id': id});

  static const String name = 'ArticleRoute';
}

class ArticleRouteArgs {
  const ArticleRouteArgs({required this.id});

  final String id;
}

class SettingsRoute extends _i1.PageRouteInfo {
  const SettingsRoute() : super(name, path: '/settings');

  static const String name = 'SettingsRoute';
}
