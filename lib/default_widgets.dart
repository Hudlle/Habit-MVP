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
        Navigator.pushNamed(context, route);
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
                Navigator.pushReplacementNamed(context, homeRoute);
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
                Navigator.pushReplacementNamed(context, homeRoute);
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

// Big TextField (TextFormField) used for creating a new habit
class BigTextField extends StatefulWidget {
  const BigTextField({
    super.key,
    required this.emptyErrorT,
    this.hintT,
    required this.route,
  });

  final String emptyErrorT;
  final String? hintT;
  final String route;

  @override
  State<BigTextField> createState() => _BigTextfieldState();
}

class _BigTextfieldState extends State<BigTextField> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode _focusNode = FocusNode();
  late TextEditingController _controller;
  Color _borderCursorColor = primary;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submitForm() {
    if(_formKey.currentState!.validate()){
      Navigator.pushNamed(
        context, 
        widget.route, 
      );
    } else {
      setState(() {
        _borderCursorColor = error;
        _focusNode.requestFocus();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: TextFormField(
        controller: _controller,
        focusNode: _focusNode,
        autofocus: true,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return widget.emptyErrorT;
          }
          return null;
        },
        onChanged: (value) {
          setState(() {
            _borderCursorColor = primary;
          });
        },
        onFieldSubmitted: (value) {
          _submitForm();
        },
        minLines: 1,
        maxLines: null,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        style: TextStyle(
          color: _borderCursorColor,
          fontSize: 36,
        ),
        cursorColor: _borderCursorColor,
        cursorErrorColor: _borderCursorColor,
        decoration: InputDecoration(
          hintText: widget.hintT,
          // hintStyle: TextStyle(color: Colors.grey[700]),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: _borderCursorColor),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: _borderCursorColor)
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: _borderCursorColor)
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: _borderCursorColor)
          ),
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