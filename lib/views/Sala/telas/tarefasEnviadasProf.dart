import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ludic/shared/models/sala_model.dart';
import 'package:ludic/shared/models/tarefa_model.dart';
import 'package:ludic/shared/themes/app_colors.dart';
import 'package:ludic/shared/themes/app_textstyles.dart';

class TarefasEnviadasProf extends StatelessWidget {
  const TarefasEnviadasProf(
      {Key? key, required this.db, required this.sala, required this.auth})
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
      child: StreamBuilder(
          stream: db
              .collection('salas')
              .doc(sala.codigo)
              .collection('tarefas')
              .where('enviada', isEqualTo: true)
              .snapshots(),
          builder: (_, AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                  child: CircularProgressIndicator(color: AppColors.primary));
            }
            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (_, index) {
                  var doc = snapshot.data!.docs[index];
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: GestureDetector(
                          onTap: () {
                            String tarNome = doc['nome'];
                            Tarefa tarefa = Tarefa(
                                nome: tarNome, codigoSala: sala.codigo);
                            Navigator.of(context).pushNamed('/lista-correcao',
                                arguments: tarefa);
                          },
                          child: Container(
                            color: AppColors.secondary,
                            child: ListTile(
                              title: Text(doc['nome'],
                                  style: TextStyles.blackTitleText),
                              subtitle: Text(
                                  'Vencimento: ' +
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
    );
  }
}
