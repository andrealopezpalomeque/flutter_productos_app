import 'package:flutter/material.dart';
import 'package:flutter_productos_app/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
      ),
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) =>
             
              // * REDIRECCIONAR A LA PANTALLA DE PRODUCTO APRETANDO EL CARD ------------------------------------------------
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, 'product'),
                child: const ProductCard())),
    // * BOTON DE AGREGAR PRODUCTO ------------------------------------------------
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
