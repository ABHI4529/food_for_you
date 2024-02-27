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
import 'package:jiffy/jiffy.dart';

class CartPage extends ConsumerStatefulWidget {
  const CartPage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<CartPage> {
  var currentTime = TimeOfDay.now();
  var currentDate = DateTime.now();

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
            ),
            Container(
              margin: const EdgeInsets.only(top: 80),
              child: FilledButton(
                onPressed: () {},
                child: FilledButton(
                    onPressed: () async {
                      final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay(
                              hour: currentTime.hour,
                              minute: currentTime.minute));
                      if (time != null) {
                        setState(() {
                          currentTime = time;
                        });
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Time Slot : "),
                        Text(Jiffy.parseFromDateTime(DateTime(
                                currentDate.year,
                                currentDate.month,
                                currentDate.day,
                                currentTime.hour,
                                currentTime.minute))
                            .format(pattern: "hh : mm aa")),
                      ],
                    )),
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
                  deliveryTime: DateTime(currentDate.year, currentDate.month,
                      currentDate.day, currentTime.hour, currentTime.minute),
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
