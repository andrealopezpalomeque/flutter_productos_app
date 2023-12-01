import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier {
  //key del formulario
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  //campos del formulario
  String email = '';
  String password = '';

  bool isValidForm() {
    //print('$email - $password');
    return formKey.currentState?.validate() ?? false;
  }
}
