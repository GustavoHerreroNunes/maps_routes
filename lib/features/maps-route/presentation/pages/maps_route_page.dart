import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_route_app/features/widgets/default_button.dart';
import 'package:maps_route_app/features/widgets/default_text_field_widget.dart';

class MapsRoutePage extends StatefulWidget {
  const MapsRoutePage({super.key});

  @override
  State<MapsRoutePage> createState() => _MapsRoutePageState();
}

class _MapsRoutePageState extends State<MapsRoutePage> {
  final _frmRouteKey = GlobalKey<FormState>();
  final _txbDestination = TextEditingController();
  final _txbOrigin = TextEditingController();
  
  List<LatLng> routePoints = [];

  final Completer<GoogleMapController> _completer = Completer();

  CameraPosition _cameraPosition = CameraPosition(
    target: LatLng( -15.7801, -47.9292),
    zoom: 4
  );

  Set<Marker> _routeMarkers = Set();

  @override
  void dispose() {
    _txbDestination.dispose();
    _txbOrigin.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _getMap(),
          Form(
            key: _frmRouteKey,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _getTxbOrigin(),
                  _getDestination(),
                  _getBtnGo()
                ]
              )
            )
          )
        ]
      )
    );
  }

  Widget _getMap() {
    return Expanded(
      child: GoogleMap(
        initialCameraPosition: _cameraPosition,
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {
          _completer.complete(controller);
        },
        markers: _routeMarkers,
      )
    );
  }

  Widget _getTxbOrigin() {
    String label = "Origem";
    InputType inputType = InputType.text;

    return DefaultTextField(label, inputType, _txbOrigin);
  }

  Widget _getDestination() {
    String label = "Destino";
    InputType inputType = InputType.text;

    return DefaultTextField(label, inputType, _txbDestination);
  }

  Widget _getBtnGo() {
    String label = "Go";

    void onPressed() {
      print("[btnGo] pressed");
    }

    return DefaultButton(label, ButtonStyleType.primary, onPressed);
  }
}
