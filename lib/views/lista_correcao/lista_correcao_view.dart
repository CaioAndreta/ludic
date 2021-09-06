import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ludic/shared/models/tarefa_aluno_model.dart';
import 'package:ludic/shared/models/tarefa_model.dart';
import 'package:ludic/shared/models/user_model.dart';
import 'package:ludic/shared/themes/app_colors.dart';

class ListaCorrecao extends StatefulWidget {
  const ListaCorrecao({Key? key, required this.tarefa}) : super(key: key);

  final Tarefa tarefa;

  @override
  State<ListaCorrecao> createState() => _ListaCorrecaoState();
}

class _ListaCorrecaoState extends State<ListaCorrecao> {
  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;

    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
        stream: db
            .collection('salas')
            .doc(widget.tarefa.codigoSala)
            .collection('tarefas')
            .doc(widget.tarefa.nome)
            .collection('entregues')
            .snapshots(),
        builder: (_, AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: CircularProgressIndicator(color: AppColors.primary));
          }
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (_, index) {
                var doc = snapshot.data!.docs[index];
                return GestureDetector(
                  onTap: () {
                    String path =
                        '${widget.tarefa.codigoSala}/${widget.tarefa.nome}/alunos/${doc["email"]}';
                    String name = doc['aluno'];
                    String email = doc['email'];
                    TarefaAluno tar =
                        TarefaAluno(email: email, nomeAluno: name, tarefa: widget.tarefa);
                    Navigator.of(context)
                        .pushNamed('/corrigir-tarefa', arguments: tar);
                  },
                  child: Card(
                    child: ListTile(
                      title: Text(doc['aluno']),
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
