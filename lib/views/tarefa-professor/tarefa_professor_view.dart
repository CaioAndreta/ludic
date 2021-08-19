import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:ludic/shared/models/firebaseFile.dart';
import 'package:ludic/shared/models/tarefa_model.dart';
import 'package:ludic/shared/themes/app_colors.dart';
import 'package:ludic/views/tarefa-professor/widgets/enviarTarefaButton.dart';
import 'package:ludic/views/tarefa-professor/widgets/tarefaDetalhes.dart';

class TarefaProfessor extends StatefulWidget {
  const TarefaProfessor({Key? key, required this.tarefa}) : super(key: key);
  final Tarefa tarefa;

  @override
  State<TarefaProfessor> createState() => _TarefaProfessorState();
}

class _TarefaProfessorState extends State<TarefaProfessor> {
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
    futureFiles = listAll(widget.tarefa.path);
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
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            color: AppColors.secondary,
            itemBuilder: (_) => [
              PopupMenuItem(
                  child: ListTile(
                      leading: Icon(Icons.delete, color: AppColors.delete),
                      title: Text('Apagar',
                          style: TextStyle(color: AppColors.delete)),
                      onTap: () {
                        deleteTarefa(widget.tarefa.nome, widget.tarefa.path);
                        Navigator.popUntil(
                            context, ModalRoute.withName('/sala'));
                      })),
            ],
          )
        ],
      ),
      body: TarefaDetalhes(futureFiles: futureFiles, widget: widget),
      bottomNavigationBar:
          EnviarTarefaButton(size: size, db: db, widget: widget),
    );
  }
}
