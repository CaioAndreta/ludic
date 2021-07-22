import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ludic/shared/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  static final auth = FirebaseAuth.instance;
  static UserModel? _user;

  get user => _user!;

  static void doSignUp(String name, email, password) async {
    UserModel user = UserModel(name: name, email: email);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('email', email);
    preferences.setString('nome', name);
    auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  static showPopUp(BuildContext context, String msg) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(msg),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'))
              ],
            ));
  }

  static void captureErrors(
      BuildContext context, FirebaseAuthException e, StackTrace s) {
    if (e.code == 'user-disabled') {
      String erroMsg = 'O usuário informado está desabilitado.';
      showPopUp(context, erroMsg);
    } else if (e.code == 'user-not-found') {
      String erroMsg = 'O usuário informado não está cadastrado.';
      showPopUp(context, erroMsg);
    } else if (e.code == 'invalid-email') {
      String erroMsg = 'O domínio do e-mail informado é inválido.';
      showPopUp(context, erroMsg);
    } else if (e.code == 'wrong-password') {
      String erroMsg = 'Email ou senha informados estão incorretos';
      showPopUp(context, erroMsg);
    } else {
      return null;
    }
  }

  static userLogin(BuildContext context, String email, String senha,) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: senha);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('email', email);
      Navigator.of(context).pushReplacementNamed('/home');
    } on FirebaseAuthException catch (e, s) {
      captureErrors(context, e, s);
    }
  }

//   static void setUser(BuildContext context, UserModel? user) {
//     if (user != null) {
//       // saveUser(user);
//       _user = user;
//       Navigator.pushReplacementNamed(context, '/home');
//     } else {
//       Navigator.pushReplacementNamed(context, '/login');
//     }
//   }
// }

// Future<UserModel> getSavedUser() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String jsonUser = prefs.getString('saved_user') as String;
//   print(jsonUser);

//   Map<String, dynamic> mapUser = json.decode(jsonUser);
//   UserModel user = UserModel.fromJson(mapUser);
//   return user;
}
