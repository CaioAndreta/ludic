import 'package:flutter/material.dart';
import 'package:ludic/shared/models/tarefa_model.dart';
import 'package:ludic/shared/themes/app_textstyles.dart';

class TarefaView extends StatelessWidget {
  const TarefaView({Key? key, required this.tarefa}) : super(key: key);
  final Tarefa tarefa;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text(tarefa.nome, style: TextStyles.blackTitleText),
          Text(tarefa.descricao, style: TextStyles.blackTitleText)
        ],
      ),
    );
  }
}
