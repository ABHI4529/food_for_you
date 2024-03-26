import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_for_you/models/order_model.dart';
import 'package:food_for_you/services/utils.dart';
import 'package:iconsax/iconsax.dart';

class ProfilesView extends ConsumerStatefulWidget {
  const ProfilesView(
      {super.key, required this.orderId, required this.orderModel});
  final String orderId;
  final OrderModel orderModel;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfilesViewState();
}

class _ProfilesViewState extends ConsumerState<ProfilesView> {
  List selectedUsers = [];

  Future sendOrder() async {
    final query = FirebaseFirestore.instance.collection("messages");
    final userId = await getUserId();

    for (var element in selectedUsers) {
      await query.doc().set({
        "sender": userId,
        "receiver": element,
        "order": widget.orderModel.toJson()
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Share Order"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("users").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView(
            children: snapshot.data!.docs.map((e) {
              return ListTile(
                trailing: selectedUsers.contains(e.get('userId'))
                    ? const Icon(Icons.check)
                    : null,
                selected:
                    selectedUsers.contains(e.get('userId')) ? true : false,
                leading: CircleAvatar(
                  child: Text(e
                      .get('userName')
                      .toString()
                      .substring(0, 1)
                      .toUpperCase()),
                ),
                title: Text(e.get('userName')),
                subtitle: Text(
                  e.get('userEmail'),
                  style: const TextStyle(color: Colors.grey),
                ),
                onTap: () {
                  if (selectedUsers.contains(e.get('userId'))) {
                    selectedUsers.remove(e.get('userId'));
                  } else {
                    selectedUsers.add(e.get('userId'));
                  }
                  setState(() {});
                },
              );
            }).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          sendOrder().then((value) {
            Navigator.pop(context);
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Shared Order Succesfully")));
          });
        },
        child: const Icon(Iconsax.send_2),
      ),
    );
  }
}
