// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/gallery_localizations.dart';
import 'package:gallery/constants.dart';
import 'package:gallery/data/gallery_options.dart';
import 'package:gallery/layout/adaptive.dart';
import 'package:gallery/layout/image_placeholder.dart';
import 'package:gallery/layout/text_scale.dart';
import 'package:gallery/rally/app.dart';
import 'package:gallery/rally/colors.dart';
import 'package:gallery/rally/routes.dart' as rally_routes;

import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with RestorationMixin {
  final RestorableTextEditingController _usernameController =
      RestorableTextEditingController();
  final RestorableTextEditingController _emailController =
      RestorableTextEditingController();
  final RestorableTextEditingController _passwordController =
      RestorableTextEditingController();
  final RestorableTextEditingController _passwordRepeatController =
      RestorableTextEditingController();

  @override
  String get restorationId => 'register_page';

  @override
  void restoreState(RestorationBucket oldBucket, bool initialRestore) {
    registerForRestoration(_usernameController, restorationId);
    registerForRestoration(_emailController, restorationId);
    registerForRestoration(_passwordController, restorationId);
    registerForRestoration(_passwordRepeatController, restorationId);
  }

  @override
  Widget build(BuildContext context) {
    return ApplyTextOptions(
      child: Scaffold(
        appBar: AppBar(automaticallyImplyLeading: false),
        body: SafeArea(
          child: _MainView(
            usernameController: _usernameController.value,
            emailController: _emailController.value,
            passwordController: _passwordController.value,
            passwordRepeatController: _passwordRepeatController.value,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordRepeatController.dispose();
    super.dispose();
  }
}

class _MainView extends StatelessWidget {
  const _MainView({
    Key key,
    this.usernameController,
    this.emailController,
    this.passwordController,
    this.passwordRepeatController,
  }) : super(key: key);

  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController passwordRepeatController;

  void _register(BuildContext context) async {
    final response = await http.post(
      Uri.parse('https://$domain_name/dj-rest-auth/registration/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': usernameController.text,
        'email': emailController.text,
        'password1': passwordController.text,
        'password2': passwordRepeatController.text,
      }),
    );
    final resp = jsonDecode(response.body);
    print(resp);
    if (resp['detail'] == 'Verification e-mail sent.') {
      print('Verification e-mail sent. Please check you email.');
    } else {
      print('There was an error creating your profile.');
    }
    return resp;
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);
    List<Widget> listViewChildren;

    if (isDesktop) {
      final desktopMaxWidth = 400.0 + 100.0 * (cappedTextScale(context) - 1);
      listViewChildren = [
        _UsernameInput(
          maxWidth: desktopMaxWidth,
          usernameController: usernameController,
        ),
        const SizedBox(height: 12),
        _EmailInput(
          maxWidth: desktopMaxWidth,
          emailController: emailController,
        ),
        const SizedBox(height: 12),
        _PasswordInput(
          maxWidth: desktopMaxWidth,
          passwordController: passwordController,
        ),
        const SizedBox(height: 12),
        _PasswordRepeatInput(
          maxWidth: desktopMaxWidth,
          passwordRepeatController: passwordRepeatController,
        ),
        _RegisterButton(
          maxWidth: desktopMaxWidth,
          onTap: () {
            _register(context);
          },
        ),
      ];
    } else {
      listViewChildren = [
        const _SmallLogo(),
        _UsernameInput(
          usernameController: usernameController,
        ),
        const SizedBox(height: 12),
        _EmailInput(
          emailController: emailController,
        ),
        const SizedBox(height: 12),
        _PasswordInput(
          passwordController: passwordController,
        ),
        const SizedBox(height: 12),
        _PasswordRepeatInput(
          passwordRepeatController: passwordRepeatController,
        ),
        _ThumbButton(
          onTap: () {
            _register(context);
          },
        ),
      ];
    }

    return Column(
      children: [
        if (isDesktop) const _TopBar(),
        Expanded(
          child: Align(
            alignment: isDesktop ? Alignment.center : Alignment.topCenter,
            child: ListView(
              restorationId: 'register_list_view',
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              children: listViewChildren,
            ),
          ),
        ),
      ],
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const spacing = SizedBox(width: 30);
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ExcludeSemantics(
                child: SizedBox(
                  height: 80,
                  child: FadeInImagePlaceholder(
                    image:
                        const AssetImage('logo.png', package: 'rally_assets'),
                    placeholder: LayoutBuilder(builder: (context, constraints) {
                      return SizedBox(
                        width: constraints.maxHeight,
                        height: constraints.maxHeight,
                      );
                    }),
                  ),
                ),
              ),
              spacing,
              Text(
                GalleryLocalizations.of(context).rallyRegisterRegisterToRally,
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                      fontSize: 35 / reducedTextScale(context),
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                GalleryLocalizations.of(context).rallyRegisterYesAccount,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              spacing,
              _BorderButton(
                text: GalleryLocalizations.of(context).rallyLoginButtonLogin,
                onTap: () {
                  Navigator.of(context)
                      .restorablePushNamed(rally_routes.loginRoute);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SmallLogo extends StatelessWidget {
  const _SmallLogo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 64),
      child: SizedBox(
        height: 160,
        child: ExcludeSemantics(
          child: FadeInImagePlaceholder(
            image: AssetImage('logo.png', package: 'rally_assets'),
            placeholder: SizedBox.shrink(),
          ),
        ),
      ),
    );
  }
}

class _UsernameInput extends StatelessWidget {
  const _UsernameInput({
    Key key,
    this.maxWidth,
    this.usernameController,
  }) : super(key: key);

  final double maxWidth;
  final TextEditingController usernameController;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        constraints: BoxConstraints(maxWidth: maxWidth ?? double.infinity),
        child: TextField(
          textInputAction: TextInputAction.next,
          controller: usernameController,
          decoration: InputDecoration(
            labelText: GalleryLocalizations.of(context).rallyRegisterUsername,
          ),
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput({
    Key key,
    this.maxWidth,
    this.emailController,
  }) : super(key: key);

  final double maxWidth;
  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        constraints: BoxConstraints(maxWidth: maxWidth ?? double.infinity),
        child: TextField(
          textInputAction: TextInputAction.next,
          controller: emailController,
          decoration: InputDecoration(
            labelText: GalleryLocalizations.of(context).rallyRegisterEmail,
          ),
        ),
      ),
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput({
    Key key,
    this.maxWidth,
    this.passwordController,
  }) : super(key: key);

  final double maxWidth;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        constraints: BoxConstraints(maxWidth: maxWidth ?? double.infinity),
        child: TextField(
          controller: passwordController,
          decoration: InputDecoration(
            labelText: GalleryLocalizations.of(context).rallyRegisterPassword,
          ),
          obscureText: true,
        ),
      ),
    );
  }
}

class _PasswordRepeatInput extends StatelessWidget {
  const _PasswordRepeatInput({
    Key key,
    this.maxWidth,
    this.passwordRepeatController,
  }) : super(key: key);

  final double maxWidth;
  final TextEditingController passwordRepeatController;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        constraints: BoxConstraints(maxWidth: maxWidth ?? double.infinity),
        child: TextField(
          controller: passwordRepeatController,
          decoration: InputDecoration(
            labelText:
                GalleryLocalizations.of(context).rallyRegisterPasswordRepeat,
          ),
          obscureText: true,
        ),
      ),
    );
  }
}

