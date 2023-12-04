import 'package:flutter/material.dart';
import 'package:flutter_productos_app/providers/login_form_provider.dart';
import 'package:flutter_productos_app/services/services.dart';
import 'package:flutter_productos_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AuthBackground(
            child: SingleChildScrollView(
                child: Column(
      children: [
        const SizedBox(height: 250),
        CardContainer(
            child: Column(children: [
          const SizedBox(height: 10),
          Text('Login', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 30),
          ChangeNotifierProvider(
            // * PROVIDER DEL FORMULARIO DE LOGIN ------------------------------------------------
            create: (_) => LoginFormProvider(),
            // * FORMULARIO DE LOGIN ------------------------------------------------
            child: const _LoginForm(),
          )
        ])),
        const SizedBox(height: 50),
        TextButton(
            onPressed: () =>
                Navigator.pushReplacementNamed(context, 'register'),
            style: ButtonStyle(
              overlayColor:
                  MaterialStateProperty.all(Colors.indigo.withOpacity(0.1)),
            ),
            child: const Text('Crear una nueva cuenta',
                style: TextStyle(fontSize: 18, color: Colors.black87))),
      ],
    ))));
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    return Container(
      child: Form(
        //Mantener la referencia al KEY
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,

        child: Column(
          children: [
            // * EMAIL ------------------------------------------------
            TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.black54),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    prefixIcon: Icon(Icons.email_outlined)),
                onChanged: (value) => loginForm.email = value,
                validator: (value) {
                  String pattern =
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

                  RegExp regExp = RegExp(pattern);

                  return regExp.hasMatch(value ?? '')
                      ? null
                      : 'El correo no es válido';
                }),
            const SizedBox(height: 30),
            // * PASSWORD ------------------------------------------------
            TextFormField(
                autocorrect: false,
                obscureText: true,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.black54),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    prefixIcon: Icon(Icons.lock_outline)),
                onChanged: (value) => loginForm.password = value,
                validator: (value) {
                  return value != null && value.length >= 6
                      ? null
                      : 'La contraseña debe tener al menos 6 caracteres';
                }),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              // * BOTON DE INGRESO ------------------------------------------------
              child: ElevatedButton(
                onPressed: loginForm.isLoading
                    ? null
                    : () async {
                        // *Quitar el foco del teclado ------------------------------------------------
                        FocusScope.of(context).unfocus();
                        //! authService es una instancia de la clase AuthService --------------
                        final authService =
                            Provider.of<AuthService>(context, listen: false);

                        if (!loginForm.isValidForm()) return;

                        loginForm.isLoading = true;

                        //! VALIDAR SI EL LOGIN ES CORRECTO
                        final String? errorMessage = await authService.login(
                            loginForm.email, loginForm.password);

                        if (errorMessage == null) {
                          Navigator.pushReplacementNamed(context, 'home');
                        } else {
                          //! Mostrar error
                          print(errorMessage);
                          loginForm.isLoading = false;
                        }
                      },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    primary: Colors.deepPurple),
                child: Text(loginForm.isLoading ? 'Espere' : 'Ingresar'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
