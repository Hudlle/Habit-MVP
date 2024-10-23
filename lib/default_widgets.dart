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
    this.centerAlignToggle,
  });

  final TextType textType;
  final String text;
  final Color? specialColor;
  final bool? softWrapToggle;
  final bool? centerAlignToggle;

  @override
  Widget build(BuildContext context) {
    final textStyle = switch (textType) {
      TextType.headline => Theme.of(context).textTheme.headlineMedium!.copyWith(color: specialColor),
      TextType.title => Theme.of(context).textTheme.titleMedium!.copyWith(color: specialColor),
      TextType.body => Theme.of(context).textTheme.bodyMedium!.copyWith(color: specialColor),
    };

    final TextAlign textAlign;
    if (centerAlignToggle == null) {
      textAlign = TextAlign.left;
    } else {
      textAlign = TextAlign.center;
    }

    return Text(
      text, 
      semanticsLabel: text,
      softWrap: softWrapToggle,
      style: textStyle,
      textAlign: textAlign,
    );
  }
}

// Elevated Button for submitting user input, possible usecase in settings section
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
        child: ListTile(
          leading: icon,
          title: Text(title),
          trailing: const Icon(Icons.navigate_next)
        )
      ),
    );
  }
}

class SettingsToggle extends StatefulWidget {
  const SettingsToggle({
    super.key,
    required this.icon,
    required this.title,
    required this.initialValue,
    required this.onToggle,
  });

  final Icon icon;
  final String title;
  final bool initialValue;
  final ValueChanged<bool> onToggle;

  @override
  State<SettingsToggle> createState() => _SettingsToggleState();
}

class _SettingsToggleState extends State<SettingsToggle> {
  late bool _isToggled;

  @override
  void initState() {
    super.initState();
    _isToggled = widget.initialValue;
  }

  void _handleToggle(bool value) {
    setState(() {
      _isToggled = value;
    });
    widget.onToggle(value);
  }

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: borderOutline),
        borderRadius: BorderRadius.circular(cardBorderRadius),
      ),
      child: ListTile(
        leading: widget.icon,
        title: Text(widget.title),
        trailing: Switch(
          value: _isToggled,
          onChanged: _handleToggle,
          activeColor: primary,
        ),
      ),
    );
  }
}
