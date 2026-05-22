import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gearapp/provider/category_provider.dart';

class CategoriesScreen extends ConsumerWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryData = ref.watch(categoryProvider);
    final selectedId = ref.watch(selectedCategoryProvider);

    return categoryData.when(
      data: (categories) {
        return SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              final isSelected = category.name == selectedId;

              return GestureDetector(
                onTap: () {
                  ref.read(selectedCategoryProvider.notifier).state = isSelected
                      ? null
                      : category.name;
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: isSelected
                              ? Border.all(
                                  color: const Color.fromARGB(
                                    255,
                                    10,
                                    108,
                                    255,
                                  ),
                                  width: 3,
                                )
                              : null,
                        ),
                        child: CircleAvatar(
                          radius: 35,
                          backgroundImage: NetworkImage(category.imageUrl),
                        ),
                      ),

                      const SizedBox(height: 8),

                      /// NAME
                      Text(
                        category.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isSelected
                              ? const Color.fromARGB(255, 10, 108, 255)
                              : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
      error: (error, stackTrace) => Center(child: Text(error.toString())),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
