import 'package:flutter/material.dart';

import 'package:habit_mvp/main.dart';
import 'package:habit_mvp/model.dart';
import 'package:habit_mvp/default_data.dart';
import 'package:habit_mvp/default_widgets.dart';

class HabitEdit extends StatefulWidget {
  const HabitEdit({
    super.key,
    required this.habit
  });

  final Habit habit;

  @override
  State<HabitEdit> createState() => _HabitEditState();
}

class _HabitEditState extends State<HabitEdit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Theme.of(context).colorScheme.surface,
        child: Padding(
          padding: EdgeInsets.fromLTRB(defaultPagePadding[0], defaultPagePadding[1], defaultPagePadding[2], defaultPagePadding[3]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "Einstellungen",
                textType: TextType.headline,
              ),
              LargeSpacer(),
              CustomText(
                text: habitEditNameTitleT,
                textType: TextType.title,
              ),
              HabitEditNameTextField(habit: widget.habit),
              LargeSpacer(),
              CustomText(
                text: yourGoalTitleT,
                textType: TextType.title,
              ),
              HabitEditDescriptionTextField(habit: widget.habit)
            ],
          )
        )
      )
    );
  }
}

class HabitEditNameTextField extends StatefulWidget {
  const HabitEditNameTextField({
    super.key,
    required this.habit,
  });

  final Habit habit;

  @override
  State<HabitEditNameTextField> createState() => _HabitEditNameTextFieldState();
}

class _HabitEditNameTextFieldState extends State<HabitEditNameTextField> {
  final FocusNode _focusNode = FocusNode();
  late TextEditingController _controller;
  Color _borderCursorColor = primary;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.habit.name);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool _validateInput(String inputText) {
    if (inputText.trim().isEmpty) {
      return false;
    }
    return true;
  }

  void _submitForm() {
    String newName = _controller.text;

    if(_validateInput(newName)){
      widget.habit.editName(newName);
      db.habitBox.put(widget.habit);
    } else {
      setState(() {
        _borderCursorColor = error;
        _focusNode.requestFocus();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      focusNode: _focusNode,
      onChanged: (value) {
        setState(() {
          _borderCursorColor = primary;
        });
      },
      onSubmitted: (value) {
        _submitForm();
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
    );
  }
}

class HabitEditDescriptionTextField extends StatefulWidget {
  const HabitEditDescriptionTextField({
    super.key,
    required this.habit,
  });

  final Habit habit;

  @override
  State<HabitEditDescriptionTextField> createState() => _HabitEditDescriptionTextFieldState();
}

class _HabitEditDescriptionTextFieldState extends State<HabitEditDescriptionTextField> {
  final FocusNode _focusNode = FocusNode();
  late TextEditingController _controller;
  Color _borderCursorColor = primary;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.habit.description);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool _validateInput(String inputText) {
    if (inputText.trim().isEmpty) {
      return false;
    }
    return true;
  }

  void _submitForm() {
    String newDescription = _controller.text;

    if(_validateInput(newDescription)){
      widget.habit.editDescription(newDescription);
      db.habitBox.put(widget.habit);
    } else {
      setState(() {
        _borderCursorColor = error;
        _focusNode.requestFocus();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      focusNode: _focusNode,
      onChanged: (value) {
        setState(() {
          _borderCursorColor = primary;
        });
      },
      onSubmitted: (value) {
        _submitForm();
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
    );
  }
}