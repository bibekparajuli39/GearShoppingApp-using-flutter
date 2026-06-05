import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gearapp/models/cart_item_model.dart';

import 'package:gearapp/models/product_model.dart';
import 'package:gearapp/provider/cartprovider.dart';
import 'package:gearapp/screens/login/login_screen.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  final ProductModel product;
  final String userId;

  const ProductDetailScreen({
    super.key,
    required this.product,
    required this.userId,
  });

  @override
  ConsumerState<ProductDetailScreen> createState() =>
      _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final cartAsync = ref.watch(cartProvider(widget.userId));
    final screenWidth = MediaQuery.of(context).size.width;
    final isWeb = MediaQuery.of(context).size.width > 800;

    return Scaffold(
      appBar: AppBar(title: Text(widget.product.name)),
      body: cartAsync.when(
        data: (cart) {
          final cartItem = cart.firstWhere(
            (item) => item.product.id == widget.product.id,
            orElse: () => CartItemModel(product: widget.product, quantity: 0),
          );

          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: isWeb ? 350 : 220,
                  child: Image.network(
                    widget.product.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            '\$',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            widget.product.price.toString(),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        alignment: Alignment.topLeft,
                        child: Text(
                          widget.product.name,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          widget.product.description,
                          textAlign: TextAlign.justify,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(width: 10),
                                Spacer(),
                                SizedBox(
                                  width: isWeb
                                      ? screenWidth * 0.20
                                      : screenWidth * 0.40,
                                  child: MyButton(
                                    text: 'Add To Cart',
                                    onPressed: () {
                                      ref
                                          .read(cartServiceProvider)
                                          .addToCart(
                                            userId: widget.userId,
                                            productId: cartItem.product,
                                          );
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          backgroundColor: Colors.green,
                                          content: Text('Item added to cart'),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        error: (e, r) => Center(child: Text('Error: $e')),
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
