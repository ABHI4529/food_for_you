import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_for_you/providers/cafe_provider.dart';
import 'package:food_for_you/screens/dashboard/home/cafe_page/cafe_page.dart';
import 'package:food_for_you/screens/dashboard/home/home.dart';

import '../../../models/cafe_model.dart';
import 'package:http/http.dart' as http;

class SearchCafes extends ConsumerStatefulWidget {
  const SearchCafes({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchCafesState();
}

class _SearchCafesState extends ConsumerState<SearchCafes> {
  String query = "";

  Future<List<CafeModel>> searchCafesByAddress(String address) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('cafes')
          .orderBy("address")
          .get();

      List<CafeModel> cafes = querySnapshot.docs.map((doc) {
        return CafeModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      return cafes
          .where((element) =>
              element.address!.toLowerCase().contains(address.toLowerCase()))
          .toList();
    } catch (e) {
      print("Error searching cafes by address: $e");
      return [];
    }
  }

  Color getRandomColor() {
    Random random = Random();
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1.0,
    );
  }

  Future fetchPost(int images) async {
    final response = await http.get(
        Uri.parse(
            "https://api.pexels.com/v1/search?query=cafes&per_page=$images"),
        headers: {
          'Authorization':
              '563492ad6f91700001000001db3b8493375f44f5b5cf0c9cccc442fe'
        });
    final data = jsonDecode(response.body);
    return data['photos'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Hero(
          tag: "search",
          child: CupertinoSearchTextField(
            autofocus: true,
            onChanged: (value) {
              Timer.periodic(const Duration(milliseconds: 500), (timer) {
                setState(() {
                  query = value;
                });
                timer.cancel();
              });
            },
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
          ),
        ),
      ),
      body: FutureBuilder(
        future: searchCafesByAddress(query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || !snapshot.hasError) {
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              children: snapshot.data!.map((e) {
                return InkWell(
                    onTap: () {
                      ref.read(CafeProvider.notifier).state.cafeName =
                          e.address;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CafePage(cafeModel: e)));
                    },
                    child: CafeCard(
                      cafe: e,
                      imageUrl: getRandomColor(),
                    ));
              }).toList(),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