class _ThumbButton extends StatefulWidget {
  const _ThumbButton({
    @required this.onTap,
  });

  final VoidCallback onTap;

  @override
  _ThumbButtonState createState() => _ThumbButtonState();
}

class _ThumbButtonState extends State<_ThumbButton> {
  BoxDecoration borderDecoration;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      enabled: true,
      label: GalleryLocalizations.of(context).rallyRegisterLabelRegister,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Focus(
          onKey: (node, event) {
            if (event is RawKeyDownEvent) {
              if (event.logicalKey == LogicalKeyboardKey.enter ||
                  event.logicalKey == LogicalKeyboardKey.space) {
                widget.onTap();
                return KeyEventResult.handled;
              }
            }
            return KeyEventResult.ignored;
          },
          onFocusChange: (hasFocus) {
            if (hasFocus) {
              setState(() {
                borderDecoration = BoxDecoration(
                  border: Border.all(
                    color: Colors.white.withOpacity(0.5),
                    width: 2,
                  ),
                );
              });
            } else {
              setState(() {
                borderDecoration = null;
              });
            }
          },
          child: Container(
            decoration: borderDecoration,
            height: 120,
            child: ExcludeSemantics(
              child: Image.asset(
                'thumb.png',
                package: 'rally_assets',
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _RegisterButton extends StatelessWidget {
  const _RegisterButton({
    Key key,
    @required this.onTap,
    this.maxWidth,
  }) : super(key: key);

  final double maxWidth;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        constraints: BoxConstraints(maxWidth: maxWidth ?? double.infinity),
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Row(
          children: [
            const Icon(Icons.check_circle_outline,
                color: RallyColors.buttonColor),
            const SizedBox(width: 12),
            Text(GalleryLocalizations.of(context).rallyRegisterRememberMe),
            const Expanded(child: SizedBox.shrink()),
            _FilledButton(
              text:
                  GalleryLocalizations.of(context).rallyRegisterButtonRegister,
              onTap: onTap,
            ),
          ],
        ),
      ),
    );
  }
}

class _BorderButton extends StatelessWidget {
  const _BorderButton({Key key, @required this.text, @required this.onTap})
      : super(key: key);

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        primary: Colors.white,
        side: const BorderSide(color: RallyColors.buttonColor),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: onTap,
      child: Row(
        children: [
          Text(text),
        ],
      ),
    );
  }
}

class _FilledButton extends StatelessWidget {
  const _FilledButton({Key key, @required this.text, @required this.onTap})
      : super(key: key);

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: RallyColors.buttonColor,
        primary: Colors.black,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: onTap,
      child: Row(
        children: [
          const Icon(Icons.lock),
          const SizedBox(width: 6),
          Text(text),
        ],
      ),
    );
  }
}
