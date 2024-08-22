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
  final _frmLoginKey = GlobalKey<FormState>();
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
    List<Widget> _loginElements = [
      const Text(
        "Bem-vindo!",
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
      _txbPass(_txbPassController), 
      const Spacer(),
      _btnSubmit(context),
      _btnCancel(context)
    ];
    
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _frmLoginKey,
          child: Column(
            children: _loginElements
          )
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

  Widget _btnSubmit(BuildContext context) {
    final theme = Theme.of(context);
    
    return TextButton(
      onPressed: () {
        window.console.info("[btnSubmit] clicked");
      },
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        minimumSize: const Size(double.infinity, 40)
      ),

      child: const Text("Salvar") 
    );
  }

  Widget _btnCancel(BuildContext context) {
    final theme = Theme.of(context);
    
    return OutlinedButton(
      onPressed: () {
        window.console.info("[btnCancel] clicked");
      },
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.blue,
        backgroundColor: Colors.transparent,
        side: const BorderSide(
          color: Colors.blue,
          width: 1.2
        ),
        minimumSize: const Size(double.infinity, 40)
      ),

      child: const Text("Cancelar") 
    );
  }
}
