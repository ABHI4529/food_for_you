import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food_for_you/models/cafe_model.dart';
import 'package:food_for_you/services/utils.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String appbarTitle = "Home";
  List<CafeModel> cafes = [];

  Future checkLocation() async {
    final preferences = await SharedPreferences.getInstance();
    final location = preferences.getString("location");

    if (location != null) {
      setState(() {
        appbarTitle = location;
      });
    } else {
      // ignore: use_build_context_synchronously
      showModalBottomSheet(
          context: context,
          showDragHandle: true,
          builder: (context) => const LocationSheet());
    }
  }

  Future<List<QueryDocumentSnapshot>> refreshCafes() async {
    final query =
        await FirebaseFirestore.instance.collection("cafes").limit(10).get();

    return query.docs;
  }

  @override
  void initState() {
    checkLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                      context: context,
                      showDragHandle: true,
                      builder: (context) => const LocationSheet())
                  .then((value) => checkLocation());
            },
            child: Text(appbarTitle),
          ),
          bottom: AppBar(
            title: CupertinoSearchTextField(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
            ),
            actions: [
              Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: IconButton(
                    color: Colors.white,
                    onPressed: () {},
                    icon: const Icon(Iconsax.filter),
                  ))
            ],
          ),
        ),
        body: FutureBuilder(
          future: refreshCafes(),
          builder: (context, snapshot) {
            if (!snapshot.hasError || !snapshot.hasData) {
              if (snapshot.data != null) {
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final cafe = CafeModel.fromJson(
                        snapshot.data![index].data() as Map<String, dynamic>);
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${cafe.address}",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Row(
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.only(top: 5, right: 10),
                                  height: 100,
                                  width: 100,
                                  color: Theme.of(context).primaryColor,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text("${cafe.ambience}  "),
                                        RatingBar.builder(
                                          itemSize: 20,
                                          initialRating:
                                              double.parse("${cafe.ambience}"),
                                          itemBuilder: (context, _) =>
                                              const Icon(
                                            Icons.star,
                                            color: Color(0xffdada00),
                                            size: 15,
                                          ),
                                          ignoreGestures: true,
                                          onRatingUpdate: (rating) {},
                                        ),
                                      ],
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: const Text(
                                        'Dine-in . Takeaway',
                                        style:
                                            TextStyle(color: Color(0xff548235)),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const Text("Spice Tolerence  "),
                                        RatingBar.builder(
                                          itemSize: 20,
                                          initialRating:
                                              double.parse("${cafe.spicy}"),
                                          itemBuilder: (context, _) =>
                                              const Icon(
                                            Iconsax.star,
                                            color: Color(0xffdada00),
                                            size: 15,
                                          ),
                                          ignoreGestures: true,
                                          onRatingUpdate: (rating) {},
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text("Quality  "),
                                        const SizedBox(
                                          width: 58,
                                        ),
                                        RatingBar.builder(
                                          itemSize: 20,
                                          initialRating:
                                              double.parse("${cafe.qualtity}"),
                                          itemBuilder: (context, _) =>
                                              const Icon(
                                            Iconsax.star,
                                            color: Color(0xffdada00),
                                            size: 15,
                                          ),
                                          ignoreGestures: true,
                                          onRatingUpdate: (rating) {},
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text("Authenticity  "),
                                        const SizedBox(
                                          width: 27,
                                        ),
                                        RatingBar.builder(
                                          itemSize: 20,
                                          initialRating: double.parse(
                                              "${cafe.authenticity}"),
                                          itemBuilder: (context, _) =>
                                              const Icon(
                                            Iconsax.star,
                                            color: Color(0xffdada00),
                                            size: 15,
                                          ),
                                          ignoreGestures: true,
                                          onRatingUpdate: (rating) {},
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            }
            return const Center(child: CircularProgressIndicator());
          },
        ));
  }
}

class LocationSheet extends StatefulWidget {
  const LocationSheet({super.key});

  @override
  State<LocationSheet> createState() => _LocationSheetState();
}

class _LocationSheetState extends State<LocationSheet> {
  final locationController = TextEditingController();

  saveLocation() async {
    final preferences = await SharedPreferences.getInstance();
    preferences.setString("location", locationController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Set Location",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: CupertinoSearchTextField(
              controller: locationController,
            ),
          ),
          const Spacer(),
          Center(
            child: FilledButton(
                onPressed: () {
                  saveLocation();
                  Navigator.pop(context);
                },
                child: const Text("Set Location")),
          ),
          const Spacer()
        ],
      ),
    );
  }
}
