// ignore_for_file: unnecessary_null_comparison

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wgnrr/api/const.dart';
import 'package:http/http.dart' as http;
import 'package:wgnrr/api/map/maps.dart';
import 'package:wgnrr/models/client/pharmacy/service_pharmacy.dart';
import 'package:wgnrr/utils/animation/shimmers/map-shimmer.dart';

class MapSample_pharmacy extends StatefulWidget {
  const MapSample_pharmacy({Key? key}) : super(key: key);

  @override
  State<MapSample_pharmacy> createState() => MapSample_pharmacyState();
}

class MapSample_pharmacyState extends State<MapSample_pharmacy> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-6.82349, 39.26951),
    zoom: 14.4746,
  );
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
    const url = '${murl}facility_pharmacy/facility.php';
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
                        builder: (context) => servicesChoices_pharmacy(
                            facility_name: data[j]['name'])));
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
                  child: Text(
                    language == 'Kiswahili'
                        ? 'Chagua Kategoria'
                        : 'Choose Category',
                    style: GoogleFonts.rajdhani(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
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
              mapType: MapType.hybrid,
              initialCameraPosition: CameraPosition(
                target: LatLng(position!.latitude, position!.longitude),
                zoom: 13.4746,
              ),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
    );
  }
}
