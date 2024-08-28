import 'package:geocoder2/geocoder2.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<LatLng?> getFromAddress(String address) async {
  GeoData data = await Geocoder2.getDataFromAddress(
        address: address,
        googleMapApiKey: "AIzaSyCaGSPOPMcoqaomH24MkKiWXl--jy3S6Ow");

  return LatLng(
    data.latitude,
    data.longitude
  );
}
