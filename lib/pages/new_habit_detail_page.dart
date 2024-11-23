import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:habit_mvp/api/firestore_service.dart';
import 'package:habit_mvp/default_data.dart';
import 'package:habit_mvp/default_widgets.dart';

class NewHabitDetailPage extends StatelessWidget {
  const NewHabitDetailPage({super.key});

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
                context: context
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
    required this.context,
  });

  final BuildContext context;

  @override
  State<NewHabitDetailTextField> createState() => _NewHabitDetailTextFieldState();
}

class _NewHabitDetailTextFieldState extends State<NewHabitDetailTextField> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode _focusNode = FocusNode();
  late TextEditingController _controller;
  late Color _borderCursorColor;
  late Color _habitIntervalColor;

  @override
  void initState() {
    _controller = TextEditingController();
    _borderCursorColor = Theme.of(widget.context).colorScheme.primary;
    _habitIntervalColor = Theme.of(widget.context).hintColor;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onChanged() {
    setState(() {
      _borderCursorColor = Theme.of(context).colorScheme.primary;

      if (_controller.text.trim().isEmpty) {
        _habitIntervalColor = Theme.of(context).hintColor;
      } else {
        _habitIntervalColor = Theme.of(context).colorScheme.primary;
      }
    });
  }

  void _submitForm(String newHabitName) {
    if(_formKey.currentState!.validate()){
      String newhabitDescription = "${_controller.text} pro Tag";
      FirestoreService.saveNewHabit(newHabitName, newhabitDescription);
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
                return AppLocalizations.of(context)!.newHabitDetailEmptyError;
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
              fontSize: textFieldFontSize,
            ),
            cursorColor: _borderCursorColor,
            cursorErrorColor: _borderCursorColor,
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.newHabitDetailHint,
              hintStyle: TextStyle(color: Theme.of(context).hintColor),
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
          CustomText(
            text: AppLocalizations.of(context)!.checkInterval,
            textType: TextType.title,
            specialColor: _habitIntervalColor,
          ),
        ],
      ),
    );
  }
}