import 'package:cloud_firestore/cloud_firestore.dart';

class Tarefa_entregue {
  String nome;
  String? descricao;
  String? path;
  String codigoSala;
  Timestamp? dataEntrega;

  Tarefa_entregue(
      {required this.nome,
      this.descricao,
      this.path,
      required this.codigoSala, this.dataEntrega});
}
