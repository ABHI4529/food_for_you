import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_for_you/models/cafe_model.dart';
import 'package:food_for_you/models/cart_model.dart';
import 'package:food_for_you/providers/cafe_provider.dart';
import 'package:food_for_you/providers/cart_provder.dart';
import 'package:food_for_you/screens/dashboard/history/cart/cart.dart';
import 'package:food_for_you/screens/dashboard/home/cafe_page/cafe_page.dart';
import 'package:food_for_you/screens/dashboard/home/search_cafe.dart';
import 'package:food_for_you/services/utils.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String appbarTitle = "Home";
  List<CafeModel> cafes = [];
  List<CafeModel> finalCafes = [];
  String query = "quantity";
  int _limit = 30;
  bool _isLoading = false;
  final ScrollController _scrollController = ScrollController();

  final filters = [
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

  Future<void> _loadMoreCafes({String orderBy = 'quantity'}) async {
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

  Future<List<CafeModel>> refreshCafes({String orderBy = 'quantity'}) async {
    Query query = FirebaseFirestore.instance.collection("cafes").limit(_limit);
    query = query.orderBy(orderBy, descending: true);
    final querySnapshot = await query.get();
    return querySnapshot.docs
        .map((doc) => CafeModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

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
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      _loadMoreCafes(orderBy: query);
    }
  }

  @override
  Widget build(BuildContext context) {
    int cartTotal = ref.watch(cartProvider).length;
    return Scaffold(
        appBar: AppBar(
          title: GestureDetector(
            onTap: () {
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
        body: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child: Text("Filtered by: $query"),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await _refreshCafes(orderBy: query);
                },
                child: ListView.builder(
                  controller: _scrollController,
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
                                    builder: (context) => CafePage(
                                        cafeModel: finalCafes[index])));
                          },
                          child: CafeCard(cafe: finalCafes[index]));
                    } else {
                      return _buildLoadMoreIndicator();
                    }
                  },
                ),
              ),
            ),
          ],
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
  const CafeCard({
    super.key,
    required this.cafe,
  });

  final CafeModel cafe;

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
          const Spacer()
        ],
      ),
    );
  }
}
