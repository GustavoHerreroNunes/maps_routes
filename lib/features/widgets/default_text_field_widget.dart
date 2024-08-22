import 'package:flutter/material.dart';

enum InputType{
  text,
  number,
  password
}

class DefaultTextField extends StatefulWidget{
  String label;
  InputType inputType;
  dynamic controller;

  DefaultTextField(
    this.label,
    this.inputType,
    this.controller,
    {super.key}
  );

  @override
  State<StatefulWidget> createState() => _DefaultTextFieldState();
}

class _DefaultTextFieldState extends State<DefaultTextField>{
  bool _isPasswordVisible = false;

  @override
  void initState() {
    _isPasswordVisible = false;

    super.initState();
  }
  
  @override
  Widget build(BuildContext context) => (
    Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        keyboardType: widget.inputType == InputType.number
          ? TextInputType.number
          : TextInputType.text,
        controller: widget.controller,
        obscureText: widget.inputType == InputType.password 
          ? !_isPasswordVisible 
          : false,
        decoration: InputDecoration(
          labelText: widget.label,
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color:Colors.black54,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          suffixIcon: _textFieldIcon()
        ),
      )
    )
  );

  Widget _textFieldIcon() => (
    widget.inputType == InputType.text
        ? const Icon(Icons.edit_rounded)
        : widget.inputType == InputType.number
        ? const Icon(Icons.numbers_rounded)
        : IconButton(
            icon: Icon(
              _isPasswordVisible
                ? Icons.visibility_rounded
                : Icons.visibility_off_rounded
            ),
            onPressed: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
          )
  );
}
