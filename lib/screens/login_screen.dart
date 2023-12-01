import 'package:flutter/material.dart';
import 'package:flutter_productos_app/providers/login_form_provider.dart';
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
            create: (_) => LoginFormProvider(),
            child: const _LoginForm(),
          )
        ])),
        const SizedBox(height: 50),
        const Text('Crear una nueva cuenta',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
              child: ElevatedButton(
                onPressed: loginForm.isLoading
                    ? null
                    : () async {
                        //Quitar el foco del teclado
                        FocusScope.of(context).unfocus();

                        if (!loginForm.isValidForm()) return;

                        loginForm.isLoading = true;

                        await Future.delayed(const Duration(seconds: 2));

                        loginForm.isLoading = false;

                        Navigator.pushReplacementNamed(context, 'home');
                      },
                child: Text(loginForm.isLoading ? 'Espere' : 'Ingresar'),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    primary: Colors.deepPurple),
              ),
            )
          ],
        ),
      ),
    );
  }
}
