import 'package:flutter/material.dart';
import 'package:maps_route_app/constants/routes_const.dart';
import 'package:maps_route_app/main.dart';

class SplashPage extends StatelessWidget {
  SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      MapsRouteApp.navigatorKey.currentState
        ?.pushReplacementNamed(RoutesConst.login);
    });

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Image.asset(
          'assets/images/logo.png', 
          width: 100, 
          height: 100
        )
      )
    );
  }
}
