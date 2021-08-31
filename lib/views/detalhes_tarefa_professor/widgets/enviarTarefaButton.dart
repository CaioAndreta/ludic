import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:ludic/shared/themes/app_colors.dart';
import 'package:ludic/shared/themes/app_textstyles.dart';
import 'package:ludic/shared/widgets/button.dart';
import 'package:ludic/shared/widgets/inputField.dart';
import 'package:ludic/views/detalhes_tarefa_professor/tarefa_professor_view.dart';
import 'package:path/path.dart';

class EnviarTarefaButton extends StatelessWidget {
  EnviarTarefaButton({
    Key? key,
    required this.size,
    required this.db,
    required this.widget,
  }) : super(key: key);

  final Size size;
  final FirebaseFirestore db;
  final TarefaProfessor widget;
  final auth = FirebaseAuth.instance;
  Map<String, bool> alunosId = {};
  UploadTask? task;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              'Enviar tarefa aos alunos',
              style: TextStyle(color: AppColors.secondary),
            ),
            onPressed: () {
              DateTime selectedDate = DateTime.now();
              File? file;
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
                          final result = await FilePicker.platform.pickFiles();
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
                          final destination =
                              '${widget.tarefa.codigoSala}/${widget.tarefa.nome}/$fileName';
                          task = dbUpload(destination, file!);
                          setModalState(() {});
                          if (task == null) return;
                        }

                        Future<void> _selectDate(BuildContext context) async {
                          final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: selectedDate,
                              firstDate: DateTime(2015, 8),
                              lastDate: DateTime(2101));
                          if (picked != null && picked != selectedDate)
                            setModalState(() {
                              selectedDate = picked;
                            });
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
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(20.0),
                                    child: Text('Enviar a tarefa',
                                        style: TextStyles.blackTitleText),
                                  ),
                                  InputField(
                                    label: 'Peso',
                                    icon: Icons.padding,
                                  ),
                                  Column(
                                    children: [
                                      Text('Data de Envio:',
                                          style: TextStyles.primaryHintText),
                                      Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 10),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 5),
                                        width: size.width * 0.8,
                                        decoration: BoxDecoration(
                                            color: AppColors.secondary,
                                            borderRadius:
                                                BorderRadius.circular(29),
                                            border: Border.all(
                                                color: AppColors.primary)),
                                        child: TextButton(
                                          style: TextButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          18.0)),
                                              primary: AppColors.primary),
                                          onPressed: () {
                                            _selectDate(context);
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                                              style:
                                                  TextStyles.primaryCodigoSala,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Button(
                                            label: 'Selecione o Arquivo',
                                            onPressed: selectFile,
                                          ),
                                          Text('$fileName',
                                              style: TextStyles.blackHintText),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                              Button(
                                  label: 'Enviar Tarefa',
                                  onPressed: () async {
                                    await uploadFile();
                                    db.collection('salas')
                                      ..doc(widget.tarefa.codigoSala)
                                          .collection('alunos')
                                          .get()
                                          .then((querySnapshot) => {
                                                querySnapshot.docs
                                                    .forEach((doc) {
                                                  alunosId[doc.get('id')] =
                                                      false;
                                                })
                                              })
                                          .then((value) => db
                                                  .collection('salas')
                                                  .doc(widget.tarefa.codigoSala)
                                                  .collection('tarefas')
                                                  .doc(widget.tarefa.nome)
                                                  .update({
                                                'data de conclusao':
                                                    selectedDate.toLocal(),
                                                'entregues': alunosId
                                              }));

                                    Navigator.popUntil(
                                        context, ModalRoute.withName('/sala'));
                                  })
                            ],
                          ),
                        );
                      }));
            }),
      ),
    );
  }
}
