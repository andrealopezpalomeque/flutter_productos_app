import 'package:flutter/material.dart';
import 'package:flutter_productos_app/models/models.dart';

class ProductFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey =
      GlobalKey<FormState>(); //! referencia al formulario

  Product product;

  ProductFormProvider(
      this.product); //cuando se crea la instancia del provider se le pasa el producto

  /* actualizar switch */
  updateAvailability(bool value) {
    product.available = value;
    notifyListeners();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
