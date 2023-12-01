import 'package:flutter/material.dart';
import 'package:flutter_productos_app/widgets/widgets.dart';

class ProductScreen extends StatelessWidget {
   
  const ProductScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
     body: Scaffold(
        body:SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
              //* IMAGEN DEL PRODUCTO ------------------------------------------------
                const ProductImage(),
              //* ICONO DE REGRESO ------------------------------------------------
                Positioned(
                  top: 60,
                  left: 20,
                  child: IconButton(onPressed: 
                  () => Navigator.of(context).pop(),
                   icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 40),)
                  ),
                // * ICONO DE CAMARA ------------------------------
                  Positioned(
                    top: 60,
                    right: 20,
                    child: IconButton(
                      onPressed: () {},
                    icon: const Icon(Icons.camera_alt_outlined, color: Colors.white, size: 40),)
                    )
                ],
              ),
              //* FORMULARIO DEL PRODUCTO ------------------------------------------------
              const _ProductForm(),
              const SizedBox(height: 100)
          ],)
        )
     ),
    // * BOTON DE GUARDAR PRODUCTO ------------------------------------------------
     floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    floatingActionButton: FloatingActionButton(
      onPressed: () {},
      child: const Icon(Icons.save_outlined),
    )
    );
    
  }
}

class _ProductForm extends StatelessWidget {
  const _ProductForm({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      height: 270,
      decoration: _buildBoxDecoration(),
      child: Form(child: Column(children: [


        const SizedBox(height: 10),
    //* NOMBRE DEL PRODUCTO ------------------------------------------------
        TextFormField(
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.person_outline),
            labelText: 'Nombre del producto',
            border: InputBorder.none
          ),
        ),

        const SizedBox(height: 30),
    // * PRECIO DEL PRODUCTO ------------------------------------------------
        TextFormField(
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.monetization_on_outlined),
            labelText: 'Precio del producto',
            border: InputBorder.none
          ),
        ),

        const SizedBox(height: 30),
    //* DISPONIBILIDAD DEL PRODUCTO ------------------------------------------------
        SwitchListTile.adaptive(
          title: const Text('Disponible'),
          activeColor: Colors.indigo,
          value: true, 
          onChanged: (value) {
        
          }
          ),
        

      ],)),
    );
  }

  BoxDecoration _buildBoxDecoration() => const BoxDecoration(
    color: Colors.white,
    borderRadius:  BorderRadius.only(bottomLeft: Radius.circular(45), bottomRight: Radius.circular(45)),
    boxShadow:   [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 10,
        offset: Offset(0, 5)
      )
    ]
  );
}