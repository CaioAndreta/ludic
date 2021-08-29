import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:ludic/shared/models/firebaseFile.dart';
import 'package:ludic/shared/models/tarefa_model.dart';
import 'package:ludic/shared/themes/app_colors.dart';
import 'package:ludic/shared/themes/app_textstyles.dart';
import 'package:ludic/shared/widgets/button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path/path.dart';

class TarefaAlunoView extends StatefulWidget {
  TarefaAlunoView({Key? key, required this.tarefa}) : super(key: key);
  final Tarefa tarefa;

  @override
  State<TarefaAlunoView> createState() => _TarefaAlunoState();
}

class _TarefaAlunoState extends State<TarefaAlunoView> {
  UploadTask? task;
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  UploadTask? dbUpload(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);
      return ref.putFile(file);
    } on FirebaseException catch (e) {
      return null;
    }
  }

  Future uploadFile() async {
    if (file == null) return;
    final fileName = basename(file!.path);
    final destination =
        '${widget.tarefa.codigoSala}/${widget.tarefa.nome}/alunos/${auth.currentUser!.email}/$fileName';
    task = dbUpload(destination, file!);
    setState(() {});
    if (task == null) return;
  }

  File? file;

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
    futureFiles = listAll('${widget.tarefa.path}');
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    final path = result.files.single.path!;
    setState(() {
      file = File(path);
    });
  }

  @override
  Widget build(BuildContext context) {
    final fileName =
        file != null ? basename(file!.path) : 'Nenhum arquivo selecionado';

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
                      'Nome da tarefa:',
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
                    Text('Arquivos:', style: TextStyles.blackHintText),
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
                    ),
                    Text(
                      'Meu Trabalho:',
                      style: TextStyles.blackHintText,
                    ),
                    Column(
                      children: [
                        Button(
                          label: 'Selecione o Arquivo',
                          onPressed: selectFile,
                        ),
                        Text('$fileName', style: TextStyles.blackHintText),
                      ],
                    ),
                  ],
                ),
              );
            }),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(10),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(29),
            ),
            child: TextButton(
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                    primary: AppColors.primary),
                child: Text(
                  'Entregar Tarefa',
                  style: TextStyle(color: AppColors.secondary),
                ),
                onPressed: () async {
                  await uploadFile();
                  db
                      .collection('salas')
                      .doc(widget.tarefa.codigoSala)
                      .collection('tarefas')
                      .doc(widget.tarefa.nome)
                      .update({'entregues.${auth.currentUser!.uid}': true});
                  Navigator.pop(context);
                }),
          ),
        ));
  }
}
