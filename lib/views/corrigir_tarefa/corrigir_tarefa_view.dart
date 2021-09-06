import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:ludic/shared/models/firebaseFile.dart';
import 'package:ludic/shared/models/tarefa_aluno_model.dart';
import 'package:ludic/shared/themes/app_colors.dart';
import 'package:ludic/shared/themes/app_textstyles.dart';
import 'package:ludic/shared/widgets/button.dart';
import 'package:ludic/shared/widgets/inputField.dart';
import 'package:url_launcher/url_launcher.dart';

class CorrigirTarefa extends StatefulWidget {
  const CorrigirTarefa({Key? key, required this.tarefaAluno}) : super(key: key);
  final TarefaAluno tarefaAluno;

  @override
  State<CorrigirTarefa> createState() => _CorrigirTarefaState();
}

class _CorrigirTarefaState extends State<CorrigirTarefa> {
  var storage = FirebaseStorage.instance;
  late Future<List<FirebaseFile>> futureFiles;
  Future<List<String>> _getDownloadLinks(List<Reference> refs) =>
      Future.wait(refs.map((ref) => ref.getDownloadURL()).toList());

  Future<List<FirebaseFile>> listAll(String path) async {
    final ref = FirebaseStorage.instance.ref(path);
    final result = await ref.listAll();
    final urls = await _getDownloadLinks(result.items);
    return urls
        .asMap()
        .map((index, url) {
          final ref = result.items[index];
          final name = ref.name;
          final file = FirebaseFile(ref: ref, name: name, url: url);

          return MapEntry(index, file);
        })
        .values
        .toList();
  }

  void initState() {
    super.initState();
    futureFiles = listAll('${widget.tarefaAluno.tarefa.path}');
  }

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(),
        body: FutureBuilder<List<FirebaseFile>>(
            future: futureFiles,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                    child: CircularProgressIndicator(color: AppColors.primary));
              }
              var files = snapshot.data!;
              return Container(
                margin: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Aluno',
                      style: TextStyles.blackHintText,
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        margin: EdgeInsets.only(bottom: 10),
                        child: Text(widget.tarefaAluno.nomeAluno,
                            style: TextStyles.blackTitleText)),
                    Text(
                      'Arquivos:',
                      style: TextStyles.blackHintText,
                    ),
                    Container(
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: files.length,
                          itemBuilder: (context, index) {
                            final file = files[index];
                            return ListTile(
                              title:
                                  Text(file.name, style: TextStyles.cardTitle),
                              trailing: IconButton(
                                icon: Icon(Icons.download),
                                onPressed: () async {
                                  Future openFile() async {
                                    await launch(file.url);
                                  }

                                  await openFile();
                                },
                              ),
                            );
                          }),
                    )
                  ],
                ),
              );
            }),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.primary,
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
                  'Corrigir',
                  style: TextStyle(color: AppColors.secondary),
                ),
                onPressed: () {
                  TextEditingController notaController =
                      TextEditingController();
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) => StatefulBuilder(builder:
                              (BuildContext context,
                                  StateSetter setModalState) {
                            return Container(
                              height: size.height * 0.5,
                              decoration: BoxDecoration(
                                  color: AppColors.secondaryDark,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(25.0),
                                      topRight: Radius.circular(25.0))),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(20.0),
                                        child: Text('Nota do aluno',
                                            style: TextStyles.blackTitleText),
                                      ),
                                      InputField(
                                        label: 'Nota',
                                        icon: Icons.padding,
                                        controller: notaController,
                                      ),
                                    ],
                                  ),
                                  Button(
                                      label: 'Enviar Tarefa',
                                      onPressed: () {
                                        db
                                            .collection('salas')
                                            .doc(widget
                                                .tarefaAluno.tarefa.codigoSala)
                                            .collection('tarefas')
                                            .doc(widget.tarefaAluno.tarefa.nome)
                                            .collection('entregues')
                                            .doc(widget.tarefaAluno.email)
                                            .update({
                                          'nota': int.parse(notaController.text)
                                        });
                                        db
                                            .collection('usuarios')
                                            .doc(widget.tarefaAluno.email)
                                            .update({
                                          'xp': FieldValue.increment(100)
                                        });
                                        Navigator.popUntil(context,
                                            ModalRoute.withName('/sala'));
                                      })
                                ],
                              ),
                            );
                          }));
                }),
          ),
        ));
  }
}
