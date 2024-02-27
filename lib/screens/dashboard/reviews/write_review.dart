import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_for_you/models/order_model.dart';
import 'package:iconsax/iconsax.dart';
import 'package:collection/collection.dart';

class WriteReviewScreen extends ConsumerStatefulWidget {
  const WriteReviewScreen(
      {super.key, required this.orderId, required this.orderModel});
  final String orderId;
  final OrderModel orderModel;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _WriteReviewScreenState();
}

class _WriteReviewScreenState extends ConsumerState<WriteReviewScreen> {
  double rating = 0;
  final reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<double> rates = [];
    widget.orderModel.items?.forEach((e) {
      rates.add(e.itemPrice!);
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text("Write A Review"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
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
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(top: 15),
                  child: RatingBar.builder(
                      itemBuilder: (context, index) => Icon(
                            CupertinoIcons.star_fill,
                            color: Colors.yellow.shade700,
                          ),
                      onRatingUpdate: (value) {
                        setState(() {
                          rating = value;
                        });
                      })),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Review"),
                    CupertinoTextField(
                      controller: reviewController,
                      maxLines: 4,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FilledButton(
        onPressed: () async {
          if (reviewController.text != "") {
            await FirebaseFirestore.instance.collection("reviews").doc().set({
              "review": reviewController.text,
              "rating": rating,
              "cafe_name": widget.orderModel.cafeName,
              "order_id": widget.orderId,
              "userId": widget.orderModel.userId
            }).then((value) {
              Navigator.pop(context);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Thank you for your review 😀"),
              ));
            });
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Something went wrong"),
            ));
          }
        },
        child: const Text("Submit Review"),
      ),
    );
  }
}
