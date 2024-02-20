import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_for_you/models/cafe_model.dart';
import 'package:food_for_you/models/cart_model.dart';
import 'package:food_for_you/providers/cafe_provider.dart';
import 'package:food_for_you/providers/cart_provder.dart';
import 'package:food_for_you/screens/dashboard/history/cart/cart.dart';
import 'package:food_for_you/utils/menu.dart';
import 'package:iconsax/iconsax.dart';

class CafePage extends ConsumerStatefulWidget {
  const CafePage({super.key, required this.cafeModel});
  final CafeModel cafeModel;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CafePageState();
}

class _CafePageState extends ConsumerState<CafePage> {
  @override
  Widget build(BuildContext context) {
    List cartList = ref.watch(cartProvider);
    int itemCount = ref.watch(cartProvider).length;
    return Scaffold(
        appBar: AppBar(title: Text("${widget.cafeModel.address}")),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: double.maxFinite,
                height: 200,
                child: Image.network(
                  "https://images.pexels.com/photos/1024359/pexels-photo-1024359.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress?.cumulativeBytesLoaded ==
                        loadingProgress?.expectedTotalBytes) {
                      return child;
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
              CupertinoListSection(
                  backgroundColor: Colors.transparent,
                  children: menuData.map((e) {
                    final itemCount =
                        cartList.where((element) => element == e).toList();
                    return CupertinoListTile(
                      leadingSize: 100,
                      leading: Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        width: 100,
                        height: 80,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.network(
                            e['item_img'],
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress?.cumulativeBytesLoaded ==
                                  loadingProgress?.expectedTotalBytes) {
                                return child;
                              }
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          ),
                        ),
                      ),
                      title: Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: Text(e['item_name'])),
                      subtitle: Column(
                        children: [
                          Text(
                            e['item_description'],
                            overflow: TextOverflow.fade,
                            style: const TextStyle(
                                fontSize: 13, color: Colors.grey),
                          ),
                          Container(
                            alignment: Alignment.bottomRight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "₹ ${e['item_price'].ceil()}",
                                  overflow: TextOverflow.fade,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.grey),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        var oldList = ref.read(cartProvider);
                                        oldList.remove(e);
                                        ref.read(cartProvider.notifier).state =
                                            oldList.toList();
                                      },
                                      iconSize: 15,
                                      icon: const Icon(Iconsax.minus),
                                    ),
                                    Text("${itemCount.length}"),
                                    IconButton(
                                      onPressed: () {
                                        var oldList = ref.read(cartProvider);
                                        oldList.add(e);
                                        ref.read(cartProvider.notifier).state =
                                            oldList.toList();
                                      },
                                      iconSize: 15,
                                      icon: const Icon(Iconsax.add),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        final modal = showModalBottomSheet(
                            context: context,
                            builder: (context) => MenuDetails(itemData: e));
                        modal.then((value) {});
                      },
                    );
                  }).toList())
            ],
          ),
        ),
        floatingActionButton: Badge(
          label: Text(
            cartList.length.toString(),
            key: ValueKey(cartList),
          ),
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
}

class MenuDetails extends ConsumerStatefulWidget {
  MenuDetails({super.key, this.itemData});
  dynamic itemData;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MenuDetailsState();
}

class _MenuDetailsState extends ConsumerState<MenuDetails> {
  @override
  Widget build(BuildContext context) {
    List cartList = ref.watch(cartProvider);
    final itemCount =
        cartList.where((element) => element == widget.itemData).toList();
    return Container(
      width: double.maxFinite,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 180,
            width: double.maxFinite,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.network(
                widget.itemData['item_img'],
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress?.cumulativeBytesLoaded ==
                      loadingProgress?.expectedTotalBytes) {
                    return child;
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ),
          Container(
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.itemData['item_name']}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${widget.itemData['item_description']}",
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  Builder(
                    builder: (context) {
                      if (widget.itemData['spice'] == "Spicy") {
                        return const Text(
                          "🌶️🌶️🌶️",
                          style: TextStyle(fontSize: 18),
                        );
                      } else if (widget.itemData['spice'] == "Medium") {
                        return const Text("🌶️🌶️🌶️",
                            style: TextStyle(fontSize: 18));
                      }
                      return const Text("🌶️", style: TextStyle(fontSize: 18));
                    },
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(
                        Iconsax.danger,
                        color: Colors.red.shade600,
                        size: 18,
                      ),
                      Text("  ${widget.itemData['allergy']}")
                    ],
                  )
                ],
              )),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  var oldList = ref.read(cartProvider);
                  oldList.remove(widget.itemData);
                  ref.read(cartProvider.notifier).state = oldList.toList();
                  Navigator.pop(context);
                },
                iconSize: 15,
                icon: const Icon(Iconsax.minus),
              ),
              Text("${itemCount.length}"),
              IconButton(
                onPressed: () {
                  var oldList = ref.read(cartProvider);
                  oldList.add(widget.itemData);
                  ref.read(cartProvider.notifier).state = oldList.toList();
                  Navigator.pop(context);
                },
                iconSize: 15,
                icon: const Icon(Iconsax.add),
              )
            ],
          )
        ],
      ),
    );
  }
}
