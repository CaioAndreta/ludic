import 'package:firebase_auth/firebase_auth.dart';

class Sala {
  final auth = FirebaseAuth.instance;
  List alunos = [];
  String codigo = '';
  String nome = '';
  String professor = '';
  String docId;
  bool isTeacher = false;

  Sala(
      {required this.nome,
      required this.professor,
      required this.alunos,
      required this.codigo,
      this.docId = ''});

      // getTeacher(){
      //   if(auth.currentUser.email)
      // }
}
