import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_for_you/models/order_model.dart';
import 'package:iconsax/iconsax.dart';
import 'package:collection/collection.dart';

class OrderHistory extends ConsumerStatefulWidget {
  const OrderHistory({super.key, required this.orderModel});
  final OrderModel orderModel;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends ConsumerState<OrderHistory> {
  @override
  Widget build(BuildContext context) {
    List<double> rates = [];
    widget.orderModel.items?.forEach((e) {
      rates.add(e.itemPrice!);
    });
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 25,
              child: Icon(Iconsax.shop),
            ),
            const SizedBox(height: 5),
            Text(
              widget.orderModel.cafeName!,
              style: const TextStyle(fontSize: 18),
            ),
            CupertinoListSection(
              backgroundColor: Colors.transparent,
              children: widget.orderModel.items!.map((e) {
                return CupertinoListTile(
                  backgroundColor: const Color(0xfff8f5f2),
                  title: Text(e.itemName!),
                  trailing: Text("₹ ${e.itemPrice!.ceil()}"),
                );
              }).toList(),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                "₹ ${rates.sum.ceil()}",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: FilledButton(
                  onPressed: () {}, child: const Text("Write Review")),
            )
          ],
        ),
      ),
    );
  }
}