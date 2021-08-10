import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ludic/shared/models/sala_model.dart';
import 'package:ludic/shared/themes/app_textstyles.dart';

class ListaAlunos extends StatelessWidget {
  const ListaAlunos({
    Key? key,
    required this.db,
    required this.sala,
  }) : super(key: key);

  final FirebaseFirestore db;
  final Sala sala;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: db
            .collection('salas')
            .doc(sala.codigo)
            .collection('alunos')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView(
            padding: EdgeInsets.all(20),
            children: [
              Text('Professor:', style: TextStyles.blackTitleText),
              ListTile(
                  title: Text(sala.professor, style: TextStyles.blackHintText)),
              Text('Alunos:', style: TextStyles.blackTitleText),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (_, index) {
                    var doc = snapshot.data!.docs[index];
                    return ListTile(title: Text(doc['nome']));
                  }),
            ],
          );
        });
  }
}
