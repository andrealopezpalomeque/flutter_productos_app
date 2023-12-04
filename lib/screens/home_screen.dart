import 'package:flutter/material.dart';
import 'package:flutter_productos_app/screens/screens.dart';
import 'package:flutter_productos_app/services/services.dart';
import 'package:flutter_productos_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsService = Provider.of<ProductsService>(context);

    if (productsService.isLoading) {
      return const LoadingScreen();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
      ),
      body: ListView.builder(
          itemCount: productsService.products.length, // !cantidad de productos
          itemBuilder: (BuildContext context, int index) =>

              // * REDIRECCIONAR A LA PANTALLA DE PRODUCTO APRETANDO EL CARD ------------------------------------------------
              GestureDetector(
                  onTap: () => Navigator.pushNamed(context, 'product'),
                  child: ProductCard(
                    product: productsService
                        .products[index], //! envio el producto como parametro
                  ))),
      // * BOTON DE AGREGAR PRODUCTO ------------------------------------------------
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
