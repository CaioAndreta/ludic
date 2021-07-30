import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ludic/shared/themes/app_colors.dart';
import 'package:ludic/shared/themes/app_textstyles.dart';

class SalaView extends StatelessWidget {
  const SalaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.secondaryDark),
      body: StreamBuilder<QuerySnapshot>(
          stream: db.collection('salas').orderBy('nome').snapshots(),
          builder: (_, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                  heightFactor: size.height,
                  widthFactor: size.width,
                  child: CircularProgressIndicator(color: AppColors.primary));
            }
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (_, index) {
                  var doc = snapshot.data!.docs[index];
                  return ListTile(title: Text(doc['alunos'][index]));
                });
          }),
    );
  }
}
