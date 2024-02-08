import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_for_you/screens/dashboard/home/home.dart';

import '../../../models/cafe_model.dart';

class SearchCafes extends StatefulWidget {
  const SearchCafes({super.key});

  @override
  State<SearchCafes> createState() => _SearchCafesState();
}

class _SearchCafesState extends State<SearchCafes> {
  String query = "";

  Future<List<CafeModel>> searchCafesByAddress(String address) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('cafes')
          .orderBy("address")
          .startAt([address]).endAt(['$address\uf8ff']).get();

      List<CafeModel> cafes = querySnapshot.docs.map((doc) {
        return CafeModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      return cafes;
    } catch (e) {
      print("Error searching cafes by address: $e");
      return [];
    }
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
                return CafeCard(cafe: e);
              }).toList(),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
