import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_productos_app/models/product.dart';
import 'package:http/http.dart' as http;

class ProductsService extends ChangeNotifier {
  final String _baseUrl = 'flutter-varios-1702e-default-rtdb.firebaseio.com';

  final List<Product> products = [];

  bool isLoading = true;


  ProductsService() {
    loadProducts();
  }

  Future loadProducts() async {

    final url = Uri.https(_baseUrl, 'products.json');
    final resp = await http.get(url);

    final Map<String, dynamic> productsMap = json.decode(resp.body);
   
  }
}