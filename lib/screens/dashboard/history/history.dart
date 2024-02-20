import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_for_you/models/cart_model.dart';
import 'package:food_for_you/models/order_model.dart';
import 'package:food_for_you/screens/dashboard/history/order/order_page.dart';
import 'package:food_for_you/services/uffAuth.dart';
import 'package:food_for_you/services/uff_database.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jiffy/jiffy.dart';
import 'package:collection/collection.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final database = UffDataBase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("History"),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: const Text("Logout"),
                onTap: () {
                  final auth = Auth();
                  auth.logoutAccount(context);
                },
              )
            ],
          ),
        ],
      ),
      body: FutureBuilder(
        future: database.getOrderHistory(context),
        builder: (context, snapshot) {
          if (snapshot.hasError || !snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: snapshot.data.length,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            itemBuilder: (context, index) {
              final order = OrderModel(
                  cafeName: snapshot.data[index]['cafe_name'],
                  isComplete: snapshot.data[index]['isComplete'],
                  orderId: snapshot.data[index]['order_id'],
                  items: snapshot.data[index]['items']
                      .map<Items>((e) => Items.fromJson(e))
                      .toList(),
                  orderTime: snapshot.data[index]['order_time'].toDate(),
                  orderUpdate: snapshot.data[index]['order_update'],
                  userId: snapshot.data[index]['user_id']);
              List<double> rates = [];
              snapshot.data[index]['items'].forEach((e) {
                rates.add(e['item_price']);
              });
              return InkWell(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      showDragHandle: true,
                      builder: (context) => OrderHistory(orderModel: order));
                },
                child: Card(
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(Iconsax.shop),
                              Text(
                                Jiffy.parse(order.orderTime!.toString())
                                    .format(pattern: "EE, dd - mm - yyy"),
                                style: const TextStyle(
                                    fontSize: 13, color: Colors.grey),
                              )
                            ],
                          ),
                          Text(
                            order.cafeName!,
                            style: const TextStyle(fontSize: 16),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Status : ${order.orderUpdate!}",
                                style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey,
                                    fontStyle: FontStyle.italic),
                              ),
                              Text(
                                "₹ ${rates.sum.ceil()}",
                                style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey,
                                    fontStyle: FontStyle.italic),
                              ),
                            ],
                          )
                        ],
                      )),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
