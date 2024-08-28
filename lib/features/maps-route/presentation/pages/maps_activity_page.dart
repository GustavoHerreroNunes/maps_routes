/*import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_webservice/places.dart' as places;
import 'package:google_maps_webservice/directions.dart' as directions;

class MapsActivity extends StatefulWidget {
  @override
  _MapsActivityState createState() => _MapsActivityState();
}

class _MapsActivityState extends State<MapsActivity> {
  gmaps.GoogleMapController? _mapController;
  Position? _currentPosition;
  late TextEditingController _currentLocationController;
  late TextEditingController _destinationController;
  gmaps.Polyline? _currentPolyline;
  List<gmaps.LatLng>? _routePoints;

  final places.GoogleMapsPlaces placesApi = places.GoogleMapsPlaces(apiKey: 'YOUR_API_KEY');
  final directions.GoogleMapsDirections directionsApi = directions.GoogleMapsDirections(apiKey: 'YOUR_API_KEY');

  @override
  void initState() {
    super.initState();
    _currentLocationController = TextEditingController();
    _destinationController = TextEditingController();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = position;
    });
  }

  Future<void> _getDirections(gmaps.LatLng origin, gmaps.LatLng destination) async {
    final response = await directionsApi.directionsWithLocation(
      directions.Location(lat: origin.latitude, lng: origin.longitude),
      directions.Location(lat: destination.latitude, lng: destination.longitude),
      travelMode: directions.TravelMode.driving,
    );

    if (response.isOkay) {
      final route = response.routes[0];
      final List<gmaps.LatLng> points = _decodePolyline(route.overviewPolyline.points);
      setState(() {
        _routePoints = points;
        _currentPolyline = gmaps.Polyline(
          polylineId: gmaps.PolylineId('route'),
          points: points,
          color: Colors.blue,
          width: 5,
        );
      });
    } else {
      throw Exception('Failed to load directions');
    }
  }

  List<gmaps.LatLng> _decodePolyline(String encoded) {
    List<gmaps.LatLng> poly = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lng += dlng;

      poly.add(gmaps.LatLng(lat / 1E5, lng / 1E5));
    }

    return poly;
  }

  Future<void> _getPlacePredictions(String input) async {
    final response = await placesApi.autocomplete(input);
    if (response.isOkay) {
      if (response.predictions.isNotEmpty) {
        final placeId = response.predictions[0].placeId;
        _getPlaceDetails(placeId.toString());
      }
    } else {
      throw Exception('Failed to load place predictions');
    }
  }

  Future<void> _getPlaceDetails(String placeId) async {
    final response = await placesApi.getDetailsByPlaceId(placeId);
    if (response.isOkay) {
      final location = response.result.geometry!.location;
      final destination = gmaps.LatLng(location.lat, location.lng);
      gmaps.LatLng origin = gmaps.LatLng(_currentPosition?.latitude ?? 0, _currentPosition?.longitude ?? 0);
      _getDirections(origin, destination);
    } else {
      throw Exception('Failed to load place details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maps Activity'),
      ),
      body: Stack(
        children: [
          gmaps.GoogleMap(
            onMapCreated: (controller) {
              _mapController = controller;
              if (_currentPosition != null) {
                _mapController?.moveCamera(gmaps.CameraUpdate.newLatLng(
                  gmaps.LatLng(_currentPosition?.latitude ?? 0, _currentPosition?.longitude ?? 0),
                ));
              }
            },
            initialCameraPosition: gmaps.CameraPosition(
              target: gmaps.LatLng(0, 0),
              zoom: 10,
            ),
            polylines: _currentPolyline != null ? Set<gmaps.Polyline>.of([_currentPolyline!]) : Set<gmaps.Polyline>(),
          ),
          Positioned(
            top: 10,
            left: 10,
            right: 10,
            child: Column(
              children: [
                TextField(
                  controller: _currentLocationController,
                  decoration: InputDecoration(
                    hintText: 'Current Location',
                  ),
                ),
                TextField(
                  controller: _destinationController,
                  decoration: InputDecoration(
                    hintText: 'Destination',
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _getPlacePredictions(_destinationController.text);
                  },
                  child: Text('Get Route'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}*/