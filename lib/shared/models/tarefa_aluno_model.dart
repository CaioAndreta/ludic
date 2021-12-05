import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ludic/shared/models/tarefa_model.dart';
import 'package:ludic/shared/models/tarefa_professor_model.dart';

class TarefaAluno {
  String nomeAluno;
  String email;
  Tarefa_entregue tarefa;
  Timestamp dataEntrega;
  Timestamp dataConclusao;

  TarefaAluno({
    required this.nomeAluno,
    required this.email,
    required this.tarefa,
    required this.dataConclusao,
    required this.dataEntrega
  });
}
