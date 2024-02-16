import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_for_you/models/cart_model.dart';

final CafeProvider = StateProvider<CartModel>((ref) {
  return CartModel();
});
