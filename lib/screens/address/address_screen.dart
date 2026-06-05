import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gearapp/provider/address_provider.dart';
import 'package:gearapp/service/address_service.dart';

class AddressScreen extends ConsumerWidget {
  final String userId;
  const AddressScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final addressAsync = ref.watch(addressprovider(userId));
    return Scaffold(
      appBar: AppBar(title: Text('Address')),
      body: addressAsync.when(
        data: (address) {
          return Container(
            padding: const EdgeInsets.all(10),
            width: width > 900 ? width * 0.5 : double.infinity,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    address.isEmpty ? 'No address found' : address,
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 10, 108, 255),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      showAddressPopup(context, userId, address);
                    },
                    child: Text('edit address'),
                  ),
                ],
              ),
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
          padding: const EdgeInsets.all(10),
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 0, 0),

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () async {
                      await service.updateAddress(userId);
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      'delete',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('cancel'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 10, 108, 255),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
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
