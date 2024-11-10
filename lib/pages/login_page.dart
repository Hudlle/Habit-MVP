// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:habit_mvp/api/authentication_service.dart';
import 'package:habit_mvp/default_data.dart';
import 'package:habit_mvp/default_widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    void submitLogin() async {
      await AuthService.loginWithEmail(emailController.text, passwordController.text).then((value) {
        if (value == "login successful") {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AppLocalizations.of(context)!.loginSuccessful))
          );
          Navigator.pushReplacementNamed(context, homeRoute);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                value,
                style: TextStyle(color: Theme.of(context).colorScheme.onErrorContainer)
              ),
              backgroundColor: Theme.of(context).colorScheme.errorContainer,
            )
          );
        }
      },);
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Container(
        color: Theme.of(context).colorScheme.surface,
        child: Padding(
          padding: EdgeInsets.fromLTRB(defaultPagePadding[0], defaultPagePadding[1], defaultPagePadding[2], defaultPagePadding[3]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: AppLocalizations.of(context)!.loginWelcome,
                textType: TextType.headline
              ),
              const SmallSpacer(),
              CustomText(
                text: AppLocalizations.of(context)!.loginSubtitle,
                textType: TextType.title
              ),
              const LargeSpacer(),
              TextFormField( // TODO add input validation
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text(AppLocalizations.of(context)!.email),
                ),
              ),
              const SmallSpacer(),
              TextFormField( // TODO add input validation
                controller: passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text(AppLocalizations.of(context)!.password),
                ),
              ),
              const SmallSpacer(),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: () => submitLogin(),
                  child: Text(AppLocalizations.of(context)!.loginSubmitButton),
                ),
              ),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(AppLocalizations.of(context)!.notRegistered),
                      GestureDetector(
                        onTap: () => Navigator.pushReplacementNamed(context, signupRoute),
                        child: Text(
                          AppLocalizations.of(context)!.signupAppeal,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          )
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        ),
      ),
    );
  }
}