import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ludic/shared/models/sala_model.dart';
import 'package:ludic/shared/themes/app_textstyles.dart';

class Scoreboard extends StatelessWidget {
  const Scoreboard({Key? key, required this.db, required this.sala})
      : super(key: key);
  final Sala sala;
  final FirebaseFirestore db;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: db
            .collection('salas')
            .doc(sala.codigo)
            .collection('leaderboard')
            .orderBy('pontos', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView(
            padding: EdgeInsets.all(20),
            children: [
              Center(
                  child:
                      Text('Placar de pontos', style: TextStyles.primaryTitleText)),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (_, index) {
                    var doc = snapshot.data!.docs[index];
                    return ListTile(
                      title: Text(doc['nome']),
                      trailing: Text(
                        doc['pontos'].toString(),
                        style: TextStyles.blackHintText,
                      ),
                    );
                  }),
            ],
          );
        });
  }
}
