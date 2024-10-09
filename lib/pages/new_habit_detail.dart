import 'package:flutter/material.dart';

import '../main.dart';
import '../default_data.dart';
import '../default_widgets.dart';

class NewHabitDetail extends StatelessWidget {
  const NewHabitDetail({super.key});

  @override
  Widget build(BuildContext context) {

    var newHabitDetailDisplay = Text(
      newHabitDetailDisplayT,
      semanticsLabel: newHabitDetailDisplayT,
      style: Theme.of(context).textTheme.displayMedium,
    );

    var newHabitDetailHowToGoalBody = Text(
      howToGoalT,
      semanticsLabel: howToGoalT,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
        color: primary,
      ),
    );

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
              newHabitDetailDisplay,
              const LargeSpacer(),
              GestureDetector(
                onTap:() {
                  Navigator.pushNamed(context, howToGoalRoute);
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.info,
                      color: primary,
                    ),
                    const SizedBox(width: smallSpacing),
                    newHabitDetailHowToGoalBody,
                  ],
                ),
              ),
              const LargeSpacer(),
              const NewHabitDetailTextField(
                emptyErrorT: newHabitDetailEmptyErrorT,
                hintT: newHabitDetailHintT,
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
  });

  final String emptyErrorT;
  final String? hintT;

  @override
  State<NewHabitDetailTextField> createState() => _NewHabitDetailTextFieldState();
}

class _NewHabitDetailTextFieldState extends State<NewHabitDetailTextField> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode _focusNode = FocusNode();
  late TextEditingController _controller;
  Color _borderCursorColor = primary;
  Color? _habitIntervalColor = hint;

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

  void _submitForm(String newHabitName) {
    if(_formKey.currentState!.validate()){
      String newhabitDescription = "${_controller.text} pro Tag";
      db.addHabit(newHabitName, newhabitDescription);
      Navigator.pushNamed(
        context, 
        homeRoute
      );
    } else {
      setState(() {
        _borderCursorColor = error;
        _focusNode.requestFocus();
      });
    }
  }

  void _onChanged() {
    setState(() {
      _borderCursorColor = primary;
      if (_controller.text.trim().isEmpty) {
        _habitIntervalColor = hint;
      } else {
        _habitIntervalColor = primary;
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
              fontSize: 36,
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
          const LargeSpacer(),
          Text(
            checkIntervalT,
            semanticsLabel: checkIntervalT,
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
              color: _habitIntervalColor,
            )
          )
        ],
      ),
    );
  }
}