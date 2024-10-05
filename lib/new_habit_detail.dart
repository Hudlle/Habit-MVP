import 'package:flutter/material.dart';

import 'default_data.dart';
import 'default_widgets.dart';

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
              const BigTextFieldHabitInterval(
                emptyErrorT: newHabitDetailEmptyErrorT,
                hintT: newHabitDetailHintT,
                route: homeRoute,
              ),
            ],
          )
        )
      )
    );
  }
}

class BigTextFieldHabitInterval extends StatefulWidget {
  const BigTextFieldHabitInterval({
    super.key,
    required this.emptyErrorT,
    this.hintT,
    required this.route,
  });

  final String emptyErrorT;
  final String? hintT;
  final String route;

  @override
  State<BigTextFieldHabitInterval> createState() => _BigTextFieldHabitIntervalState();
}

class _BigTextFieldHabitIntervalState extends State<BigTextFieldHabitInterval> {
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