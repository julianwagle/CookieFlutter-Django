import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:frontend/providers/locale_provider.dart';
import 'package:frontend/providers/login_provider.dart';
import 'package:frontend/responsive.dart';
import 'package:frontend/widgets/custom_app_bar.dart';
import 'package:frontend/widgets/custom_content_area.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomBase extends StatelessWidget {
  const CustomBase({
    required this.child,
    this.banner,
    Key? key,
  }) : super(key: key);

  final Widget child;
  final Widget? banner;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, _) {
        final isLoginUserLoading = watch(loginProvider).isLoading;
        final isLocaleLoading = watch(localeProvider).isLoading;
        return isLoginUserLoading || isLocaleLoading
            ? Container()
            : Responsive(
                desktop: _CustomBaseContent(banner: banner, child: child),
                mobile: _ScaledContent(
                  child: _CustomBaseContent(banner: banner, child: child),
                ),
              );
      },
    );
  }
}

class _CustomBaseContent extends StatelessWidget {
  const _CustomBaseContent({
    required this.banner,
    required this.child,
  });

  final Widget? banner;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const CustomAppBar(),
                if (banner != null) banner!,
                CustomContentArea(child: child),
                const SizedBox(height: 66),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: _BottomBar(),
        ),
      ],
    );
  }
}

class _BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 66,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Color(0xFF29323C),
            Color(0xFF485563),
          ],
        ),
      ),
      child: Center(
        child: CustomContentArea(
          child: Row(
            children: [
              Consumer(
                builder: (context, watch, _) {
                  return DropdownButton<String>(
                    focusColor: Colors.white,
                    dropdownColor: const Color(0xFF485563),
                    iconEnabledColor: Colors.white,
                    underline: Container(),
                    style: const TextStyle(color: Colors.white),
                    value: watch(localeProvider).locale.languageCode,
                    onChanged: (val) {
                      context.read(localeProvider).locale = Locale(val!);
                    },
                    items: const [
                      DropdownMenuItem(
                        value: 'en',
                        child: Text('English'),
                      ),
                      DropdownMenuItem(
                        value: 'ja',
                        child: Text('日本語'),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ScaledContent extends StatelessWidget {
  const _ScaledContent({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const logicWidth = 1000.0;
        final logicHeight =
            logicWidth * (constraints.maxHeight / constraints.maxWidth);
        return SizedBox.expand(
          child: FittedBox(
            fit: BoxFit.contain,
            child: SizedBox(
              width: logicWidth,
              height: logicHeight,
              child: child,
            ),
          ),
        );
      },
    );
  }
}
