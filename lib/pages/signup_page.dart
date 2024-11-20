// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:habit_mvp/api/authentication_service.dart';
import 'package:habit_mvp/default_data.dart';
import 'package:habit_mvp/default_widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController repeatPasswordController = TextEditingController();

    void submitSignup() async {
      await AuthService.createAccountWithEmail(usernameController.text, emailController.text, passwordController.text).then((value) {
        if (value == AuthFeedback.signupSuccessful) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AppLocalizations.of(context)!.signupSuccessful))
          );
          Navigator.pushReplacementNamed(context, homeRoute);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                value.toString(),
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
                text: AppLocalizations.of(context)!.signupWelcome,
                textType: TextType.headline
              ),
              const SmallSpacer(),
              CustomText(
                text: AppLocalizations.of(context)!.signupSubtitle,
                textType: TextType.title
              ),
              const LargeSpacer(),
              TextFormField( // TODO add input validation
                controller: usernameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text(AppLocalizations.of(context)!.username),
                ),
              ),
              const SmallSpacer(),
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
              TextFormField( // TODO add input validation
                controller: repeatPasswordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text(AppLocalizations.of(context)!.repeatPassword),
                ),
              ),
              const SmallSpacer(),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: () => submitSignup(),
                  child: Text(AppLocalizations.of(context)!.signupSubmitButton),
                ),
              ),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(AppLocalizations.of(context)!.alreadyRegistered),
                      GestureDetector(
                        onTap: () => Navigator.pushReplacementNamed(context, loginRoute),
                        child: Text(
                          AppLocalizations.of(context)!.loginAppeal,
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