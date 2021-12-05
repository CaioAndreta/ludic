import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:ludic/shared/models/sala_model.dart';
import 'package:ludic/shared/themes/app_colors.dart';
import 'package:ludic/shared/themes/app_textstyles.dart';
import 'package:ludic/shared/widgets/button.dart';
import 'package:ludic/shared/widgets/inputField.dart';
import 'package:file_picker/file_picker.dart';
import 'package:ludic/views/Sala/telas/listaTarefas.dart';
import 'package:ludic/views/sala/telas/scoreboard.dart';
import 'package:ludic/views/sala/telas/tarefasEntreguesAluno.dart';
import 'package:ludic/views/sala/telas/tarefasEnviadasProf.dart';
import 'package:path/path.dart';

class SalaView extends StatefulWidget {
  const SalaView({Key? key}) : super(key: key);

  @override
  _SalaViewState createState() => _SalaViewState();
}

class _SalaViewState extends State<SalaView> {
  List tarefas = [];
  UploadTask? task;
  @override
  Widget build(BuildContext context) {
    final sala = ModalRoute.of(context)!.settings.arguments as Sala;
    final db = FirebaseFirestore.instance;
    final auth = FirebaseAuth.instance;
    final size = MediaQuery.of(context).size;
    addTarefa(String name, String desc) {
      tarefas.add({'nome': name, 'descricao': desc});
      tarefas.forEach((element) {
        db
            .collection('salas')
            .doc(sala.codigo)
            .collection('tarefas')
            .doc(element['nome'])
            .set({
          'nome': element['nome'],
          'descricao': element['descricao'],
          'enviada': false
        });
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

    if (sala.isTeacher == true) {
      return DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: AppColors.secondary,
          appBar: AppBar(
            actions: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed('/info-sala', arguments: sala);
                  },
                  icon: Icon(Icons.info_outline),
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
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
                onPressed: () async {
                  File? file;
                  final _formKey = GlobalKey<FormState>();
                  TextEditingController _nameController =
                      TextEditingController();
                  TextEditingController _descController =
                      TextEditingController();
                  await addTarefaBottomSheet(
                      context,
                      file,
                      sala,
                      _nameController,
                      size,
                      _formKey,
                      _descController,
                      uploadStatus,
                      addTarefa);
                },
              ),
              body: Form(
                child: ListaTarefas(db: db, sala: sala),
              ),
            ),
            TarefasEnviadasProf(auth: auth, db: db, sala: sala),
            Scoreboard(sala: sala, db: db),
          ]),
          bottomNavigationBar: Material(
            color: AppColors.secondary,
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.description_outlined,
                            color: AppColors.primary),
                        Text('Tarefas', style: TextStyles.primaryHintText)
                      ],
                    )),
                Container(
                    height: size.height * 0.1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.task_outlined, color: AppColors.primary),
                        Text('Corrigir Tarefas',
                            style: TextStyles.primaryHintText)
                      ],
                    )),
                Container(
                    height: size.height * 0.1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.score_outlined, color: AppColors.primary),
                        Text('Scoreboard', style: TextStyles.primaryHintText)
                      ],
                    )),
              ],
            ),
          ),
        ),
      );
    } else {
      return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: AppColors.secondary,
          appBar: AppBar(
            actions: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed('/info-sala', arguments: sala);
                  },
                  icon: Icon(Icons.info_outline),
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          body: TabBarView(children: [
            TarefasEntreguesAluno(auth: auth, sala: sala, db: db),
            Scoreboard(sala: sala, db: db),
          ]),
          bottomNavigationBar: Material(
            color: AppColors.secondary,
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.description, color: AppColors.primary),
                        Text('Tarefas', style: TextStyles.primaryHintText)
                      ],
                    )),
                Container(
                    height: size.height * 0.1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.score_outlined, color: AppColors.primary),
                        Text('Placar de Pontos',
                            style: TextStyles.primaryHintText)
                      ],
                    ))
              ],
            ),
          ),
        ),
      );
    }
  }

  addTarefaBottomSheet(
      BuildContext context,
      File? file,
      Sala sala,
      TextEditingController _nameController,
      Size size,
      GlobalKey<FormState> _formKey,
      TextEditingController _descController,
      StreamBuilder<TaskSnapshot> uploadStatus(UploadTask task),
      Null addTarefa(String name, String desc)) async {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => StatefulBuilder(
                builder: (BuildContext context, StateSetter setModalState) {
              final fileName = file != null
                  ? basename(file!.path)
                  : 'Nenhum arquivo selecionado';
              Future selectFile() async {
                final result = await FilePicker.platform.pickFiles();
                if (result == null) return;
                final path = result.files.single.path!;
                setModalState(() {
                  file = File(path);
                });
              }

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
                    '${sala.codigo}/${_nameController.text}/$fileName';
                task = dbUpload(destination, file!);
                setModalState(() {});
                if (task == null) return;
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
                            child: Text('Insira as informações da tarefa',
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
                        ],
                      ),
                    ),
                    task != null ? uploadStatus(task!) : Container(),
                    Button(
                      label: 'Adicionar',
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          addTarefa(_nameController.text, _descController.text);
                          Navigator.pop(context);
                        }
                      },
                    )
                  ],
                ),
              );
            }));
  }
}
