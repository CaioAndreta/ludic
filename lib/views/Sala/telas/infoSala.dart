import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ludic/shared/models/sala_model.dart';
import 'package:ludic/shared/themes/app_colors.dart';
import 'package:ludic/shared/themes/app_textstyles.dart';

class InfoSala extends StatelessWidget {
  const InfoSala({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sala = ModalRoute.of(context)!.settings.arguments as Sala;
    final db = FirebaseFirestore.instance;

    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<QuerySnapshot>(
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
                if (sala.isTeacher == true)
                  Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Text('Código da sala: ${sala.codigo}',
                        style: TextStyles.primaryCodigoSala),
                  ),
                Text('Professor:', style: TextStyles.blackTitleText),
                ListTile(
                    title:
                        Text(sala.professor, style: TextStyles.blackHintText)),
                Text('Alunos:', style: TextStyles.blackTitleText),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (_, index) {
                      var doc = snapshot.data!.docs[index];
                      if (doc['email'] != sala.auth.currentUser!.email)
                        return ListTile(title: Text(doc['nome']));
                      else
                        return Container();
                    }),
              ],
            );
          }),
    );
  }
}
