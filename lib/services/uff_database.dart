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

  Future<List<QueryDocumentSnapshot>> getOrderRecommendation() async {
    final userId = await getUserId();

    final orders = await orderCollection
        .where("user_id", isEqualTo: userId)
        .limit(1)
        .get();

    if (orders.docs.isEmpty) {
      final cafes =
          await FirebaseFirestore.instance.collection("cafes").limit(5).get();
      return cafes.docs;
    } else {
      final initialCafe = await FirebaseFirestore.instance
          .collection("cafes")
          .where("address", isEqualTo: orders.docs[0]['cafe_name'])
          .orderBy('ambience', descending: true)
          .limit(1)
          .get();
      final cafes = await FirebaseFirestore.instance
          .collection("cafes")
          .where("ambience", isGreaterThan: initialCafe.docs[0]['ambience'])
          .orderBy('ambience', descending: true)
          .limit(5)
          .get();
      return cafes.docs;
    }
  }
}
