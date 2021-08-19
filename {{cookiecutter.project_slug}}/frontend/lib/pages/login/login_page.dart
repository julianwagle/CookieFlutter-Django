import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:frontend/errors/api_validation_error.dart';
import 'package:frontend/providers/login_provider.dart';
import 'package:frontend/responsive.dart';
import 'package:frontend/router/router.gr.dart';
import 'package:frontend/widgets/custom_base.dart';
import 'package:frontend/widgets/custom_form.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends StatefulWidget {
  LoginPage();

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  List<String> errors = [];
  String email = '';
  String password = '';

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
                  'Sign in',
                  style: TextStyle(
                    color: Color(0xFF373A3C),
                    fontSize: 38,
                  ),
                ),
                TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.resolveWith(
                      (states) => states.contains(MaterialState.hovered)
                          ? Colors.green.shade800
                          : Theme.of(context).primaryColor,
                    ),
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    textStyle: MaterialStateProperty.resolveWith(
                      (states) => states.contains(MaterialState.hovered)
                          ? TextStyle(decoration: TextDecoration.underline)
                          : TextStyle(),
                    ),
                  ),
                  onPressed: () {
                    context.router.push(RegisterRoute());
                  },
                  child: Text(
                    'Need an account?',
                  ),
                ),
                SizedBox(height: 10),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final width = Responsive.isMobile(context)
                        ? constraints.maxWidth
                        : constraints.maxWidth * 0.4;
                    return Container(
                      width: width,
                      child: CustomForm(
                        errors: errors,
                        submitText: 'Sign in',
                        onSubmit: () {
                          _login();
                        },
                        children: [
                          CustomTextField(
                            hintText: 'Email',
                            autofillHints: [AutofillHints.email],
                            onChanged: (val) {
                              email = val;
                            },
                          ),
                          CustomTextField(
                            hintText: 'Password',
                            autofillHints: [AutofillHints.password],
                            onChanged: (val) {
                              password = val;
                            },
                          ),
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

  Future<void> _login() async {
    try {
      await context.read(loginProvider).login(
            context,
            email: email,
            password: password,
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
