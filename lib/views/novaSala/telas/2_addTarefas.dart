import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:ludic/shared/themes/app_colors.dart';
import 'package:ludic/shared/themes/app_textstyles.dart';
import 'package:ludic/views/novaSala/novaSalaController.dart';

class AddTarefasView extends StatefulWidget {
  const AddTarefasView({Key? key}) : super(key: key);

  @override
  _AddTarefasViewState createState() => _AddTarefasViewState();
}

class _AddTarefasViewState extends State<AddTarefasView> {
  addTar() {
    addTarefa({
      'nome': 'nome 1',
      'descricao': 'Lorem Ipsum ',
      'data': DateFormat('dd/MM/yyyy').format(DateTime.now())
    });
    setState(() {});
  }

  var trabs = [
    {
      'nome': 'nome 1',
      'descricao': 'descricao',
      'data': DateFormat("dd/MM/yyyy").format(DateTime.now()),
      'uuid': UniqueKey()
    },
  ];
  addTarefa(var map) {
    trabs.add(map);
    setState(() {});
  }

  deleteTarefa(int index) {
    trabs.remove(trabs[index]);
    setState(() {});
  }

  final novaSalaController = NovaSalaController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.primary,
      floatingActionButton: ElevatedButton(
        child: Icon(Icons.add, color: AppColors.primary),
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          padding: EdgeInsets.all(20),
          primary: AppColors.background,
        ),
        onPressed: () {
          addTar();
        },
      ),
      body: Container(
        height: size.height,
        width: size.width,
        child: ListView(
          children: [
            Container(
              height: size.height * 0.1,
              child: Center(
                child: Text(
                  'Adicione o seu planejamento de tarefas',
                  style: TextStyles.whiteTitleText,
                ),
              ),
            ),
            SingleChildScrollView(
              child: ListView.builder(
                physics: ScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: trabs.length,
                itemBuilder: (_, index) {
                  return Column(
                    children: [
                      Card(
                        child: Container(
                          width: size.width,
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                                child: Text(trabs[index]['nome'].toString(),
                                    style: TextStyles.cardTitle),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                                child: Text(
                                    trabs[index]['descricao'].toString(),
                                    style: TextStyles.cardDesc),
                              ),
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
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Padding(
                                  padding: EdgeInsets.all(7),
                                  child: Text(trabs[index]['data'].toString(),
                                      style: TextStyles.cardDate),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
