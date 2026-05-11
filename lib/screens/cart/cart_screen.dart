import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gearapp/provider/cartprovider.dart';

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
                  physics: NeverScrollableScrollPhysics(),
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
                            icon: Icon(Icons.remove),
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
                            icon: Icon(Icons.add),
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
                            icon: Icon(Icons.delete),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                Divider(),
                Container(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total :', style: TextStyle(fontSize: 16)),
                          Text(
                            '\$${totalPrice.toStringAsFixed(1)}',
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),

                              child: Text(
                                'Checkout',
                                style: TextStyle(color: Colors.white),
                              ),
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
          error: (e, _) => Center(child: Text('error = $e')),
          loading: () => Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
