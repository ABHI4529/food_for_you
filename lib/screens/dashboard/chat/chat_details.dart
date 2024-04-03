import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_for_you/models/cart_model.dart';
import 'package:food_for_you/models/order_model.dart';
import 'package:food_for_you/screens/dashboard/history/order/order_page.dart';
import 'package:food_for_you/services/utils.dart';
import 'package:jiffy/jiffy.dart';

class ChatDetails extends ConsumerStatefulWidget {
  const ChatDetails(
      {super.key, required this.receiverId, required this.userName});
  final String userName;

  final String receiverId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatDetailsState();
}

class _ChatDetailsState extends ConsumerState<ChatDetails> {
  Future<List<Map<String, dynamic>>> getAllChats() async {
    final userId = await getUserId();
    final senderChats = await FirebaseFirestore.instance
        .collection("messages")
        .where("sender", isEqualTo: userId)
        .where("receiver", isEqualTo: widget.receiverId)
        .get();

    final receiverChats = await FirebaseFirestore.instance
        .collection("messages")
        .where("sender", isEqualTo: widget.receiverId)
        .where("receiver", isEqualTo: userId)
        .get();

    final allChats = <Map<String, dynamic>>[];
    allChats.addAll(senderChats.docs.map((doc) => doc.data()));
    allChats.addAll(receiverChats.docs.map((doc) => doc.data()));
    allChats.sort(
        (a, b) => a['order']['order_time'].compareTo(b['order']['order_time']));

    return allChats;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.userName),
      ),
      body: FutureBuilder(
        future: getAllChats(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView(
            padding: const EdgeInsets.all(15),
            reverse: true,
            children: snapshot.data!.map((e) {
              return SizedBox(
                width: double.maxFinite,
                child: Align(
                  alignment: e['receiver'] == widget.receiverId
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: InkWell(
                    onTap: () {
                      final order = OrderModel(
                          cafeName: e['order']['cafe_name'],
                          isComplete: e['order']['isComplete'],
                          orderId: e['order']['order_id'],
                          items: e['order']['items']
                              .map<Items>((e) => Items.fromJson(e))
                              .toList(),
                          orderTime: e['order']['order_time'].toDate(),
                          orderUpdate: e['order']['order_update'],
                          userId: e['order']['user_id']);
                      showModalBottomSheet(
                          context: context,
                          showDragHandle: true,
                          builder: (context) => OrderHistory(
                                orderModel: order,
                                hideButton: true,
                                orderId: e['order']['order_id'],
                              ));
                    },
                    child: Card(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        width: 300,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    Jiffy.parseFromDateTime(
                                            e['order']['order_time'].toDate())
                                        .format(pattern: "EEE, dd - MM - yyyy"),
                                    style: const TextStyle(
                                        fontSize: 11, color: Colors.grey))
                              ],
                            ),
                            Text(
                              e['order']['cafe_name'],
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
