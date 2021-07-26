import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ludic/shared/themes/app_colors.dart';
import 'package:ludic/views/novaSala/telas/1_nomeSala.dart';
import 'package:ludic/views/novaSala/telas/2_addTarefas.dart';
import 'package:ludic/views/novaSala/telas/3_codigoSala.dart';
import 'package:short_uuids/short_uuids.dart';

class NovaSalaView extends StatefulWidget {
  const NovaSalaView({Key? key}) : super(key: key);

  @override
  _NovaSalaViewState createState() => _NovaSalaViewState();
}

class _NovaSalaViewState extends State<NovaSalaView> {
  var nameSalaController = TextEditingController();
  List tarefas = [];
  var uuid = ShortUuid.init();
  int index = 0;

  @override
  Widget build(BuildContext context) {
    String codigoSala = uuid.generate();
    var db = FirebaseFirestore.instance;
    return Scaffold(
        backgroundColor: AppColors.primary,
        appBar: AppBar(
          iconTheme: IconThemeData(color: AppColors.secondary),
        ),
        body: IndexedStack(
          children: [
            NomeSalaView(controller: nameSalaController),
            AddTarefasView(tarefas: tarefas),
            CodigoSalaView(
              codigo: codigoSala,
            )
          ],
          index: index,
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.secondary,
              borderRadius: BorderRadius.circular(29),
            ),
            margin: EdgeInsets.symmetric(vertical: 10),
            child: TextButton(
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                    primary: AppColors.primary),
                child: Text(
                  'Continuar',
                  style: TextStyle(color: AppColors.primary),
                ),
                onPressed: () {
                  if (index < 2) {
                    index += 1;
                    setState(() {});
                  } else {
                    db.collection('salas').add({
                      'nome': nameSalaController.text,
                      'tarefas': tarefas,
                      'codigo': codigoSala,
                      'alunos': []
                    });
                    ScaffoldMessenger.of(context)
                      ..removeCurrentSnackBar()
                      ..showSnackBar(SnackBar(
                          content: Text('Cadastro efetuado com sucesso!')));
                    Navigator.of(context).pop();
                  }
                }),
          ),
        ));
  }
}
