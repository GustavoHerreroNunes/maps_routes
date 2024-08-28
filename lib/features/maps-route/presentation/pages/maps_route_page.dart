import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:maps_route_app/features/maps-route/utilities/coordinates_utilities.dart';
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
  GoogleMapController? _mapsController;
  
  List<LatLng> routePoints = [];

  final Completer<GoogleMapController> _completer = Completer();

  CameraPosition _cameraPosition = CameraPosition(
    target: LatLng( -15.7801, -47.9292),
    zoom: 4
  );

  Set<Marker> _routeMarkers = Set();

  final Set<Polyline>_polyline= {};
  List<LatLng> latlng = [];

  @override
  void initState() {
    getPolyPoints();
    super.initState();
  }

  @override
  void dispose() {
    _txbDestination.dispose();
    _txbOrigin.dispose();

    super.dispose();
  }


  void getPolyPoints() async {
    var sourceLocation = await getFromAddress(_txbOrigin.text.toString());
    var destinationLoc = await getFromAddress(_txbDestination.text.toString());
    var googleApiK = "AIzaSyCaGSPOPMcoqaomH24MkKiWXl--jy3S6Ow";
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiK,
        PointLatLng(sourceLocation?.latitude ?? 0, sourceLocation?.longitude ?? 0),
        PointLatLng(destinationLoc?.latitude ?? 0, destinationLoc?.longitude ?? 0),
    );

    if (result.points.isNotEmpty){
      result.points.forEach((PointLatLng point) => routePoints.add(LatLng(point.latitude, point.longitude)));
    }

    setState(() {
      _polyline.add(Polyline(
        polylineId: PolylineId("route"),
        visible: true,
        points: routePoints,
        color: Colors.blue,
      ));
    });

    setState(() {
      _routeMarkers = {Marker(
        markerId: MarkerId("source"),
        position: sourceLocation!,
      ),
        Marker(markerId: MarkerId("destination"),
          position: destinationLoc!,
        ),
      };
    });
    _mapsController?.animateCamera(
        CameraUpdate.newLatLngZoom(LatLng(sourceLocation?.latitude ?? 0, sourceLocation?.longitude ?? 0), 14));

    /*setState(() {
      _cameraPosition = CameraPosition(
          target: .,
          zoom: 12
      );
    });*/
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
        polylines: _polyline,
        initialCameraPosition: _cameraPosition,
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {
          _mapsController = controller;
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

    void onPressed() async {
       getPolyPoints();


    }

    return DefaultButton(label, ButtonStyleType.primary, onPressed);
  }
}
