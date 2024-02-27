import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_for_you/models/suggestion_model.dart';
import 'package:food_for_you/services/uff_database.dart';
import 'package:food_for_you/services/utils.dart';

class RecommendationScreen extends ConsumerStatefulWidget {
  const RecommendationScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RecommendationScreenState();
}

class _RecommendationScreenState extends ConsumerState<RecommendationScreen> {
  final _cafeNameController = TextEditingController();
  final _cafeAddressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recommend A Cafe"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            CupertinoTextField(
              controller: _cafeNameController,
              placeholder: "Restraunt Name",
            ),
            CupertinoTextField(
              controller: _cafeAddressController,
              placeholder: "Address",
              maxLines: 3,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
        onPressed: () async {
          final database = UffDataBase();
          final userId = await getUserId();
          final userData = await database.getUserFromId(userId);
          final suggestion = SuggestionModel(
              cafeAddress: _cafeAddressController.text,
              cafeName: _cafeNameController.text,
              userId: userId,
              userName: userData['userName']);
          // ignore: use_build_context_synchronously
          database.saveSuggestionData(context, suggestion).then((value) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content:
                    Text("Thanks 😀! we will look into your suggestion.")));
          });
        },
        child: const Text("Send Suggestion"),
      ),
    );
  }
}
