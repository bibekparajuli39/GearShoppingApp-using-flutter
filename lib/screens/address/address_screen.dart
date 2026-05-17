import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gearapp/provider/address_provider.dart';
import 'package:gearapp/service/address_service.dart';

class AddressScreen extends ConsumerWidget {
  final String userId;
  const AddressScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addressAsync = ref.watch(addressprovider(userId));
    return Scaffold(
      appBar: AppBar(title: Text('Address')),
      body: addressAsync.when(
        data: (address) {
          return Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  address.isEmpty ? 'No address found' : address,
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    showAddressPopup(context, userId, address);
                  },
                  child: Text('edit address'),
                ),
              ],
            ),
          );
        },
        error: (e, s) => Text('Error: $e'),
        loading: () => CircularProgressIndicator(),
      ),
    );
  }
}

void showAddressPopup(BuildContext context, String userId, String oldAddress) {
  final controller = TextEditingController(text: oldAddress);
  final service = AddressService();
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Add / edit address'),
              TextField(
                controller: controller,
                decoration: InputDecoration(labelText: 'Enter your address'),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  TextButton(
                    onPressed: () async {
                      await service.updateAddress(userId);
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    },
                    child: Text('delete'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await service.setAddress(userId, controller.text);
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    },
                    child: Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
