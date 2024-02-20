import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import "package:http/http.dart" as http;
import 'package:shared_preferences/shared_preferences.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  LatLng latlng = const LatLng(21.146633, 79.088860);
  final _mapController = MapController();

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
    print(values);
    return values;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Explore"),
      ),
      body: FutureBuilder(
          future: getLocation(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            return FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  initialCenter: snapshot.data,
                  initialZoom: 9.2,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.app',
                  ),
                ]);
          }),
    );
  }
}
