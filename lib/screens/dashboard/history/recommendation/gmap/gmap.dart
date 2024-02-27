import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GoogleMapScreen extends ConsumerStatefulWidget {
  const GoogleMapScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _GoogleMapScreenState();
}

class _GoogleMapScreenState extends ConsumerState<GoogleMapScreen> {
  Future getLatLog(String place) async {
    var response = await http.get(Uri.parse(
        "https://geocode.maps.co/search?q=$place&api_key=65d4986159a87559635919yeu39cc3e"));
    if (response.statusCode == 200) {
      var mapData = jsonDecode(response.body);
      // _mapController.move(
      //     LatLng(
      //         double.parse(mapData[0]['lat']), double.parse(mapData[0]['lon'])),
      //     10.5);
      return LatLng(
          double.parse(mapData[0]['lat']), double.parse(mapData[0]['lon']));
    }
  }

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  Future getLocation() async {
    final preferences = await SharedPreferences.getInstance();
    final location = preferences.getString('location');

    final values = await getLatLog(location!);
    return values;
  }

  List<Marker> markers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Address"),
      ),
      body: FutureBuilder(
          future: getLocation(),
          builder: (context, snapshot) {
            return GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              markers: Set.from(markers),
              onTap: (argument) {
                setState(() {
                  markers.add(Marker(
                      markerId: const MarkerId("cafe_address"),
                      position: argument,
                      infoWindow: const InfoWindow(title: "Cafe Location")));
                });
              },
              initialCameraPosition: CameraPosition(
                  zoom: 10,
                  target: snapshot.data ?? const LatLng(19.08, 72.88)),
            );
          }),
    );
  }
}
