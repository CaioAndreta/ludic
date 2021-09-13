import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ludic/shared/models/tarefa_model.dart';

class TarefaAluno {
  String nomeAluno;
  String email;
  Tarefa tarefa;
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
