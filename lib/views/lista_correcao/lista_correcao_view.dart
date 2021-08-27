import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:ludic/shared/models/firebaseFile.dart';
import 'package:ludic/shared/models/tarefa_model.dart';
import 'package:ludic/shared/themes/app_colors.dart';

class ListaCorrecao extends StatefulWidget {
  const ListaCorrecao({Key? key, required this.tarefa}) : super(key: key);

  final Tarefa tarefa;

  @override
  State<ListaCorrecao> createState() => _ListaCorrecaoState();
}

class _ListaCorrecaoState extends State<ListaCorrecao> {
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

  get fileName => null;

  @override
  void initState() {
    super.initState();

    var futureFiles = listAll('/8OZ7FO4/tarefa1/alunos/medonas@gmail.com');
  }

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    final ref = FirebaseStorage.instance
        .ref('/8OZ7FO4/tarefa1/alunos/medonas@gmail.com');
    getFiles() async {
      final result = await ref.listAll();
      return result;
    }

    final result = getFiles();

    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
        stream: db
            .collection('salas')
            .doc(widget.tarefa.codigoSala)
            .collection('tarefas')
            .doc(widget.tarefa.nome)
            .collection('entregues')
            .snapshots(),
        builder: (_, AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: CircularProgressIndicator(color: AppColors.primary));
          }
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (_, index) {
                var doc = snapshot.data!.docs[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/corrigir-tarefa',
                        arguments: widget.tarefa);
                  },
                  child: Card(
                    child: ListTile(
                      title: Text(doc['aluno']),
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
