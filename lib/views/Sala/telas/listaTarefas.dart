import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ludic/shared/models/sala_model.dart';
import 'package:ludic/shared/models/tarefa_model.dart';
import 'package:ludic/shared/themes/app_colors.dart';
import 'package:ludic/shared/themes/app_textstyles.dart';

class ListaTarefas extends StatefulWidget {
  const ListaTarefas({
    Key? key,
    required this.db,
    required this.sala,
  }) : super(key: key);

  final FirebaseFirestore db;
  final Sala sala;

  @override
  State<ListaTarefas> createState() => _ListaTarefasState();
}

class _ListaTarefasState extends State<ListaTarefas> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: widget.db
            .collection('salas')
            .doc(widget.sala.codigo)
            .collection('tarefas')
            .snapshots(),
        builder: (_, AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
          deleteTarefa(tarNome) {
            widget.db
                .collection('salas')
                .doc(widget.sala.codigo)
                .collection('tarefas')
                .doc(tarNome)
                .delete();
            setState(() {});
          }

          if (!snapshot.hasData) {
            return Center(
                child: CircularProgressIndicator(color: AppColors.primary));
          }
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (_, index) {
                var doc = snapshot.data!.docs[index];
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: GestureDetector(
                    onTap: () {
                      String tarNome = doc['nome'];
                      String tarDesc = doc['descricao'];
                      String tarPath = '${widget.sala.codigo}/$tarNome';
                      Tarefa tarefa = Tarefa(
                          nome: tarNome,
                          descricao: tarDesc,
                          path: tarPath,
                          codigoSala: widget.sala.codigo);
                      Navigator.of(context)
                          .pushNamed('/tarefa-professor', arguments: tarefa);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          color: AppColors.secondary,
                          child: ListTile(
                            trailing: PopupMenuButton(
                              color: AppColors.secondary,
                              itemBuilder: (_) => [
                                PopupMenuItem(
                                    child: ListTile(
                                        leading: Icon(Icons.delete,
                                            color: AppColors.delete),
                                        title: Text('Apagar',
                                            style: TextStyle(
                                                color: AppColors.delete)),
                                        onTap: () {
                                          deleteTarefa(doc['nome']);
                                          Navigator.pop(context);
                                        })),
                              ],
                            ),
                            title: Text(doc['nome'],
                                style: TextStyles.blackTitleText),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              });
        });
  }
}
