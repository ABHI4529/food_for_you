import 'dart:convert';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_for_you/models/cafe_model.dart';
import 'package:food_for_you/models/cart_model.dart';
import 'package:food_for_you/providers/cafe_provider.dart';
import 'package:food_for_you/providers/cart_provder.dart';
import 'package:food_for_you/screens/dashboard/history/cart/cart.dart';
import 'package:food_for_you/screens/dashboard/home/cafe_page/cafe_page.dart';
import 'package:food_for_you/screens/dashboard/home/search_cafe.dart';
import 'package:food_for_you/services/uff_database.dart';
import 'package:food_for_you/services/utils.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String appbarTitle = "";
  List<CafeModel> cafes = [];
  List<CafeModel> finalCafes = [];
  String query = "";
  int _limit = 30;
  bool _isLoading = false;
  final ScrollController _scrollController = ScrollController();

  final filters = [
    {"label": "None", "value": ""},
    {"label": "Quantity", "value": "quantity"},
    {"label": "Quality", "value": "qualtity"},
    {"label": "Ambience", "value": "ambience"},
    {"label": "Texture", "value": "texture"},
    {"label": "Authenticity", "value": "authenticity"},
  ];

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
        builder: (context) => LocationSheet(
          onClose: () {
            _refreshCafes();
          },
        ),
      );
    }
  }

  Future filter() async {
    await showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Filter",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Text("Filter cafes according to your preferences"),
                const SizedBox(height: 20),
                ListView(
                  shrinkWrap: true,
                  children: filters
                      .map((e) => ListTile(
                            leading: query == e['value']
                                ? const Icon(Icons.check)
                                : const Text(""),
                            title: Text("${e['label']}"),
                            onTap: () {
                              setState(() => query = "${e['value']}");
                              _refreshCafes(orderBy: query);
                              Navigator.pop(context);
                            },
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _refreshCafes({String orderBy = 'quantity'}) async {
    setState(() {
      _limit = 10;
    });
    await _loadMoreCafes(orderBy: orderBy);
  }

  Future<void> _loadMoreCafes({String orderBy = ''}) async {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });
      final newCafes = await refreshCafes(orderBy: orderBy);
      setState(() {
        cafes.clear(); // Clear previous cafes when loading more
        cafes.addAll(newCafes);
        finalCafes = cafes
            .where((element) => element.address!
                .toLowerCase()
                .contains(appbarTitle.toLowerCase()))
            .toList();
        _isLoading = false;
        _limit += 30;
      });
    }
  }

  Future<List<CafeModel>> refreshCafes({String orderBy = ''}) async {
    Query query = FirebaseFirestore.instance.collection("cafes");
    if (orderBy == '') {
      final querySnapshot = await query.get();
      return querySnapshot.docs
          .map((doc) => CafeModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } else {
      query = query.orderBy(orderBy, descending: true);
      final querySnapshot = await query.get();
      return querySnapshot.docs
          .map((doc) => CafeModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
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
    Clipboard.setData(data);
    return data['photos'];
  }

  final database = UffDataBase();

  @override
  void initState() {
    super.initState();
    _refreshCafes(orderBy: query);
    _scrollController.addListener(_scrollListener);
    checkLocation();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset >=
        _scrollController.position.maxScrollExtent - 700) {
      _loadMoreCafes(orderBy: query);
    }
  }

  @override
  Widget build(BuildContext context) {
    int cartTotal = ref.watch(cartProvider).length;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Food For You"),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: FilledButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    showDragHandle: true,
                    builder: (context) => LocationSheet(
                      onClose: () {
                        _refreshCafes();
                      },
                    ),
                  ).then((value) => checkLocation());
                },
                child: appbarTitle == ""
                    ? const Text('Add Location')
                    : Text(appbarTitle),
              ),
            ),
          ],
          bottom: AppBar(
            title: Hero(
              tag: "search",
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SearchCafes()));
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: const Row(
                    children: [
                      Icon(
                        CupertinoIcons.search,
                        color: CupertinoColors.placeholderText,
                      ),
                      Text(
                        "  Search",
                        style: TextStyle(
                            color: CupertinoColors.placeholderText,
                            fontSize: 16),
                      )
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(
                  color: Colors.white,
                  onPressed: () {
                    filter();
                  },
                  icon: const Icon(Iconsax.filter),
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                child: Text("Filtered by: ${query == "" ? 'None' : query}"),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Card(
                  color: const Color(0xfff50400).withAlpha(50),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Recommended Cafes",
                          style: TextStyle(color: Colors.white),
                        ),
                        FutureBuilder(
                          future: database.getOrderRecommendation(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData || snapshot.hasError) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }

                            return SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                children: snapshot.data!.map((e) {
                                  final cafe = CafeModel.fromJson(
                                      e.data() as Map<String, dynamic>);
                                  return InkWell(
                                    onTap: () {
                                      ref
                                          .read(CafeProvider.notifier)
                                          .state
                                          .cafeName = e['address'];
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => CafePage(
                                                  cafeModel: CafeModel.fromJson(
                                                      e.data() as Map<String,
                                                          dynamic>))));
                                    },
                                    child: CafeCard(
                                        cafe: cafe, imageUrl: getRandomColor()),
                                  );
                                }).toList(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ListView.builder(
                controller: _scrollController,
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                itemCount: finalCafes.length + 1,
                itemBuilder: (context, index) {
                  if (index < finalCafes.length) {
                    return InkWell(
                        onTap: () {
                          ref.read(CafeProvider.notifier).state.cafeName =
                              finalCafes[index].address;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CafePage(cafeModel: finalCafes[index])));
                        },
                        child: CafeCard(
                          cafe: finalCafes[index],
                          imageUrl: getRandomColor(),
                        ));
                  } else {
                    return _buildLoadMoreIndicator();
                  }
                },
              ),
            ],
          ),
        ),
        floatingActionButton: Badge(
          label: Text(ref.watch(cartProvider).length.toString()),
          child: FloatingActionButton(
            child: const Icon(Iconsax.bag),
            onPressed: () {
              ref.read(CafeProvider.notifier).state.items = ref
                  .watch(cartProvider)
                  .map((e) => Items.fromJson(e))
                  .toList();

              if (ref.watch(cartProvider).isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("No Items in the cart")));
              } else {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const CartPage()));
              }
            },
          ),
        ));
  }

  Widget _buildLoadMoreIndicator() {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : Container();
  }
}

