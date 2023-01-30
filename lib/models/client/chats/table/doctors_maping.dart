// ignore_for_file: unnecessary_null_comparison

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wgnrr/api/const.dart';
import 'package:http/http.dart' as http;
import 'package:wgnrr/api/map/maps.dart';

class MapSample extends StatefulWidget {
  const MapSample({Key? key}) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-6.82349, 39.26951),
    zoom: 14.4746,
  );

  

  List data = [];
  List<LatLng> locations = [];
  Set<Marker>? _markers = <Marker>{};
  Future getfacility() async {
    const url = '${murl}facility/facility.php';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      setState(() {
        data = jsonDecode(response.body);
      });
      if (data != null) {
        for (var i = 0; i < data.length; i++) {
          locations.add(LatLng(double.parse(data[i]['latitude']),
              double.parse(data[i]['longitude'])));
        }
        for (var j = 0; j < locations.length; j++) {
          setState(() async {
            _markers!.add(Marker(
                markerId: MarkerId("$j"),
                position: locations[j],
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueOrange),
                infoWindow: InfoWindow(
                  title: data[j]['name'],
                  snippet: data[j]['registration'],
                  onTap: () {
                    // do something when label is tapped
                  },
                )
                ));
          });
        }
      }
    } //
  }

  @override
  void initState() {
    super.initState();
    Maps().getLocation();
    getfacility();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        markers: Set.of(_markers!),
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
