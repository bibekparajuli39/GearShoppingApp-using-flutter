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
      body: cartAsync.when(
        data: (item) {
          return ListView.builder(
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
                    IconButton(onPressed: () {}, icon: Icon(Icons.remove)),
                    Text(cartItem.quantity.toString()),
                    IconButton(onPressed: () {}, icon: Icon(Icons.add)),
                  ],
                ),
              );
            },
          );
        },
        error: (e, _) => Text('error = $e'),
        loading: () => CircularProgressIndicator(),
      ),
    );
  }
}
