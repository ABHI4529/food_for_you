import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_for_you/models/order_model.dart';
import 'package:food_for_you/providers/cafe_provider.dart';
import 'package:food_for_you/providers/cart_provder.dart';
import 'package:food_for_you/services/uff_database.dart';
import 'package:food_for_you/services/utils.dart';
import 'package:iconsax/iconsax.dart';
import 'package:collection/collection.dart';

class CartPage extends ConsumerStatefulWidget {
  const CartPage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<CartPage> {
  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(CafeProvider);
    List<double> rates = [];
    cart.items?.forEach((e) {
      rates.add(e.itemPrice!);
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(Iconsax.shop),
                Text(
                  "  ${cart.cafeName}",
                )
              ],
            ),
            CupertinoListSection(
              backgroundColor: Colors.transparent,
              children: cart.items?.map((e) {
                return CupertinoListTile(
                  title: Text("${e.itemName}"),
                  subtitle: Text("${e.itemDescription}"),
                  trailing: Text("₹ ${e.itemPrice!.ceil()}"),
                );
              }).toList(),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              alignment: Alignment.centerRight,
              child: Text(
                "Total : ₹ ${rates.sum.ceil()}",
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FilledButton(
        onPressed: () {
          try {
            getUserId().then((value) {
              final order = OrderModel(
                  cafeName: cart.cafeName,
                  items: cart.items,
                  isComplete: false,
                  orderUpdate: "placed",
                  orderId: value + "uff",
                  userId: value,
                  orderTime: DateTime.now());

              final database = UffDataBase();
              database.createOrder(context, order).then((value) {
                ref.read(cartProvider.notifier).state.clear();
                Navigator.pop(context);
              });
            });
          } catch (e) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("$e")));
          }
        },
        child: const Text("Checkout"),
      ),
    );
  }
}
