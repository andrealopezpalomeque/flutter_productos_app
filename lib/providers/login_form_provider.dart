import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier {
  //* -------KEY FORMULARIO-------
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //* -------CAMPOS FORMULARIO-------
  String email = '';
  String password = '';

// ! -------CARGANDO-------
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

// * -------VALIDAR FORMULARIO-------
  bool isValidForm() {
    //print('$email - $password');
    return formKey.currentState?.validate() ?? false;
  }
}
