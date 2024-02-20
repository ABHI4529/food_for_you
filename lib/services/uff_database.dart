import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_for_you/models/order_model.dart';
import 'package:food_for_you/services/utils.dart';

class UffDataBase {
  final orderCollection = FirebaseFirestore.instance.collection("orders");

  Future createOrder(BuildContext context, OrderModel order) async {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text("Creating Order  "), CircularProgressIndicator()],
      ),
    ));
    try {
      await orderCollection.doc().set(order.toJson()).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Order Placed Succesfully")));
      });
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$e")));
    }
  }

  Future getOrderHistory(BuildContext context) async {
    final userId = await getUserId();

    final orders =
        await orderCollection.where("user_id", isEqualTo: userId).get();

    return orders.docs;
  }
}
