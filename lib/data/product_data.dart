import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:gearapp/models/product_model.dart';

Future<List<ProductModel>> loadProducts() async {
  final String response = await rootBundle.loadString('assets/product.json');

  final List<dynamic> data = json.decode(response);
  return data.map((json) => ProductModel.fromJson(json)).toList();
}
