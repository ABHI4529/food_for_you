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

  Future getLocation() async {
    final preferences = await SharedPreferences.getInstance();
    final location = preferences.getString('location');

    final values = await getLatLog(location!);
    return values;
  }

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  Future fetchLatLngFromGoogleMapsUrl(String url) async {
    String placeId = url.split("/")[5];

    String apiKey = "AIzaSyBAEtQdm5dFOGSqaFFbOjv8Zm6VYH4p7N8";
    String requestUrl =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$apiKey";

    var response = await http.get(Uri.parse(requestUrl));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      double lat = data['result']['geometry']['location']['lat'];
      double lng = data['result']['geometry']['location']['lng'];

      return LatLng(lat, lng);
    }

    return "Error";
  }

  List finalCafes = [];

  Future getLocationCafes() async {
    final preferences = await SharedPreferences.getInstance();
    final location = preferences.getString('location');
    final query = await FirebaseFirestore.instance.collection("cafes").get();
    if (location != null || location != "") {
      finalCafes = query.docs
          .where((element) => element[0]['address']!
              .toLowerCase()
              .contains(location!.toLowerCase()))
          .toList();
    }
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
