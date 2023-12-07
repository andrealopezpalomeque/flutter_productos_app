import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_productos_app/providers/product_form_provider.dart';
import 'package:flutter_productos_app/widgets/widgets.dart';
import 'package:flutter_productos_app/services/services.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsService = Provider.of<ProductsService>(context);

    return ChangeNotifierProvider(
        create: (_) => ProductFormProvider(productsService.selectedProduct),
        child: _ProductScreenBody(productsService: productsService));
  }
}

class _ProductScreenBody extends StatelessWidget {
  const _ProductScreenBody({
    Key? key,
    required this.productsService,
  }) : super(key: key);

  final ProductsService productsService;

  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);

    return Scaffold(
        body: Scaffold(
            body: SingleChildScrollView(
                //keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                child: Column(
          children: [
            Stack(
              children: [
                //* IMAGEN DEL PRODUCTO ------------------------------------------------
                ProductImage(url: productsService.selectedProduct.picture),
                //* ICONO DE REGRESO ------------------------------------------------
                Positioned(
                    top: 60,
                    left: 20,
                    child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.arrow_back_ios_new,
                          color: Colors.white, size: 40),
                    )),
                // * ICONO DE CAMARA ------------------------------
                Positioned(
                    top: 60,
                    right: 20,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.camera_alt_outlined,
                          color: Colors.white, size: 40),
                    ))
              ],
            ),
            //* FORMULARIO DEL PRODUCTO ------------------------------------------------
            const _ProductForm(),
            const SizedBox(height: 100)
          ],
        ))),
        // * BOTON DE GUARDAR PRODUCTO ------------------------------------------------
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (!productForm.isValidForm()) return;

            await productsService.saveOrCreateProduct(productForm.product);

            //!luego de guardar, regresar a la pantalla anterior
            Navigator.of(context).pop();
          },
          child: const Icon(Icons.save_outlined),
        ));
  }
}

class _ProductForm extends StatelessWidget {
  const _ProductForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    final product = productForm.product;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        height: 270,
        decoration: _buildBoxDecoration(),
        child: Form(
            key: productForm.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                const SizedBox(height: 10),
                //* NOMBRE DEL PRODUCTO ------------------------------------------------
                TextFormField(
                  initialValue: product.name,
                  onChanged: (value) => product.name = value,
                  validator: (value) => value == null || value.isEmpty
                      ? 'El nombre es obligatorio'
                      : null,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person_outline),
                      labelText: 'Nombre del producto',
                      border: InputBorder.none),
                ),

                const SizedBox(height: 30),
                // * PRECIO DEL PRODUCTO ------------------------------------------------
                TextFormField(
                  initialValue: '${product.price}',
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(
                        r'^(\d+)?\.?\d{0,2}')) //? permite solo 2 decimales
                  ],
                  onChanged: (value) =>
                      product.price = double.tryParse(value) ?? 0,
                  validator: (value) => value == null || value.isEmpty
                      ? 'El precio es obligatorio'
                      : null,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.monetization_on_outlined),
                      labelText: 'Precio del producto',
                      border: InputBorder.none),
                ),

                const SizedBox(height: 30),
                //* DISPONIBILIDAD DEL PRODUCTO ------------------------------------------------
                SwitchListTile.adaptive(
                    value: product.available,
                    title: const Text('Disponible'),
                    activeColor: Colors.indigo,
                    onChanged: (value) =>
                        productForm.updateAvailability(value)),
              ],
            )),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(45),
              bottomRight: Radius.circular(45)),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, blurRadius: 10, offset: Offset(0, 5))
          ]);
}
