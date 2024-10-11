import 'package:flutter/material.dart';
import 'dart:developer';

import 'default_data.dart';

//* Outsourced Widgets
class SmallSpacer extends StatelessWidget {
  const SmallSpacer({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: smallSpacing);
  }
}

class LargeSpacer extends StatelessWidget {
  const LargeSpacer({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: largeSpacing);
  }
}
enum TextType{headline, title, body}

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.textType,
    required this.text,
    this.specialColor,
    this.softWrapToggle,
  });

  final TextType textType;
  final String text;
  final Color? specialColor;
  final bool? softWrapToggle;

  @override
  Widget build(BuildContext context) {
    final textStyle = switch (textType) {
      TextType.headline => Theme.of(context).textTheme.headlineMedium!.copyWith(color: specialColor),
      TextType.title => Theme.of(context).textTheme.titleMedium!.copyWith(color: specialColor),
      TextType.body => Theme.of(context).textTheme.bodyMedium!.copyWith(color: specialColor),
    };

    return Text(
      text, 
      semanticsLabel: text,
      softWrap: softWrapToggle,
      style: textStyle
    );
  }
}

// Routing text used on log in and sign up screen to navigate between each other
class SignUpToLogInRoutingText extends StatelessWidget {
  const SignUpToLogInRoutingText({
    super.key,
    required this.route,
    required this.label1,
    required this.label2,
  });

  final String route;
  final String label1;
  final String label2;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacementNamed(context, route);
      },
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyMedium,
          children: [
            TextSpan(
              text: "$label1\n",
            ),
            TextSpan(
              text: label2,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Elevated Button for submitting user input
class DataSubmitEB extends StatelessWidget {
  const DataSubmitEB({
    super.key,
    required this.origin,
    required this.route,
    required this.label,
  });

  final String origin;
  final String route;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: submitButtonHeight,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context, 
                  route,
                  (Route<dynamic> route) => false,
                );
                log(label);
              },
              child: Text(label)
            ),
          ),
        ),
      ],
    );
  }
}

// Outlined Button for submitting user input
class DataSubmitOB extends StatelessWidget {
  const DataSubmitOB({
    super.key,
    required this.origin,
    required this.route,
    required this.label,
  });

  final String origin;
  final String route;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: submitButtonHeight,
            child: OutlinedButton(
              onPressed:() {
                Navigator.pushNamedAndRemoveUntil(
                  context, 
                  route,
                  (Route<dynamic> route) => false,
                );
                log(label);
              },
              child: Text(label),
            ),
          ),
        ),
      ],
    );
  }
}

// Powerful TextFields for getting input data from sign up, log in and settings
class ControlledTextField extends StatefulWidget {
  const ControlledTextField({
    super.key,
    required this.label,
    required this.initValue,
    required this.isPassword,
  });

  final String label;
  final String initValue;
  final bool isPassword;

  @override
  State<ControlledTextField> createState() => _ControlledTextFieldState();
}

class _ControlledTextFieldState extends State<ControlledTextField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.initValue,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: textFieldHeight,
      child: TextField(
        controller: _controller,
        obscureText: widget.isPassword,
        decoration: InputDecoration(
          border:  OutlineInputBorder(
            borderSide: const BorderSide(color: borderOutline),
            borderRadius: BorderRadius.circular(textFieldBorderRadius),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: focusedBorderOutline),
            borderRadius: BorderRadius.circular(textFieldBorderRadius),
          ),
          labelText: widget.label,
        ),
      ),
    );
  }
}

// A card used for routing in the settings section of the app
class SettingsCard extends StatelessWidget {
  const SettingsCard({
    super.key,
    required this.icon,
    required this.title,
    required this.route,
  });

  final Icon icon;
  final String title;
  final String route;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:() {
        Navigator.pushNamed(context, route);
      },
      child: Card.outlined(
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: borderOutline),
          borderRadius: BorderRadius.circular(cardBorderRadius),
        ),
        child: Column(
          children: [
            ListTile(
              leading: icon,
              title: Text(title),
              trailing: const Icon(Icons.navigate_next)
            ),
          ],
        )
      ),
    );
  }
}