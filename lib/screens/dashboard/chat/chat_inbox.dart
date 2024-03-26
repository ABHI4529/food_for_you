import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_for_you/screens/dashboard/chat/chat_details.dart';
import 'package:food_for_you/services/uff_database.dart';
import 'package:food_for_you/services/utils.dart';

class ChatHistory extends ConsumerStatefulWidget {
  const ChatHistory({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatHistoryState();
}

class _ChatHistoryState extends ConsumerState<ChatHistory> {
  Future<QuerySnapshot> getUsersList() async {
    final userId = await getUserId();

    return FirebaseFirestore.instance
        .collection("messages")
        .where("sender", isEqualTo: userId)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    final database = UffDataBase();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat History"),
      ),
      body: FutureBuilder(
        future: getUsersList(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData || snapshot.hasError) {
            return const Center(child: CircularProgressIndicator());
          }
          final Set<String> receiverSet = {};

          for (var doc in snapshot.data!.docs) {
            receiverSet.add(doc.get('receiver'));
          }
          final List<String> receiverList = receiverSet.toList();

          return ListView.builder(
            itemCount: receiverList.length,
            itemBuilder: (context, index) {
              return FutureBuilder(
                  future: database.getUserFromId(receiverList[index]),
                  builder: (context, snap) {
                    if (!snap.hasData || snap.hasError) {
                      return Container();
                    }
                    if (snap.connectionState == ConnectionState.waiting) {
                      return Container();
                    }
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text(snap.data['userName']
                            .toString()
                            .substring(0, 1)
                            .toUpperCase()),
                      ),
                      title: Text("${snap.data['userName']}"),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatDetails(
                                    receiverId: receiverList[index],
                                    userName: snap.data['userName'])));
                      },
                    );
                  });
            },
          );
        },
      ),
    );
  }
}
