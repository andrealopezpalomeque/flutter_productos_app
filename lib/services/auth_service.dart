import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _firabaseToken = 'AIzaSyCUWmF1lZm519IxP49TplKjTf2dKy4X-DE';

  final storage = new FlutterSecureStorage();

  // ! ---------CREAR USUARIO----------------
  Future<String?> createUser(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      //'returnSecureToken': true,
    };

    final url =
        Uri.https(_baseUrl, '/v1/accounts:signUp', {'key': _firabaseToken});

    final resp = await http.post(url, body: json.encode(authData));

    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp.containsKey('idToken')) {
      await storage.write(key: 'token', value: decodedResp['idToken']);
      return null;
    } else {
      return decodedResp['error']['message'];
    }
  }

  // ! ---------LOGIN----------------
  Future<String?> login(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      //'returnSecureToken': true,
    };

    final url = Uri.https(
        _baseUrl, '/v1/accounts:signInWithPassword', {'key': _firabaseToken});

    final resp = await http.post(url, body: json.encode(authData));

    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp.containsKey('idToken')) {
      await storage.write(
          key: 'token', value: decodedResp['idToken']); //! guarda el token
      return null;
    } else {
      return decodedResp['error']['message'];
    }
  }

// ! ---------LOGOUT----------------
  Future logout() async {
    await storage.delete(key: 'token'); //! borra el token
    return;
  }
}
