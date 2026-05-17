import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gearapp/provider/cartprovider.dart';
import 'package:gearapp/service/order_service.dart';

class CartScreen extends ConsumerStatefulWidget {
  final String userId;
  const CartScreen({super.key, required this.userId});

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartAsync = ref.watch(cartProvider(widget.userId));
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: SingleChildScrollView(
        child: cartAsync.when(
          data: (item) {
            final double totalPrice = item.fold(
              0.0,
              (sum, item) => sum + item.product.price * item.quantity,
            );

            if (item.isEmpty) {
              return const Center(child: Text('Your cart is empty'));
            }
            return Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: item.length,
                  itemBuilder: (context, index) {
                    final cartItem = item[index];
                    return ListTile(
                      leading: Image.network(cartItem.product.imageUrl),
                      title: Text(cartItem.product.name),
                      subtitle: Text(
                        '\$${cartItem.product.price.toStringAsFixed(2)}',
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              ref
                                  .read(cartServiceProvider)
                                  .decreaseQuantity(
                                    userId: widget.userId,
                                    productId: cartItem.product,
                                  );
                            },
                            icon: const Icon(Icons.remove),
                          ),
                          Text(cartItem.quantity.toString()),
                          IconButton(
                            onPressed: () {
                              ref
                                  .read(cartServiceProvider)
                                  .increaseQuantity(
                                    userId: widget.userId,
                                    productId: cartItem.product.id,
                                  );
                            },
                            icon: const Icon(Icons.add),
                          ),
                          IconButton(
                            onPressed: () {
                              ref
                                  .read(cartServiceProvider)
                                  .deleteCartItem(
                                    userId: widget.userId,
                                    productId: cartItem.product.id,
                                  );
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Item removed from cart'),
                                ),
                              );
                            },
                            icon: const Icon(Icons.delete),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const Divider(),
                Container(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total :', style: TextStyle(fontSize: 16)),
                          Text(
                            '\$${totalPrice.toStringAsFixed(2)}',
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              final messenger = ScaffoldMessenger.of(context);

                              await OrderService().placeOrder(
                                userId: widget.userId,
                                cartitems: item,
                                totalPrice: totalPrice,
                              );

                              messenger.showSnackBar(
                                const SnackBar(
                                  content: Text('Order placed successfully'),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'Place Order',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
          error: (e, _) => Center(child: Text('Error: $e')),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
