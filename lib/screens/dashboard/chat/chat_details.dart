import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  Future<QuerySnapshot> getChats() async {
    final userId = await getUserId();

    return FirebaseFirestore.instance
        .collection("messages")
        .where("sender", isEqualTo: userId)
        .where("receiver", isEqualTo: widget.receiverId)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.userName),
      ),
      body: FutureBuilder(
        future: getChats(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView(
            padding: const EdgeInsets.all(15),
            reverse: true,
            children: snapshot.data!.docs.map((e) {
              return Align(
                alignment: Alignment.centerRight,
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
                                        e.get('order')['order_time'].toDate())
                                    .format(pattern: "EEE, dd - MM - yyyy"),
                                style: const TextStyle(
                                    fontSize: 11, color: Colors.grey))
                          ],
                        ),
                        Text(
                          e.get('order')['cafe_name'],
                          style: const TextStyle(fontSize: 16),
                        )
                      ],
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
