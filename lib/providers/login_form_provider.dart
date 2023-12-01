import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier {
  //key del formulario
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  //-------CAMPOS FORMULARIO-------
  String email = '';
  String password = '';
//-------CARGANDO-------
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm() {
    //print('$email - $password');
    return formKey.currentState?.validate() ?? false;
  }
}
