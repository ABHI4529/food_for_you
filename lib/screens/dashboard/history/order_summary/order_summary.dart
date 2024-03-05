import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_for_you/models/cart_model.dart';
import 'package:food_for_you/models/order_model.dart';
import 'package:food_for_you/screens/dashboard/history/order/order_page.dart';
import 'package:food_for_you/services/uff_database.dart';
import 'package:food_for_you/services/utils.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jiffy/jiffy.dart';
import 'package:collection/collection.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

class OrderSummary extends ConsumerStatefulWidget {
  const OrderSummary({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OrderSummaryState();
}

class _OrderSummaryState extends ConsumerState<OrderSummary> {
  var startDate = DateTime(2023, 04, 01);
  var endDate = DateTime.now();
  final database = UffDataBase();
  final controller = WidgetsToImageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Summary"),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: FilledButton(
                onPressed: () async {
                  final dateRange = await showDateRangePicker(
                      context: context,
                      firstDate: DateTime(2023, 04, 01),
                      lastDate: DateTime(2024, 12, 31));
                  if (dateRange != null) {
                    setState(() {
                      startDate = dateRange.start;
                      endDate = dateRange.end;
                    });
                  }
                },
                child: const Text("Select Date")),
          )
        ],
      ),
      body: FutureBuilder(
        future: database.getOrderHistory(context),
        builder: (context, snapshot) {
          if (snapshot.hasError || !snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          var finalOrders = snapshot.data;

          finalOrders
              ?.sort((a, b) => a['order_time'].compareTo(b['order_time']));

          finalOrders = finalOrders
              ?.where((order) =>
                  order['order_time'].toDate().isAfter(startDate) &&
                  order['order_time'].toDate().isBefore(endDate))
              .toList();

          return WidgetsToImage(
              controller: controller,
              child: ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                itemCount: finalOrders!.length,
                itemBuilder: (context, index) {
                  final order = OrderModel(
                      cafeName: snapshot.data?[index]['cafe_name'],
                      isComplete: snapshot.data?[index]['isComplete'],
                      orderId: snapshot.data?[index]['order_id'],
                      items: snapshot.data?[index]['items']
                          .map<Items>((e) => Items.fromJson(e))
                          .toList(),
                      orderTime: snapshot.data?[index]['order_time'].toDate(),
                      orderUpdate: snapshot.data?[index]['order_update'],
                      userId: snapshot.data?[index]['user_id']);
                  List<double> rates = [];
                  snapshot.data?[index]['items'].forEach((e) {
                    rates.add(e['item_price']);
                  });
                  return InkWell(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          showDragHandle: true,
                          builder: (context) => OrderHistory(
                                orderModel: order,
                                orderId: snapshot.data![index].id,
                              ));
                    },
                    child: Card(
                      child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    Jiffy.parse(order.orderTime!.toString())
                                        .format(pattern: "EE, dd - MM - yyy"),
                                    style: const TextStyle(
                                        fontSize: 13, color: Colors.grey),
                                  )
                                ],
                              ),
                              Text(
                                order.cafeName!,
                                style: const TextStyle(fontSize: 16),
                              ),
                              CupertinoListSection(
                                backgroundColor: Colors.transparent,
                                children: order.items!.map((e) {
                                  return CupertinoListTile(
                                    backgroundColor: const Color(0xfff8f5f2),
                                    title: Text(e.itemName!),
                                    trailing: Text("₹ ${e.itemPrice!.ceil()}"),
                                  );
                                }).toList(),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
              ));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final imageData = await controller.capture();
          if (imageData != null) {
            final dir = await getApplicationDocumentsDirectory();
            final file = File("${dir.path}/summary.png");
            await file.create();
            await file.writeAsBytes(imageData);
            await Share.shareXFiles([XFile(file.path)]);
          }
        },
        child: const Icon(CupertinoIcons.share),
      ),
    );
  }
}
