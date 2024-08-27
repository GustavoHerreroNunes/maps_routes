import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:maps_route_app/constants/routes_const.dart';
import 'package:maps_route_app/features/widgets/default_button.dart';
import 'package:maps_route_app/features/widgets/default_text_field_widget.dart';

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
  final FirebaseAuth _auth = FirebaseAuth.instance;  // Instância do FirebaseAuth
  final DatabaseReference _database = FirebaseDatabase.instance.ref();  // Referência do Firebase Realtime Database

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
            children: _signupElements,
          ),
        ),
      ),
    );
  }

  Widget _txbUsername(dynamic controller) {
    const String label = "Username";
    const InputType inputType = InputType.text;

    return DefaultTextField(label, inputType, controller);
  }

  Widget _txbBirthday(dynamic controller) {
    const String label = "Data de Nascimento";
    const InputType inputType = InputType.text;

    return DefaultTextField(label, inputType, controller);
  }

  Widget _txbEmail(dynamic controller) {
    const String label = "Email";
    const InputType inputType = InputType.text;

    return DefaultTextField(label, inputType, controller);
  }

  Widget _txbPass(dynamic controller) {
    const String label = "Senha";
    const InputType inputType = InputType.password;

    return DefaultTextField(label, inputType, controller);
  }

  Widget _btnSubmit() {
    void onPressed() async {
      if (_frmSignUpKey.currentState!.validate()) {
        try {
          // Criar o usuário no Firebase Authentication
          UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
            email: _txbEmailController.text,
            password: _txbPassController.text,
          );

          User? user = userCredential.user;

          if (user != null) {
            // Armazenar informações adicionais no Firebase Realtime Database
            await _database.child('users/${user.uid}').set({
              'username': _txbUsernameController.text,
              'birthday': _txbBirthdayController.text,
              'email': _txbEmailController.text,
            });

            // Redirecionar para a próxima tela
            MapsRouteApp.navigatorKey.currentState
              ?.pushReplacementNamed(RoutesConst.mapsActivity);
          }
        } on FirebaseAuthException catch (e) {
          // Mostrar mensagem de erro se houver problema na criação do usuário
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.message ?? "Erro ao criar conta")),
          );
        }
      }
    }

    return DefaultButton("Entrar", ButtonStyleType.primary, onPressed);
  }
}