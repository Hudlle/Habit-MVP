import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../default_data.dart';
import '../default_widgets.dart';

class NewHabitName extends StatelessWidget {
  const NewHabitName({super.key});

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
                text: AppLocalizations.of(context)!.newHabitNameWelcome,
                textType: TextType.headline,
              ),
              const LargeSpacer(),
              NewHabitNameTextField(
                emptyErrorT: AppLocalizations.of(context)!.newHabitNameEmptyError,
                hintT: AppLocalizations.of(context)!.newHabitNameHint,
                route: newHabitDetailRoute,
                borderCursorColor: Theme.of(context).colorScheme.primary,
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
    required this.borderCursorColor,
  });

  final String emptyErrorT;
  final String? hintT;
  final String route;
  final Color borderCursorColor;

  @override
  State<NewHabitNameTextField> createState() => _NewHabitNameTextFieldState();
}

class _NewHabitNameTextFieldState extends State<NewHabitNameTextField> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode _focusNode = FocusNode();
  late TextEditingController _controller;
  late Color _borderCursorColor;

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

  void _submitForm() {
    if(_formKey.currentState!.validate()){
      Navigator.pushNamed(
        context, 
        arguments: _controller.text,
        widget.route, 
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
            _borderCursorColor = Theme.of(context).colorScheme.primary;
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
          fontSize: 16,
        ),
        cursorColor: _borderCursorColor,
        cursorErrorColor: _borderCursorColor,
        decoration: InputDecoration(
          hintText: widget.hintT,
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