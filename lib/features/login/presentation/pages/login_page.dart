import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:maps_route_app/constants/routes_const.dart';
import 'package:maps_route_app/features/widgets/default_button.dart';
import 'package:maps_route_app/features/widgets/default_text_field_widget.dart';

import 'package:maps_route_app/main.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _frmLoginKey = GlobalKey<FormState>();
  final _txbEmailController = TextEditingController();
  final _txbPassController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;  // Instância do FirebaseAuth
  final DatabaseReference _database = FirebaseDatabase.instance.ref();  // Referência do Firebase Realtime Database

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
          fontSize: 35,
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
      _btnSubmit(),
      _btnCancel()
    ];
    
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _frmLoginKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _loginElements,
          )
        )
      )
    );
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
      if (_frmLoginKey.currentState!.validate()) {
        try {
          // Autentica o usuário com Firebase Authentication
          UserCredential userCredential = await _auth.signInWithEmailAndPassword(
            email: _txbEmailController.text,
            password: _txbPassController.text,
          );

          User? user = userCredential.user;

          if (user != null) {
            // Recupera informações do usuário do Firebase Realtime Database
            DatabaseReference userRef = _database.child('users/${user.uid}');
            DatabaseEvent event = await userRef.once();

            if (event.snapshot.exists) {
              // Se os dados existirem, exiba-os ou prossiga para a próxima tela
              Map userData = event.snapshot.value as Map;

              print("Bem-vindo, ${userData['username']}! Seu email é ${userData['email']}.");

              // Redirecionar para a tela de mapas
              MapsRouteApp.navigatorKey.currentState
                ?.pushReplacementNamed(RoutesConst.mapsActivity);
            } else {
              // Se os dados não existirem, exiba uma mensagem de erro
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Erro: Dados do usuário não encontrados.")),
              );
            }
          }
        } on FirebaseAuthException catch (e) {
          // Mostre uma mensagem de erro se houver problema na autenticação
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.message ?? "Erro ao fazer login")),
          );
        }
      }
    }

    return DefaultButton("Entrar", ButtonStyleType.primary, onPressed);
  }

  Widget _btnCancel() {
    void onPressed() {
      // Ação ao clicar no botão Cancelar
      MapsRouteApp.navigatorKey.currentState
        ?.pushReplacementNamed(RoutesConst.mapRoutes);
    }
    
    return DefaultButton("Cancelar", ButtonStyleType.secondary, onPressed);
  }
}