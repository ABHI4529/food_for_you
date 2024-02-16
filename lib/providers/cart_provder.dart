import 'package:flutter_riverpod/flutter_riverpod.dart';

final StateProvider<List> cartProvider = StateProvider<List>((ref) {
  return [];
});
