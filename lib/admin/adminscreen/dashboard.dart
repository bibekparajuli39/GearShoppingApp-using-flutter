import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gearapp/admin/adminprovider/admin_order_provider.dart';

class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({super.key});

  @override
  ConsumerState<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard> {
  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'shipping':
        return Colors.blue;
      case 'delivered':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final adminOrder = ref.watch(adminorderProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('All Orders')),
      body: adminOrder.when(
        data: (order) {
          final orders = (order?.docs ?? []).where((doc) {
            final data = doc.data() as Map<String, dynamic>;

            final status = (data['status'] ?? '')
                .toString()
                .trim()
                .toLowerCase();

            return status != 'delivered';
          }).toList();

          if (orders.isEmpty) {
            return const Center(child: Text('No orders'));
          }

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final ord = orders[index];
              final data = ord.data() as Map<String, dynamic>;
              final items = (data['items'] ?? []) as List;

              return Card(
                color: Colors.white,

                child: ExpansionTile(
                  title: Text('Order #${data['orderId']}'),

                  subtitle: Text(
                    data['status'],
                    style: TextStyle(
                      color: getStatusColor(data['status']),
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '\$${data['totalPrice']}',
                        style: TextStyle(fontSize: 16),
                      ),
                      Icon(Icons.arrow_right),
                    ],
                  ),

                  children: [
                    ...items.map((item) {
                      return ListTile(
                        leading: Image.network(item['imageUrl'], width: 50),
                        title: Text(item['name']),
                        subtitle: Text(
                          'Qty: ${item['quantity']} x ${item['price']}',
                        ),
                      );
                    }),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: Colors.blue,
                          ),
                          onPressed: () async {
                            await ref
                                .read(orderSerProvider)
                                .updateOrderStatus(
                                  orderId: ord.id,
                                  userId: data['userId'],
                                  status: 'Shipping',
                                );
                          },
                          child: const Text(
                            'Shipping',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: Colors.blue,
                          ),
                          onPressed: () async {
                            await ref
                                .read(orderSerProvider)
                                .updateOrderStatus(
                                  orderId: ord.id,
                                  userId: data['userId'],
                                  status: 'Delivered',
                                );
                          },
                          child: const Text(
                            'Delivered',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              );
            },
          );
        },
        error: (e, s) => Center(child: Text('Error: $e')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