class CafeCard extends StatelessWidget {
  const CafeCard({super.key, required this.cafe, required this.imageUrl});

  final CafeModel cafe;
  final Color imageUrl;

  @override
  Widget build(BuildContext context) {
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
                  margin: const EdgeInsets.only(top: 5, right: 10),
                  height: 140,
                  width: 100,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: imageUrl, borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    cafe.address!.substring(0, 1),
                    style: const TextStyle(fontSize: 34, color: Colors.white),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("${cafe.ambience}  "),
                        RatingBar.builder(
                          itemSize: 20,
                          initialRating: double.parse("${cafe.ambience}"),
                          itemBuilder: (context, _) => const Icon(
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
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      child: const Text(
                        'Dine-in . Takeaway',
                        style: TextStyle(color: Color(0xff548235)),
                      ),
                    ),
                    Row(
                      children: [
                        const Text("Spice Tolerence  "),
                        RatingBar.builder(
                          itemSize: 20,
                          initialRating: double.parse("${cafe.spicy}"),
                          itemBuilder: (context, _) => const Icon(
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
                          initialRating: double.parse("${cafe.qualtity}"),
                          itemBuilder: (context, _) => const Icon(
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
                          initialRating: double.parse("${cafe.authenticity}"),
                          itemBuilder: (context, _) => const Icon(
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
                        const Text("Texture"),
                        const SizedBox(
                          width: 64,
                        ),
                        RatingBar.builder(
                          itemSize: 20,
                          initialRating: double.parse("${cafe.texture}"),
                          itemBuilder: (context, _) => const Icon(
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
                        const Text("Spice"),
                        const SizedBox(
                          width: 74,
                        ),
                        Row(
                            children: List.generate(
                                cafe.spicy!, (index) => const Text("🌶️ ")))
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
  }
}

class LocationSheet extends StatefulWidget {
  const LocationSheet({super.key, required this.onClose});
  final Function onClose;

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
                  widget.onClose();
                  Navigator.pop(context);
                },
                child: const Text("Set Location")),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
