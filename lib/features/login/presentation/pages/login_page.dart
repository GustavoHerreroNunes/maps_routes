import 'package:flutter/material.dart';
import 'package:maps_route_app/constants/routes_const.dart';
import 'package:maps_route_app/features/widgets/default_text_field_widget.dart';
import 'dart:html';

import 'package:maps_route_app/main.dart';

class LoginPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _txbEmailController = TextEditingController();
  final _txbPassController = TextEditingController();

  @override void initState() {
    super.initState();

    _txbEmailController.addListener(() {
      window.console.info("[_txbEmail]: ${_txbEmailController.text}");
    });

    _txbPassController.addListener(() {
      window.console.info("[_txbPass]: ${_txbPassController.text}");
    });
  }

  @override
  void dispose() {
    _txbEmailController.dispose();
    _txbPassController.dispose();

    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Bem-vinde!",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
              textDirection: TextDirection.ltr,
            ),
            Row(
              children: [
                const Text("Entre ou"),
                TextButton(
                  child: const Text("cadastre-se"),
                  onPressed: () {
                    MapsRouteApp.navigatorKey.currentState
                      ?.pushNamed(RoutesConst.signup);
                  }
                )
              ],
            ),
            _txbEmail(_txbEmailController),
            _txbPass(_txbPassController)
          ],
        )
      )
    );
  }

  Widget _txbEmail(dynamic controller){
    const String label = "Email";
    const InputType inputType = InputType.text;

    return DefaultTextField(label, inputType, controller);
  }

  Widget _txbPass(dynamic controller){
    const String label = "Senha";
    const InputType inputType = InputType.password;

    return DefaultTextField(label, inputType, controller);
  }
}
