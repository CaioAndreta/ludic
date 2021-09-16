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

  Future<void> saveUser(UserModel user) async {
    final instance = await SharedPreferences.getInstance();
    await instance.setString('user', user.toJson());
    print(user.toJson());
    return;
  }

  Future<void> currentUser(BuildContext context) async {
    await Future.delayed(Duration(seconds: 2));
    final instance = await SharedPreferences.getInstance();
    if (instance.containsKey('user')) {
      final json = instance.get('user') as String;
      var user = UserModel.fromJson(json);
      setUser(context, user);
      return;
    } else {
      setUser(context, null);
    }
  }

  static showPopUp(BuildContext context, String msg) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(
                'Erro de Login!',
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
    } else if (e.code == 'email-already-in-use') {
      String erroMsg = 'Este e-mail já está em uso';
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
      final DocumentSnapshot<Map<String, dynamic>> doc =
          await db.collection('usuarios').doc(email).get();
      _user = UserModel.fromMap(doc.data());
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
    try {
      name = name.toUpperCase().trim();
      final authController = AuthController();
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await auth.signInWithEmailAndPassword(email: email, password: password);
      final currUser = auth.currentUser;
      currUser!.updateDisplayName(name);
      final user = UserModel(name: name, email: email, id: currUser.uid, xp: 0);
      db.collection('usuarios').doc(email).set({
        'nome': name,
        'email': email,
        'isTeacher': false,
        'id': currUser.uid
      });
      authController.saveUser(user);
      authController.setUser(context, user);
      Navigator.popUntil(context, ModalRoute.withName('/home'));
    } on FirebaseAuthException catch (e, s) {
      captureErrors(context, e, s);
    }
  }

  profRegister(BuildContext context,
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
      final user = UserModel(name: name, email: email, id: currUser.uid, xp: 0);
      db.collection('usuarios').doc(email).set({
        'nome': name,
        'email': email,
        'isTeacher': true,
        'id': currUser.uid
      });
      authController.saveUser(user);
      authController.setUser(context, user);
      Navigator.popUntil(context, ModalRoute.withName('/home'));
    } on FirebaseAuthException catch (e, s) {
      captureErrors(context, e, s);
    }
  }
}
