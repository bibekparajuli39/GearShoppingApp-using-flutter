import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gearapp/models/cart_item_model.dart';
import 'package:gearapp/service/cart_services.dart';

final cartServiceProvider = Provider((ref) {
  return CartServices();
});

final cartProvider = StreamProvider.family<List<CartItemModel>, String>((
  ref,
  userId,
) {
  final cartService = ref.watch(cartServiceProvider);
  return cartService.getCartItem(userId);
});
