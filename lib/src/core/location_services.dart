import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationServices {
  static Future<LatLng> getCurrentLatLong() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return await Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (kDebugMode) {
      print(permission);
    }
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return await Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return await Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position value = await Geolocator.getCurrentPosition();

    return LatLng(value.latitude, value.longitude);
  }

  static Future<String> getAddressFromLatLang(LatLng latLng) async {
    List<Placemark> placeMark =
        await placemarkFromCoordinates(latLng.latitude, latLng.longitude);

    setLocaleIdentifier('en');

    if (kDebugMode) {
      print(placeMark);
    }
    Placemark place = placeMark[0];

    print(place);

    return '${place.name}, ${place.locality}, ${place.administrativeArea}, ${place.isoCountryCode}';
  }

  static Future<String> getAddressFromCurrentLatLong() async {
    final latLng = await getCurrentLatLong();

    setLocaleIdentifier('en');

    List<Placemark> placeMark =
        await placemarkFromCoordinates(latLng.latitude, latLng.longitude);

    Placemark place = placeMark[0];

    print(place);

    return '${place.name}, ${place.locality}, ${place.administrativeArea}, ${place.isoCountryCode}';
  }
}

/*
Name: Kafr Ghanam,
    Street: ,
ISO Country Code: EG,
Country: Egypt,
Postal code: ,
Administrative area: Dakahlia,
Subadministrative area: El Senbellawein,
    Locality: El Senbellawein,
    Sublocality: Kafr Ghanam,
    Thoroughfare: ,
Subthoroughfare:*/
