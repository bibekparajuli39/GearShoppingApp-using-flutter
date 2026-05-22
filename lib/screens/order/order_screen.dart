import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gearapp/provider/order_provider.dart';

class OrderScreen extends ConsumerWidget {
  final String userId;
  const OrderScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderAsync = ref.watch(orderProvider(userId));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 10, 108, 255),
      ),
      body: orderAsync.when(
        data: (order) {
          if (order.docs.isEmpty) {
            return Center(child: Text('No order'));
          } else {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Orders details',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: order.docs.length,
                      itemBuilder: (context, index) {
                        final ord = order.docs[index];
                        return Card(
                          color: Colors.white,

                          margin: EdgeInsets.all(10),
                          child: ExpansionTile(
                            title: Text(
                              'Order : #${ord['orderId']}',
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Text(ord['status']),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Total Price:',
                                  style: TextStyle(fontSize: 15),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  ' \$${ord['totalPrice']}',
                                  style: TextStyle(fontSize: 13),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),

                            children: [
                              ...List.generate(ord['items'].length, (i) {
                                final item = ord['items'][i];

                                return ListTile(
                                  leading: Image.network(item['imageUrl']),
                                  title: Text(item['name']),
                                  subtitle: Text(
                                    "Qty: ${item['quantity']} x ${item['price']}",
                                  ),
                                  trailing: Text(
                                    "\$${((item['quantity'] ?? 0) * (item['price'] ?? 0)).toString()}",
                                  ),
                                );
                              }),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
        error: (e, r) => Center(child: Text('Error = $e')),
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
