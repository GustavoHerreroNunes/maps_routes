import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:maps_route_app/constants/routes_const.dart';
import 'package:maps_route_app/features/login/presentation/pages/login_page.dart';
import 'package:maps_route_app/features/maps-route/presentation/pages/maps_route_page.dart';
import 'package:maps_route_app/features/sign-up/presentation/pages/sign_up_page.dart';
import 'package:maps_route_app/features/splash/presentation/pages/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MapsRouteApp());
}

class MapsRouteApp extends StatelessWidget {
  const MapsRouteApp({super.key});

  static final GlobalKey<NavigatorState> navigatorKey = 
    GlobalKey<NavigatorState>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Maps Route App',
      navigatorKey: navigatorKey,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue)
      ),
      routes: {
        RoutesConst.splash : (context) => SplashPage(),
        RoutesConst.login : (context) => LoginPage(),
        RoutesConst.signup : (context) => SignUpPage(),
        RoutesConst.mapRoutes : (context) => MapsRoutePage(),
      },
    );
  }
}
