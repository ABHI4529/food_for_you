import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_for_you/services/utils.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jiffy/jiffy.dart';

class ReviewScreen extends ConsumerStatefulWidget {
  const ReviewScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends ConsumerState<ReviewScreen> {
  Future<List<QueryDocumentSnapshot>> getReviews() async {
    final userId = await getUserId();

    final query = await FirebaseFirestore.instance
        .collection("reviews")
        .where("userId", isEqualTo: userId)
        .get();

    return query.docs;
  }

  Future getCafeFromId(String orderId) async {
    final order = await FirebaseFirestore.instance
        .collection("orders")
        .doc(orderId)
        .get();
    return order.data();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reviews"),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: FutureBuilder(
          future: getReviews(),
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.hasError) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView(
              children: snapshot.data!.map((e) {
                return Card(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FutureBuilder(
                          future: getCafeFromId(e['order_id']),
                          builder: (context, snap) {
                            if (!snap.hasData || snap.hasError) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const CircleAvatar(
                                  radius: 25,
                                  child: Icon(Iconsax.shop),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          Jiffy.parseFromDateTime(snap
                                                  .data['order_time']
                                                  .toDate())
                                              .format(pattern: "dd - mm - yyy"),
                                          textAlign: TextAlign.end,
                                          style: const TextStyle(
                                              fontSize: 10,
                                              fontStyle: FontStyle.italic,
                                              color: Colors.grey),
                                        ),
                                      ),
                                      Text(
                                        snap.data['cafe_name']!,
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                      RatingBarIndicator(
                                        rating: e['rating'],
                                        itemSize: 18,
                                        itemBuilder: (context, index) => Icon(
                                          CupertinoIcons.star_fill,
                                          color: Colors.yellow.shade600,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(e['review'])
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
