import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ludic/shared/models/sala_model.dart';
import 'package:ludic/shared/themes/app_colors.dart';
import 'package:ludic/shared/themes/app_textstyles.dart';

class Testezada extends StatefulWidget {
  const Testezada({Key? key}) : super(key: key);

  @override
  _TestezadaState createState() => _TestezadaState();
}

class _TestezadaState extends State<Testezada> {
  var db = FirebaseFirestore.instance
      .collection('salas')
      .doc('DyMCPDM')
      .collection('tarefas');
  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    return FutureBuilder(
        future:
            db.collection('salas').doc('DyMCPDM').collection('tarefas').get(),
        builder: (_, AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: CircularProgressIndicator(color: AppColors.primary));
          }
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (_, index) {
                var doc = snapshot.data!.docs[index];
                return Container(
                  padding: EdgeInsets.fromLTRB(5, 8, 5, 8),
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      color: AppColors.secondaryDark,
                      child: ListTile(
                        subtitle: Text(doc['descricao'],
                            style: TextStyles.blackHintText),
                        title:
                            Text(doc['nome'], style: TextStyles.blackTitleText),
                      ),
                    ),
                  ),
                );
              });
        });
  }
}
