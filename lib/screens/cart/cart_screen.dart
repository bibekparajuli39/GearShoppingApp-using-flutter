import 'package:flutter/material.dart';

import 'package:gearapp/models/product_model.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<ProductModel> cartItems = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: Expanded(
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: cartItems.length,
          itemBuilder: (context, index) {
            final product = cartItems[index];
            return ListTile(
              title: Text(product.name),
              subtitle: Text('\$${product.price}'),
            );
          },
        ),
      ),
    );
  }
}
