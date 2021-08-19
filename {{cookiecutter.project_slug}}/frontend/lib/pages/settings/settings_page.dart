import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/errors/api_validation_error.dart';
import 'package:frontend/providers/login_provider.dart';
import 'package:frontend/responsive.dart';
import 'package:frontend/router/router.gr.dart';
import 'package:frontend/widgets/custom_base.dart';
import 'package:frontend/widgets/custom_form.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage();

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  List<String> errors = [];
  final imageController = TextEditingController();
  final usernameController = TextEditingController();
  final bioController = TextEditingController();
  final emailController = TextEditingController();
  final newPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      final user = context.read(loginProvider).user;
      imageController.text = user.image ?? '';
      usernameController.text = user.username;
      bioController.text = user.bio ?? '';
      emailController.text = user.email;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: CustomBase(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Text(
                  'Your Settings',
                  style: TextStyle(
                    color: Color(0xFF373A3C),
                    fontSize: 38,
                  ),
                ),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final width = Responsive.isMobile(context)
                        ? constraints.maxWidth
                        : constraints.maxWidth * 0.5;
                    return Container(
                      width: width,
                      child: Column(
                        children: [
                          CustomForm(
                            errors: errors,
                            submitText: 'Update Settings',
                            onSubmit: () {
                              _updateSettings();
                            },
                            children: [
                              CustomTextField(
                                hintText: 'URL of profile picture',
                                controller: imageController,
                              ),
                              CustomTextField(
                                hintText: 'Username',
                                controller: usernameController,
                              ),
                              CustomTextField(
                                hintText: 'Short bio about you',
                                maxLines: 9,
                                controller: bioController,
                              ),
                              CustomTextField(
                                hintText: 'Email',
                                controller: emailController,
                              ),
                              CustomTextField(
                                hintText: 'New Password',
                                controller: newPasswordController,
                              ),
                            ],
                          ),
                          Divider(
                            color: Colors.black26,
                            height: 40,
                            thickness: 1,
                          ),
                          _LogoutButton(),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _updateSettings() async {
    try {
      await context.read(loginProvider).updateUser(
            context,
            username: usernameController.text,
            image: imageController.text.isEmpty ? null : imageController.text,
            bio: bioController.text.isEmpty ? null : bioController.text,
            email: emailController.text,
            password: newPasswordController.text.isEmpty
                ? null
                : newPasswordController.text,
          );
    } on ApiValidationError catch (err) {
      errors = err.errors;
      setState(() {});
      return;
    }
    await context.router.pushAndPopUntil(
      MainRoute(),
      predicate: (route) => false,
    );
  }
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const color = Color(0xFFB85C5C);
    return Row(
      children: [
        TextButton(
          onPressed: () {
            _logout(context);
          },
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            foregroundColor: MaterialStateProperty.resolveWith((states) =>
                states.contains(MaterialState.hovered) ? Colors.white : color),
            backgroundColor: MaterialStateProperty.resolveWith((states) =>
                states.contains(MaterialState.hovered) ? color : Colors.white),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(color: color, width: 1.3),
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text('Or click here to logout.'),
          ),
        ),
        Spacer(),
      ],
    );
  }

  Future<void> _logout(BuildContext context) async {
    await context.read(loginProvider).logout();
    await context.router.push(MainRoute());
  }
}
