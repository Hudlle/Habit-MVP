import 'package:flutter/material.dart';
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
          side: BorderSide(color: Theme.of(context).colorScheme.outline),
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
        side: BorderSide(color: Theme.of(context).colorScheme.outline),
        borderRadius: BorderRadius.circular(cardBorderRadius),
      ),
      child: ListTile(
        leading: widget.icon,
        title: Text(widget.title),
        trailing: Switch(
          value: _isToggled,
          onChanged: _handleToggle,
          activeColor: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}

class LocalHabit {
  String hid;
  String name;
  String description;
  int streak;
  bool checked;
  List notifications;

  LocalHabit({
    required this.hid,
    required this.name,
    required this.description,
    required this.streak,
    required this.checked,
    required this.notifications
  });
}