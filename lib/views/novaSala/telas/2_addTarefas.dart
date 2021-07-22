import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:short_uuids/short_uuids.dart';
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
  static const uuid = ShortUuid();
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
          addTarefa({
            'nome': 'nome 1',
            'descricao':
                'Loremi Loremi Loremi Loremi Loremi Loremi Loremi Loremi Loremi Loremi Loremi Loremi Loremi Loremi Loremi ',
            'data': DateFormat('dd/MM/yyyy').format(DateTime.now())
          });
          setState(() {});
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
                  return Stack(
                    children: [
                      Card(
                        child: Container(
                          height: size.height * 0.15,
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
                                padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                                child: Text(trabs[index]['uuid'].toString(),
                                    style: TextStyles.cardDesc),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                          top: 0,
                          right: 0,
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
                          )),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: Padding(
                          padding: EdgeInsets.all(7),
                          child: Text(trabs[index]['data'].toString(),
                              style: TextStyles.cardDate),
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
