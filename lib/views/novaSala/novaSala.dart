import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ludic/shared/models/user_model.dart';
import 'package:ludic/shared/themes/app_colors.dart';
import 'package:ludic/shared/themes/app_textstyles.dart';
import 'package:ludic/views/novaSala/telas/1_nomeSala.dart';
import 'package:ludic/views/novaSala/telas/2_addTarefas.dart';
import 'package:ludic/views/novaSala/telas/3_codigoSala.dart';
import 'package:random_string/random_string.dart';
import 'package:short_uuids/short_uuids.dart';

class NovaSalaView extends StatefulWidget {
  const NovaSalaView({Key? key}) : super(key: key);

  @override
  _NovaSalaViewState createState() => _NovaSalaViewState();
}

class _NovaSalaViewState extends State<NovaSalaView> {
  var nameSalaController = TextEditingController();
  List<Map<String, String>> tarefas = [];
  var uuid = ShortUuid.init();
  int index = 0;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context)!.settings.arguments as UserModel;
    String codigoSala = randomAlphaNumeric(7);
    var db = FirebaseFirestore.instance;

    return Scaffold(
        backgroundColor: AppColors.primary,
        appBar: AppBar(
          iconTheme: IconThemeData(color: AppColors.secondary),
        ),
        body: Form(
          key: _formKey,
          child: IndexedStack(
            children: [
              NomeSalaView(controller: nameSalaController),
              AddTarefasView(tarefas: tarefas),
              CodigoSalaView(
                codigo: codigoSala,
              )
            ],
            index: index,
          ),
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
                  switch (index) {
                    case 0:
                      if (_formKey.currentState!.validate()) {
                        index += 1;
                        setState(() {});
                      }
                      break;
                    case 1:
                      if (tarefas.isNotEmpty) {
                        index += 1;
                        setState(() {});
                      } else {
                        showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                                  title: Text(
                                      'Por favor, insira ao menos uma tarefa ao planejamento'),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          'OK',
                                          style: TextStyles.primaryCodigoSala,
                                        ))
                                  ],
                                ));
                      }
                      break;
                    case 2:
                      int mapIndex = 0;
                      db.collection('salas').doc(codigoSala).set({
                        'nome': nameSalaController.text,
                        'codigo': codigoSala,
                        'professor': user.name,
                        'alunos': [user.email]
                      });
                      tarefas.forEach((element) {
                        db
                            .collection('salas')
                            .doc(codigoSala)
                            .collection('tarefas')
                            .doc(element['nome'])
                            .set({
                          'nome': element['nome'],
                          'descricao': element['descricao']
                        });
                        if (mapIndex < tarefas.length) {
                          mapIndex += 1;
                        }
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
