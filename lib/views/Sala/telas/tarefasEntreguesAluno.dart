import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ludic/shared/models/sala_model.dart';
import 'package:ludic/shared/models/tarefa_model.dart';
import 'package:ludic/shared/themes/app_colors.dart';
import 'package:ludic/shared/themes/app_textstyles.dart';

class TarefasEntreguesAluno extends StatelessWidget {
  const TarefasEntreguesAluno(
      {Key? key, required this.auth, required this.sala, required this.db})
      : super(key: key);

  final FirebaseAuth auth;
  final Sala sala;
  final FirebaseFirestore db;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: AppColors.secondaryDark,
      child: Column(
        children: [
          Text('Tarefas Não entregues', style: TextStyles.primaryTitleText),
          StreamBuilder(
              stream: db
                  .collection('salas')
                  .doc(sala.codigo)
                  .collection('tarefas')
                  .where('entregues.${auth.currentUser!.uid}', isEqualTo: false)
                  .snapshots(),
              builder: (_, AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                      child:
                          CircularProgressIndicator(color: AppColors.primary));
                }
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (_, index) {
                      var doc = snapshot.data!.docs[index];
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: GestureDetector(
                          onTap: () {
                            String tarNome = doc['nome'];
                            String tarDesc = doc['descricao'];
                            String tarPath = '${sala.codigo}/$tarNome';
                            Tarefa tarefa = Tarefa(
                                nome: tarNome,
                                descricao: tarDesc,
                                path: tarPath,
                                codigoSala: sala.codigo);
                            Navigator.of(context)
                                .pushNamed('/tarefa-aluno', arguments: tarefa);
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Container(
                                color: AppColors.secondary,
                                child: ListTile(
                                  title: Text(doc['nome'],
                                      style: TextStyles.blackTitleText),
                                  subtitle: Text(
                                      'Vence em ' +
                                          DateFormat('dd/MM/yy')
                                              .format(doc['data de conclusao']
                                                  .toDate())
                                              .toString(),
                                      style: TextStyles.blackHintText),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    });
              }),
          Text('Tarefas Entregues', style: TextStyles.primaryTitleText),
          StreamBuilder(
              stream: db
                  .collection('salas')
                  .doc(sala.codigo)
                  .collection('tarefas')
                  .where('entregues.${auth.currentUser!.uid}', isEqualTo: true)
                  .snapshots(),
              builder: (_, AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                      child:
                          CircularProgressIndicator(color: AppColors.primary));
                }
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (_, index) {
                      var doc = snapshot.data!.docs[index];
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: GestureDetector(
                          onTap: () {
                            String tarNome = doc['nome'];
                            String tarDesc = doc['descricao'];
                            String tarPath = '${sala.codigo}/$tarNome';
                            Tarefa tarefa = Tarefa(
                                nome: tarNome,
                                descricao: tarDesc,
                                path: tarPath,
                                codigoSala: sala.codigo);
                            Navigator.of(context)
                                .pushNamed('/tarefa-aluno', arguments: tarefa);
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Container(
                                color: AppColors.secondary,
                                child: ListTile(
                                  title: Text(doc['nome'],
                                      style: TextStyles.blackTitleText),
                                  subtitle: Text(
                                      'Venceu em ' +
                                          DateFormat('dd/MM/yy')
                                              .format(doc['data de conclusao']
                                                  .toDate())
                                              .toString(),
                                      style: TextStyles.blackHintText),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    });
              }),
        ],
      ),
    );
  }
}
