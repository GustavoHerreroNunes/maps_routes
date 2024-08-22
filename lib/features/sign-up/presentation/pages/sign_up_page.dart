import 'package:flutter/material.dart';
import 'package:maps_route_app/constants/routes_const.dart';
import 'package:maps_route_app/features/widgets/default_button.dart';
import 'package:maps_route_app/features/widgets/default_text_field_widget.dart';
import 'dart:html';

import 'package:maps_route_app/main.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _frmSignUpKey = GlobalKey<FormState>();
  final _txbUsernameController = TextEditingController();
  final _txbBirthdayController = TextEditingController();
  final _txbEmailController = TextEditingController();
  final _txbPassController = TextEditingController();
  
  @override void initState() {
    super.initState();

    _txbUsernameController.addListener(() {
      window.console.info("[_txbUsername]: ${_txbUsernameController.text}");
    });

    _txbBirthdayController.addListener(() {
      window.console.info("[_txbBirthday]: ${_txbBirthdayController.text}");
    });

    _txbEmailController.addListener(() {
      window.console.info("[_txbEmail]: ${_txbEmailController.text}");
    });

    _txbPassController.addListener(() {
      window.console.info("[_txbPass]: ${_txbPassController.text}");
    });
  }

  @override
  void dispose() {
    _txbUsernameController.dispose();
    _txbBirthdayController.dispose();
    _txbEmailController.dispose();
    _txbPassController.dispose();

    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    List<Widget> _signupElements = [
      const Text(
        "Cadastre-se!",
        style: TextStyle(
          fontSize: 35,
          fontWeight: FontWeight.w600,
        ),
        textDirection: TextDirection.ltr,
      ),
      Row(
        children: [
          const Text("Digite seus dados abaixo ou"),
          TextButton(
            child: const Text("entre"),
            onPressed: () {
              MapsRouteApp.navigatorKey.currentState
                ?.pushNamed(RoutesConst.login);
            }
          )
        ],
      ),
      _txbUsername(_txbUsernameController),
      _txbBirthday(_txbBirthdayController),
      _txbEmail(_txbEmailController),
      _txbPass(_txbPassController), 
      const Spacer(),
      _btnSubmit(),
    ];
    
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _frmSignUpKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _signupElements
          )
        )
      )
  );
  }

  Widget _txbUsername(dynamic controller){
    const String label = "Username";
    const InputType inputType = InputType.text;

    return DefaultTextField(label, inputType, controller);
  }

  Widget _txbBirthday(dynamic controller){
    const String label = "Data de Nascimento";
    const InputType inputType = InputType.text;

    return DefaultTextField(label, inputType, controller);
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

  Widget _btnSubmit() {
    void onPressed () {
      window.console.info('[btnSubmit] pressed');
      window.console.info('Moving to \'/maps-route\'');
      MapsRouteApp.navigatorKey.currentState
        ?.pushReplacementNamed(RoutesConst.mapRoutes);
    }
    
    return DefaultButton("Entrar", ButtonStyleType.primary, onPressed);
  }
}
