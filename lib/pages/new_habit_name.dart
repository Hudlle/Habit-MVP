import 'package:flutter/material.dart';

import '../default_data.dart';
import '../default_widgets.dart';

class NewHabitName extends StatelessWidget {
  const NewHabitName({super.key});

  @override
  Widget build(BuildContext context) {
    var newHabitNameDisplay = Text(
      newHabitNameDisplayT,
      semanticsLabel: newHabitNameDisplayT,
      style: Theme.of(context).textTheme.displayMedium
    );

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Theme.of(context).colorScheme.surface,
        child: Padding(
          padding: EdgeInsets.fromLTRB(defaultPagePadding[0], defaultPagePadding[1], defaultPagePadding[2], defaultPagePadding[3]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              newHabitNameDisplay,
              const LargeSpacer(),
              const NewHabitNameTextField(
                emptyErrorT: newHabitNameEmptyErrorT,
                hintT: newHabitNameHintT,
                route: newHabitDetailRoute,
              ),
            ],
          )
        )
      )
    );
  }
}

class NewHabitNameTextField extends StatefulWidget {
  const NewHabitNameTextField({
    super.key,
    required this.emptyErrorT,
    this.hintT,
    required this.route,
  });

  final String emptyErrorT;
  final String? hintT;
  final String route;

  @override
  State<NewHabitNameTextField> createState() => _NewHabitNameTextFieldState();
}

class _NewHabitNameTextFieldState extends State<NewHabitNameTextField> {
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
        arguments: _controller.text,
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