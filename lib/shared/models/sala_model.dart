import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class Sala {
  final auth = FirebaseAuth.instance;
  String codigo = '';
  String nome = '';
  String professor = '';
  bool isTeacher;

  Sala(
      {required this.nome,
      required this.professor,
      required this.codigo,
      required this.isTeacher});

  getTeacher(String userEmail, String teacherEmail) {
    return userEmail == teacherEmail ? true : false;
  }
}
