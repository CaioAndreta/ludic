import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:ludic/shared/models/firebaseFile.dart';
import 'package:ludic/shared/models/tarefa_model.dart';
import 'package:ludic/shared/themes/app_colors.dart';
import 'package:ludic/shared/themes/app_textstyles.dart';
import 'package:url_launcher/url_launcher.dart';

class CorrigirTarefa extends StatefulWidget {
  const CorrigirTarefa({Key? key, required this.tarefa}) : super(key: key);
  final Tarefa tarefa;

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
    futureFiles = listAll('/8OZ7FO4/tarefa1/alunos/medonas@gmail.com');
  }

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    var size = MediaQuery.of(context).size;
    deleteTarefa(String? tarNome, String? tarPath) {
      db
          .collection('salas')
          .doc(widget.tarefa.codigoSala)
          .collection('tarefas')
          .doc(tarNome)
          .delete();
      // FirebaseStorage.instance.ref().delete();
    }

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
                        child: Text(widget.tarefa.nome,
                            style: TextStyles.blackTitleText)),
                    Text(
                      'Descrição da tarefa:',
                      style: TextStyles.blackHintText,
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        margin: EdgeInsets.only(bottom: 10),
                        child: Text('${widget.tarefa.descricao}',
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
            }));
  }
}
