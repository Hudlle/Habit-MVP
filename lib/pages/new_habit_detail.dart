import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../main.dart';
import '../default_data.dart';
import '../default_widgets.dart';

class NewHabitDetail extends StatelessWidget {
  const NewHabitDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Theme.of(context).colorScheme.surface,
        child: Padding(
          padding: EdgeInsets.fromLTRB(defaultPagePadding[0], defaultPagePadding[1], defaultPagePadding[2], defaultPagePadding[3]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: AppLocalizations.of(context)!.newHabitDetailWelcome,
                textType: TextType.headline,
              ),
              const LargeSpacer(),
              GestureDetector(
                onTap:() {
                  Navigator.pushNamed(context, howToGoalRoute);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.info,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: smallSpacing),
                    CustomText(
                      text: AppLocalizations.of(context)!.howToGoal,
                      textType: TextType.body,
                      specialColor: Theme.of(context).colorScheme.primary,
                    ),
                  ],
                ),
              ),
              const LargeSpacer(),
              NewHabitDetailTextField(
                emptyErrorT: AppLocalizations.of(context)!.newHabitDetailEmptyError,
                hintT: AppLocalizations.of(context)!.newHabitDetailHint,
                borderCursorColor: Theme.of(context).colorScheme.primary,
              ),
            ],
          )
        )
      )
    );
  }
}

class NewHabitDetailTextField extends StatefulWidget {
  const NewHabitDetailTextField({
    super.key,
    required this.emptyErrorT,
    this.hintT,
    required this.borderCursorColor,
  });

  final String emptyErrorT;
  final String? hintT;
  final Color borderCursorColor;

  @override
  State<NewHabitDetailTextField> createState() => _NewHabitDetailTextFieldState();
}

class _NewHabitDetailTextFieldState extends State<NewHabitDetailTextField> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode _focusNode = FocusNode();
  late TextEditingController _controller;
  late Color _borderCursorColor;
  Color? _habitIntervalColor = hint;

  @override
  void initState() {
    _controller = TextEditingController();
    _borderCursorColor = widget.borderCursorColor;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submitForm(String newHabitName) {
    if(_formKey.currentState!.validate()){
      String newhabitDescription = "${_controller.text} pro Tag";
      db.addHabit(newHabitName, newhabitDescription);
      Navigator.pushNamedAndRemoveUntil(
        context, 
        homeRoute,
        (Route<dynamic> route) => false,
      );
    } else {
      setState(() {
        _borderCursorColor = Theme.of(context).colorScheme.error;
        _focusNode.requestFocus();
      });
    }
  }

  void _onChanged() {
    setState(() {
      _borderCursorColor = Theme.of(context).colorScheme.primary;
      if (_controller.text.trim().isEmpty) {
        _habitIntervalColor = hint;
      } else {
        _habitIntervalColor = Theme.of(context).colorScheme.primary;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final newHabitName = ModalRoute.of(context)!.settings.arguments as String;
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
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
              _onChanged();
            },
            onFieldSubmitted: (value) {
              _submitForm(newHabitName);
            },
            minLines: 1,
            maxLines: null,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            style: TextStyle(
              color: _borderCursorColor,
              fontSize: 16,
            ),
            cursorColor: _borderCursorColor,
            cursorErrorColor: _borderCursorColor,
            decoration: InputDecoration(
              hintText: widget.hintT,
              hintStyle: TextStyle(color: _habitIntervalColor),
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
          const SmallSpacer(),
          Text(
            AppLocalizations.of(context)!.checkInterval,
            semanticsLabel: AppLocalizations.of(context)!.checkInterval,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: _habitIntervalColor,
            )
          )
        ],
      ),
    );
  }
}