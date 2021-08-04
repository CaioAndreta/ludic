import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ludic/shared/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  final auth = FirebaseAuth.instance;
  var _user;

  get user => _user;

  setUser(BuildContext context, UserModel? user) {
    if (user != null) {
      final UserModel usuario;
      usuario = user;
      Navigator.of(context).pushReplacementNamed('/home', arguments: user);
      return usuario;
    } else {
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  Future<void> saveUser(UserModel user) async {
    final instance = await SharedPreferences.getInstance();
    await instance.setString('user', user.toJson());
    return;
  }

  Future<void> currentUser(BuildContext context) async {
    await Future.delayed(Duration(seconds: 2));
    final instance = await SharedPreferences.getInstance();
    if (instance.containsKey('user')) {
      final json = instance.get('user') as String;
      setUser(context, UserModel.fromJson(json));
      return;
    } else {
      setUser(context, null);
    }
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

  userLogin(
    BuildContext context,
    String email,
    String senha,
  ) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: senha);
      final user = UserModel(
          name: auth.currentUser!.displayName,
          email: auth.currentUser!.email,
          id: auth.currentUser!.uid);
      saveUser(user);
      Navigator.of(context).pushReplacementNamed('/home', arguments: user);
    } on FirebaseAuthException catch (e, s) {
      captureErrors(context, e, s);
    }
  }

  alunoRegister(BuildContext context,
      {required String email,
      required String password,
      required String name}) async {
    final authController = AuthController();
    auth.createUserWithEmailAndPassword(email: email, password: password);
    final currUser = auth.currentUser;
    currUser!.updateDisplayName(name.toUpperCase().trim());
    final user = UserModel(name: name, email: email, id: currUser.uid);
    authController.saveUser(user);
    authController.setUser(context, user);
  }

  profRegister(BuildContext context,
      {required String email,
      required String password,
      required String name}) async {
    final authController = AuthController();
    auth.createUserWithEmailAndPassword(email: email, password: password);
    final currUser = auth.currentUser;
    currUser!.updateDisplayName(name.toUpperCase().trim());
    final user = UserModel(name: name, email: email, id: currUser.uid);
    authController.saveUser(user);
    authController.setUser(context, user);
  }
}
