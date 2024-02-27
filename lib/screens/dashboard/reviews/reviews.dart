import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReviewScreen extends ConsumerStatefulWidget {
  const ReviewScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends ConsumerState<ReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reviews"),
      ),
    );
  }
}
