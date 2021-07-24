import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ludic/shared/themes/app_colors.dart';
import 'package:ludic/shared/themes/app_textstyles.dart';
import 'package:ludic/shared/widgets/button.dart';
import 'package:ludic/shared/widgets/input_field.dart';
import 'package:ludic/views/novaSala/novaSalaController.dart';

class AddTarefasView extends StatefulWidget {
  const AddTarefasView({Key? key}) : super(key: key);

  @override
  _AddTarefasViewState createState() => _AddTarefasViewState();
}

class _AddTarefasViewState extends State<AddTarefasView> {
  final novaSalaController = NovaSalaController();
  var selectedDate = DateTime.now();
  List tarefas = [];
  addTarefa(String name, String desc) {
    tarefas.add({
      'nome': name,
      'descricao': desc,
    });
    setState(() {});
  }

  deleteTarefa(int index) {
    tarefas.remove(tarefas[index]);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    TextEditingController _nameController = TextEditingController();
    TextEditingController _descController = TextEditingController();
    return Scaffold(
      backgroundColor: AppColors.primary,
      floatingActionButton: ElevatedButton(
        child: Icon(Icons.add, color: AppColors.primary),
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          padding: EdgeInsets.all(20),
          primary: AppColors.secondary,
        ),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) => Container(
                    height: size.height * 0.8,
                    decoration: BoxDecoration(
                        color: AppColors.secondary,
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
                              child: Text('Insira as informações da tarefa',
                                  style: TextStyles.blackTitleText),
                            ),
                            InputField(
                                controller: _nameController,
                                height: 70,
                                decoration: InputDecoration(
                                    labelText: 'Nome',
                                    labelStyle: TextStyles.primaryHintText,
                                    border: InputBorder.none)),
                            // InputField(
                            //     controller: _pesoController,
                            //     height: 70,
                            //     decoration: InputDecoration(
                            //         labelText: 'Peso',
                            //         labelStyle: TextStyles.primaryHintText,
                            //         border: InputBorder.none)),
                            InputField(
                                controller: _descController,
                                height: 120,
                                decoration: InputDecoration(
                                    labelText: 'Descrição',
                                    labelStyle: TextStyles.primaryHintText,
                                    border: InputBorder.none)),
                          ],
                        ),
                        Button(
                          label: 'Adicionar',
                          onPressed: () {
                            addTarefa(
                                _nameController.text, _descController.text);
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ),
                  ));
        },
      ),
      body: ListView(
        children: [
          Container(
            height: size.height * 0.1,
            child: Center(
              child: Text(
                'Adicione o seu planejamento de tarefas',
                style: TextStyles.secondaryTitleText,
              ),
            ),
          ),
          SingleChildScrollView(
            child: ListView.builder(
                physics: ScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: tarefas.length,
                itemBuilder: (_, index) {
                  return Column(
                    children: [
                      Card(
                        child: Container(
                          width: size.width,
                          height: 100,
                          color: AppColors.secondary,
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 10, 0, 0),
                                      child: Text(
                                          tarefas[index]['nome'].toString(),
                                          style: TextStyles.cardTitle),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 15, 0, 0),
                                    child: Text(
                                        tarefas[index]['descricao'].toString(),
                                        style: TextStyles.cardDesc),
                                  )
                                ],
                              ),
                              Expanded(child: Container()),
                              Align(
                                alignment: Alignment.topRight,
                                child: PopupMenuButton(
                                  itemBuilder: (_) => [
                                    PopupMenuItem(
                                        child: ListTile(
                                            leading: Icon(Icons.edit),
                                            title: Text('Editar'))),
                                    PopupMenuItem(
                                        child: ListTile(
                                            onTap: () => deleteTarefa(index),
                                            leading: Icon(Icons.delete,
                                                color: AppColors.delete),
                                            title: Text('Apagar',
                                                style: TextStyle(
                                                    color: AppColors.delete)))),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }
}
