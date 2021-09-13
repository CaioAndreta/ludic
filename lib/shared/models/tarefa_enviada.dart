import 'package:ludic/shared/models/tarefa_model.dart';

class TarefaEnviada {
  Tarefa tarefa;
  DateTime dataEntrega;

  TarefaEnviada({
    required this.tarefa,
    required this.dataEntrega,
  });
}
