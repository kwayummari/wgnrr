// ignore_for_file: unused_field

import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class Maps {
  Future<Position> getLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error(
            Exception('Location permissions are permanently denied.'));
      }

      if (permission == LocationPermission.denied) {
        return Future.error(Exception('Location permissions are denied.'));
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-6.82349, 39.26951),
    zoom: 14.4746,
  );

  
}