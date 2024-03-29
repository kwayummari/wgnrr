// ignore_for_file: unnecessary_null_comparison

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wgnrr/api/const.dart';
import 'package:http/http.dart' as http;
import 'package:wgnrr/api/map/maps.dart';
import 'package:wgnrr/models/client/chats/table/services.dart';
import 'package:wgnrr/utils/animation/shimmers/map-shimmer.dart';
import 'package:wgnrr/utils/widget/text/text.dart';

class MapSample extends StatefulWidget {
  const MapSample({Key? key}) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  List data = [];
  List<LatLng> locations = [];
  Set<Marker>? _markers = <Marker>{};
  Position? position;
  Future getfacility() async {
    final pharmacy = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(68, 68)),
      'assets/hospital3.png',
    );
    final home = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(48, 48)),
      'assets/home.png',
    );
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
        _markers!.add(Marker(
            markerId: MarkerId("Userlocation"),
            position: LatLng(position!.latitude, position!.longitude),
            icon: home,
            infoWindow: InfoWindow(
              title: 'Your Location',
              onTap: () => null,
            )));
        for (var j = 0; j < locations.length; j++) {
          setState(() {
            _markers!.add(Marker(
                markerId: MarkerId("$j"),
                position: locations[j],
                icon: pharmacy,
                infoWindow: InfoWindow(
                  title: 'Name: ' + data[j]['name'],
                  snippet: 'Facility: ' + data[j]['registration'],
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            servicesChoices(facility_name: data[j]['name'])));
                  },
                )));
          });
        }
      }
    } //
  }

  Future<Position> _determinePosition() async {
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
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position p = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      position = p;
      getfacility();
    });

    return position = await Geolocator.getCurrentPosition();
  }

  var username;
  var status;
  var bot;
  var language;
  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var u = sharedPreferences.get('username');
    var s = sharedPreferences.get('status');
    var b = sharedPreferences.get('bot');
    var l = sharedPreferences.get('language');
    setState(() {
      username = u;
      status = s;
      bot = b;
      language = l;
    });
  }

  @override
  void initState() {
    super.initState();
    Maps().getLocation();
    _determinePosition();
    getValidationData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        toolbarHeight: 90,
        backgroundColor: HexColor('#742B90'),
        title: Row(
          children: [
            Center(
              child: Container(
                  width: size.width / 1.4,
                  child: AppText(
                    txt: language == 'Kiswahili'
                        ? 'Chagua Kituo'
                        : 'Choose Facility',
                    size: 15,
                    weight: FontWeight.w500,
                    color: Colors.white,
                  )),
            ),
            Spacer(),
          ],
        ),
        centerTitle: true,
      ),
      body: data.isEmpty
          ? mapShimmerLoading(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              borderRadius: 0)
          : GoogleMap(
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              markers: Set.of(_markers!),
              initialCameraPosition: CameraPosition(
                target: LatLng(position!.latitude, position!.longitude),
                zoom: 13.4746,
              ),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                if (Platform.isAndroid) {
                  
                  controller
                      .setMapStyle("mapbox://styles/mapbox/54196e48a30d7f1");
                } else {
                  controller
                      .setMapStyle("mapbox://styles/mapbox/9995ba591aaddfcf");
                }
              },
            ),
    );
  }
}
