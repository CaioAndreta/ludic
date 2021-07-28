import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ludic/shared/themes/app_colors.dart';
import 'package:ludic/shared/themes/app_textstyles.dart';
import 'package:ludic/shared/widgets/button.dart';
import 'package:ludic/shared/widgets/inputField.dart';

class AddTarefasView extends StatefulWidget {
  List tarefas;
  AddTarefasView({Key? key, required this.tarefas}) : super(key: key);

  @override
  _AddTarefasViewState createState() => _AddTarefasViewState();
}

class _AddTarefasViewState extends State<AddTarefasView> {
  var selectedDate = DateTime.now();
  addTarefa(String name, String desc) {
    widget.tarefas.add({
      'nome': name,
      'descricao': desc,
    });
    setState(() {});
  }

  deleteTarefa(int index) {
    widget.tarefas.remove(widget.tarefas[index]);
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
          final _formKey = GlobalKey<FormState>();
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
                                icon: Icons.description_outlined,
                                controller: _descController,
                              ),
                            ],
                          ),
                        ),
                        Button(
                          label: 'Adicionar',
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              addTarefa(
                                  _nameController.text, _descController.text);
                              Navigator.pop(context);
                            }
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
                itemCount: widget.tarefas.length,
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
                                          widget.tarefas[index]['nome']
                                              .toString(),
                                          style: TextStyles.cardTitle),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 15, 0, 0),
                                    child: Text(
                                        widget.tarefas[index]['descricao']
                                            .toString(),
                                        style: TextStyles.cardDesc),
                                  )
                                ],
                              ),
                              Expanded(child: Container()),
                              Align(
                                alignment: Alignment.topRight,
                                child: PopupMenuButton(
                                  color: AppColors.secondary,
                                  itemBuilder: (_) => [
                                    PopupMenuItem(
                                        child: ListTile(
                                            leading: Icon(Icons.edit,
                                                color: AppColors.primary),
                                            title: Text('Editar',
                                                style: TextStyles
                                                    .primaryHintText))),
                                    PopupMenuItem(
                                        child: ListTile(
                                            onTap: () {
                                              deleteTarefa(index);
                                              Navigator.pop(context);
                                            },
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
