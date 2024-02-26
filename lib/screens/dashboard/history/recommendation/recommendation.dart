import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecommendationScreen extends ConsumerStatefulWidget {
  const RecommendationScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RecommendationScreenState();
}

class _RecommendationScreenState extends ConsumerState<RecommendationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Recommend A Cafe"),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: const Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              CupertinoTextField(
                placeholder: "Restraunt Name",
              ),
              CupertinoTextField(
                placeholder: "Address",
              ),
              CupertinoTextField(
                placeholder: "Contact",
              ),
            ],
          ),
        ));
  }
}
