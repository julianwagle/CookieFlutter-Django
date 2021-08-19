import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:frontend/providers/login_provider.dart';
import 'package:frontend/router/router.dart';
import 'package:frontend/router/router.gr.dart';
import 'package:frontend/widgets/custom_content_area.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      child: Center(
        child: CustomContentArea(
          child: Consumer(builder: (context, watch, _) {
            final isLoggedIn = watch(loginProvider).isLoggedIn;
            return Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: TextButton(
                    style: ButtonStyle(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ),
                    onPressed: () {
                      if (context.router.current.path != mainPath) {
                        context.router.push(MainRoute());
                      }
                    },
                    child: Text(
                      '{{cookiecutter.project_name}}',
                      style: TextStyle(
                        fontSize: 25,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Spacer(),
                _NavigationButton(
                  path: mainPath,
                  text: 'Home',
                  route: MainRoute(),
                ),
                if (!isLoggedIn)
                  _NavigationButton(
                    path: loginPath,
                    text: 'Sign in',
                    route: LoginRoute(),
                  ),
                if (!isLoggedIn)
                  _NavigationButton(
                    path: registerPath,
                    text: 'Sign up',
                    route: RegisterRoute(),
                  ),
                if (isLoggedIn)
                  _NavigationButton(
                    path: registerPath,
                    text: 'New Articles',
                    route: RegisterRoute(),
                    icon: Icons.edit,
                  ),
                if (isLoggedIn)
                  _NavigationButton(
                    path: settingsPath,
                    text: 'Settings',
                    route: SettingsRoute(),
                    icon: Icons.settings,
                  ),
                if (isLoggedIn)
                  _NavigationButton(
                    path: registerPath,
                    text: context.read(loginProvider).user.username,
                    route: RegisterRoute(),
                  ),
                SizedBox(width: 20)
              ],
            );
          }),
        ),
      ),
    );
  }
}

class _NavigationButton extends StatelessWidget {
  const _NavigationButton({
    required this.text,
    required this.path,
    required this.route,
    this.icon,
  });

  final String text;
  final String path;
  final PageRouteInfo<dynamic> route;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: TextButton(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.resolveWith((states) =>
              states.contains(MaterialState.hovered)
                  ? Colors.black87
                  : Colors.black45),
          overlayColor: MaterialStateProperty.all(Colors.transparent),
        ),
        onPressed: () {
          if (context.router.current.path != path) {
            context.router.push(route);
          }
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (icon != null) Icon(icon, size: 16),
            Text(
              text,
              style: TextStyle(
                color:
                    context.router.current.path == path ? Colors.black : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
