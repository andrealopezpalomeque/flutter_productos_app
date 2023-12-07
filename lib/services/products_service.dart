import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_productos_app/models/product.dart';
import 'package:http/http.dart' as http;

class ProductsService extends ChangeNotifier {
  final String _baseUrl = 'flutter-varios-1702e-default-rtdb.firebaseio.com';

  final List<Product> products = []; // ? FINAL porque no se va a reasignar

  late Product selectedProduct; // ? LATE indica que se inicializara despues

  bool isLoading = true;
  bool isSaving = false;

  ProductsService() {
    loadProducts();
  }

// ! ------ METODOS ------

// * Cargar productos
  Future<List<Product>> loadProducts() async {
    isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, 'products.json');
    final resp = await http.get(url);

    final Map<String, dynamic> productsMap = json.decode(resp.body);

    productsMap.forEach((key, value) {
      final tempProduct = Product.fromMap(value);
      tempProduct.id = key;
      products.add(tempProduct);
    });

    isLoading = false;
    notifyListeners();
    return products;
  }

  //* guardar o crear producto
  Future saveOrCreateProduct(Product product) async {
    isSaving = true;
    notifyListeners();

    if (product.id == null) {
      //? Crear
      await createProduct(product);
    } else {
      //? Actualizar
      await updateProduct(product);
    }

    isSaving = false;
    notifyListeners();
  }

  //* Actualizar producto
  Future updateProduct(Product product) async {
    final url = Uri.https(_baseUrl, 'products/${product.id}.json');
    final resp = await http.put(url, body: product.toJson()); //decode json
    final decodedData = resp.body;

    print(decodedData);

    //! ACTUALIZAR el listado de productos luego de aplicar el cambio, (porque impacta en la base de datos pero no en la pantalla)

    // * Buscar el indice del producto que se actualizo
    final index = products.indexWhere((element) =>
        element.id ==
        product
            .id); //? indexWhere() devuelve el indice del elemento que cumpla la condicion

    // * Actualizar el listado de productos
    products[index] = product;

    return product.id;
  }

  //* Crear producto
  Future<String> createProduct(Product product) async {
    final url = Uri.https(_baseUrl, 'products.json');
    final resp = await http.post(url, body: product.toJson());
    final decodedData = json.decode(resp.body);
    product.id = decodedData['name'];
    products.add(product);
    return product.id!;
  }
}
