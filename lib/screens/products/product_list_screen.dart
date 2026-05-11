import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gearapp/provider/cartprovider.dart';
import 'package:gearapp/provider/productprovider.dart';

class ProductListScreen extends ConsumerStatefulWidget {
  final String userId;
  const ProductListScreen({super.key, required this.userId});

  @override
  ConsumerState<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends ConsumerState<ProductListScreen> {
  @override
  Widget build(BuildContext context) {
    final product = ref.watch(fetchProductsProvider);
    final isWeb = MediaQuery.of(context).size.width > 800;

    return product.when(
      data: (products) => GridView.builder(
        padding: EdgeInsets.all(40),
        itemCount: products.length,

        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: isWeb ? 4 : 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.75,
        ),
        itemBuilder: (context, index) {
          final product = products[index];
          final inCart = ref.watch(
            cartProvider(widget.userId).select(
              (value) => value.maybeWhen(
                data: (items) => items.any((c) => c.product.id == product.id),
                orElse: () => false,
              ),
            ),
          );
          return Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,

              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(10),
                    ),
                    child: Image.network(
                      product.imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text('\$${product.price}'),
                          ],
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          ref
                              .read(cartServiceProvider)
                              .addToCart(
                                userId: widget.userId,
                                productId: product,
                              );

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Item added to cart'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        },
                        icon: Icon(
                          inCart
                              ? Icons.shopping_cart
                              : Icons.add_shopping_cart,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      error: (e, _) => Text('Error = $e'),
      loading: () => CircularProgressIndicator(),
    );
  }
}
