import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:ludic/shared/models/sala_model.dart';
import 'package:ludic/shared/themes/app_colors.dart';
import 'package:ludic/shared/themes/app_textstyles.dart';
import 'package:ludic/shared/widgets/button.dart';
import 'package:ludic/shared/widgets/inputField.dart';
import 'package:file_picker/file_picker.dart';
import 'package:ludic/views/Sala/telas/listaAlunos.dart';
import 'package:ludic/views/Sala/telas/listaTarefas.dart';
import 'package:path/path.dart';

class SalaView extends StatefulWidget {
  const SalaView({Key? key}) : super(key: key);

  @override
  _SalaViewState createState() => _SalaViewState();
}

class _SalaViewState extends State<SalaView> {
  List tarefas = [];
  File? file;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descController = TextEditingController();
  UploadTask? task;
  @override
  Widget build(BuildContext context) {
    final sala = ModalRoute.of(context)!.settings.arguments as Sala;
    final db = FirebaseFirestore.instance;
    final size = MediaQuery.of(context).size;
    addTarefa(String name, String desc) {
      tarefas.add({
        'nome': name,
        'descricao': desc,
      });
      tarefas.forEach((element) {
        db
            .collection('salas')
            .doc(sala.codigo)
            .collection('tarefas')
            .doc(element['nome'])
            .set({'nome': element['nome'], 'descricao': element['descricao']});
        setState(() {});
      });
    }

    uploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
          stream: task.snapshotEvents,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final snap = snapshot.data!;
              final progress = snap.bytesTransferred / snap.totalBytes;
              final percentage = (progress * 100).toStringAsFixed(2);
              return Text('$percentage%', style: TextStyles.blackHintText);
            } else {
              return Container();
            }
          },
        );

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.secondary,
        appBar: AppBar(),
        body: TabBarView(children: [
          Scaffold(
            backgroundColor: AppColors.secondaryDark,
            floatingActionButton: ElevatedButton(
              child: Icon(Icons.add, color: AppColors.secondary),
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(20),
                primary: AppColors.primary,
              ),
              onPressed: () {
                final _formKey = GlobalKey<FormState>();
                _descController = TextEditingController();
                _nameController = TextEditingController();
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => StatefulBuilder(builder:
                            (BuildContext context, StateSetter setModalState) {
                          final fileName = file != null
                              ? basename(file!.path)
                              : 'Nenhum arquivo selecionado';
                          Future selectFile() async {
                            final result =
                                await FilePicker.platform.pickFiles();
                            if (result == null) return;
                            final path = result.files.single.path!;
                            setModalState(() {
                              file = File(path);
                            });
                          }

                          UploadTask? dbUpload(String destination, File file) {
                            try {
                              final ref =
                                  FirebaseStorage.instance.ref(destination);
                              return ref.putFile(file);
                            } on FirebaseException catch (e) {
                              return null;
                            }
                          }

                          Future uploadFile() async {
                            if (file == null) return;
                            final fileName = basename(file!.path);
                            final destination = '${sala.codigo}/$fileName';
                            task = dbUpload(destination, file!);
                            setModalState(() {});
                            if (task == null) return;
                            final snapshot = await task!.whenComplete(() => {});
                            final urlDownload =
                                await snapshot.ref.getDownloadURL();
                            print(urlDownload);
                          }

                          return Container(
                            height: size.height * 0.8,
                            decoration: BoxDecoration(
                                color: AppColors.secondaryDark,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(25.0),
                                    topRight: Radius.circular(25.0))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(20.0),
                                        child: Text(
                                            'Insira as informações da tarefa',
                                            style: TextStyles.blackTitleText),
                                      ),
                                      InputField(
                                          validator: (value) {
                                            if (value.length < 4) {
                                              return 'Insira um nome de pelo menos 4 caracteres';
                                            }
                                            return null;
                                          },
                                          icon: Icons.tag,
                                          label: 'Nome',
                                          controller: _nameController),
                                      InputField(
                                        label: 'Descrição',
                                        icon: Icons.text_snippet,
                                        controller: _descController,
                                      ),
                                      Column(
                                        children: [
                                          Button(
                                            label: 'Selecione o Arquivo',
                                            onPressed: selectFile,
                                          ),
                                          Text(fileName,
                                              style: TextStyles.blackHintText),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                task != null
                                    ? uploadStatus(task!)
                                    : Container(),
                                Button(
                                  label: 'Adicionar',
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      addTarefa(_nameController.text,
                                          _descController.text);
                                      await uploadFile();
                                      Navigator.pop(context);
                                    }
                                  },
                                )
                              ],
                            ),
                          );
                        }));
              },
            ),
            body: Form(
              child: ListaTarefas(db: db, sala: sala),
            ),
          ),
          ListaAlunos(db: db, sala: sala),
        ]),
        bottomNavigationBar: Material(
          color: AppColors.secondaryDark,
          child: TabBar(
            indicator: UnderlineTabIndicator(
                borderSide: BorderSide(width: 3, color: AppColors.primary),
                insets: EdgeInsets.symmetric(horizontal: 16.0)),
            indicatorColor: AppColors.primary,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Container(
                  height: size.height * 0.1,
                  child: Center(
                      child:
                          Text('Tarefas', style: TextStyles.primaryTitleText))),
              Container(
                  height: size.height * 0.1,
                  child: Center(
                      child: Text('Sala', style: TextStyles.primaryTitleText))),
            ],
          ),
        ),
      ),
    );
  }
}

