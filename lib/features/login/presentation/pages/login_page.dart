import 'package:flutter/material.dart';
import 'package:maps_route_app/features/widgets/default_text_field_widget.dart';
import 'dart:html';

class LoginPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _myTxbController = TextEditingController();

  @override void initState() {
    super.initState();
    
    _myTxbController.addListener(() {
      window.console.info("[_myTxbController.text]");
      window.console.info(_myTxbController.text);
    });
  }

  @override
  void dispose() {
    _myTxbController.dispose();

    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Material(
      child: DefaultTextField(
        "My Text Field", 
        InputType.password, 
        _myTxbController
      ),
    );
  }
}
