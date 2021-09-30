import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ludic/shared/models/user_model.dart';
import 'package:ludic/shared/themes/app_colors.dart';
import 'package:ludic/shared/themes/app_textstyles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  UserModel? _user;

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

  Future<void> saveUser(String userEmail) async {
    final instance = await SharedPreferences.getInstance();
    await instance.setString('user', userEmail);
    return;
  }

  Future<void> currentUser(BuildContext context) async {
    await Future.delayed(Duration(seconds: 2));
    final instance = await SharedPreferences.getInstance();
    if (instance.containsKey('user')) {
      var userData =
          await db.collection('usuarios').doc(instance.getString('user')).get();
      var user = UserModel.fromMap(userData.data());
      setUser(context, user);
      return;
    } else {
      setUser(context, null);
    }
  }

  static showPopUp(BuildContext context, String title, String msg) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(
                title,
                style: TextStyles.blackBoldTitleText,
              ),
              content: Text(
                msg,
                style: TextStyles.blackHintText,
              ),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(primary: AppColors.primary),
                    child: Text('OK'))
              ],
            ));
  }

  static void captureErrors(
      BuildContext context, FirebaseAuthException e, StackTrace s) {
    if (e.code == 'user-disabled') {
      String erroMsg = 'O usuário informado está desabilitado.';
      showPopUp(context, 'Erro de Login!', erroMsg);
    } else if (e.code == 'user-not-found') {
      String erroMsg = 'O usuário informado não está cadastrado.';
      showPopUp(context, 'Erro de Login!', erroMsg);
    } else if (e.code == 'invalid-email') {
      String erroMsg = 'O domínio do e-mail informado é inválido.';
      showPopUp(context, 'Erro de Cadastro!', erroMsg);
    } else if (e.code == 'wrong-password') {
      String erroMsg = 'Email ou senha informados estão incorretos';
      showPopUp(context, 'Erro de Login!', erroMsg);
    } else if (e.code == 'email-already-in-use') {
      String erroMsg = 'Este e-mail já está em uso';
      showPopUp(context, 'Erro de Cadastro!', erroMsg);
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
      if (auth.currentUser!.emailVerified == true) {
        final DocumentSnapshot<Map<String, dynamic>> doc =
            await db.collection('usuarios').doc(email).get();
        _user = UserModel.fromMap(doc.data());
        saveUser(doc.id);
        Navigator.of(context).pushReplacementNamed('/home', arguments: user);
      } else {
        await auth.signOut();
        showPopUp(context, 'Verifique o seu E-mail!',
            'Um e-mail foi enviado para $email. Confirme o cadastro da sua conta para continuar utilizando o Ludic.');
      }
    } on FirebaseAuthException catch (e, s) {
      captureErrors(context, e, s);
    }
  }

  userRegister(BuildContext context,
      {required String email,
      required String password,
      required String name}) async {
    try {
      name = name.toUpperCase().trim();
      final authController = AuthController();
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await auth.signInWithEmailAndPassword(email: email, password: password);
      final currUser = auth.currentUser;
      currUser!.updateDisplayName(name);
      currUser.sendEmailVerification();
      final user = UserModel(name: name, email: email, id: currUser.uid, xp: 0);
      db
          .collection('usuarios')
          .doc(email)
          .set({'nome': name, 'email': email, 'id': currUser.uid, 'xp': 0});
      authController.saveUser(email);
      authController.setUser(context, user);
      Navigator.popUntil(context, ModalRoute.withName('/home'));
    } on FirebaseAuthException catch (e, s) {
      captureErrors(context, e, s);
    }
  }
}
