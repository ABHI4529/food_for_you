import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import "package:http/http.dart" as http;
import 'package:shared_preferences/shared_preferences.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  LatLng latlng = const LatLng(21.146633, 79.088860);

  Future<LatLng> getLatLog(String place) async {
    const apiKey = "AIzaSyBAEtQdm5dFOGSqaFFbOjv8Zm6VYH4p7N8";

    var response = await http.get(Uri.parse(
        "https://maps.googleapis.com/maps/api/geocode/json?address=$place&key=$apiKey"));
    var mapData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      // _mapController.move(
      //     LatLng(
      //         double.parse(mapData[0]['lat']), double.parse(mapData[0]['lon'])),
      //     10.5);
    }
    return LatLng(mapData['results'][0]['geometry']['location']['lat'],
        mapData['results'][0]['geometry']['location']['lng']);
  }

  Future getLocation() async {
    final preferences = await SharedPreferences.getInstance();
    final location = preferences.getString('location');

    final values = await getLatLog(location!);
    return values;
  }

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  List finalCafes = [];

  Future<List<QueryDocumentSnapshot>> getLocationCafes() async {
    final preferences = await SharedPreferences.getInstance();
    final location = preferences.getString('location');
    final query = await FirebaseFirestore.instance.collection("cafes").get();
    return query.docs;
  }

  List<Marker> markers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Explore"),
      ),
      body: FutureBuilder(
          future: getLocation(),
          builder: (context, snapshot) {
            return GoogleMap(
              onMapCreated: (GoogleMapController controller) async {
                _controller.complete(controller);
                final cafes =
                    await FirebaseFirestore.instance.collection("cafes").get();
                for (var element in cafes.docs) {
                  if (element['latLng'] != null) {
                    setState(() {
                      markers.add(Marker(
                          markerId: MarkerId(element['address']),
                          infoWindow: InfoWindow(title: element['address']),
                          position: LatLng(
                              element['latLng'][0], element['latLng'][1])));
                    });
                  }
                }
              },
              markers: Set.from(markers),
              initialCameraPosition: CameraPosition(
                  zoom: 10,
                  target: snapshot.data ?? const LatLng(19.08, 72.88)),
            );
          }),
    );
  }
}
