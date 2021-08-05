import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ludic/shared/models/sala_model.dart';
import 'package:ludic/shared/themes/app_colors.dart';
import 'package:ludic/shared/themes/app_textstyles.dart';
import 'package:ludic/shared/widgets/button.dart';
import 'package:ludic/shared/widgets/inputField.dart';

class SalaView extends StatefulWidget {
  const SalaView({Key? key}) : super(key: key);

  @override
  _SalaViewState createState() => _SalaViewState();
}

class _SalaViewState extends State<SalaView> {
  List tarefas = [];
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final sala = ModalRoute.of(context)!.settings.arguments as Sala;
    final db = FirebaseFirestore.instance;
    var size = MediaQuery.of(context).size;
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

    deleteTarefa(tarNome) {
      db
          .collection('salas')
          .doc(sala.codigo)
          .collection('tarefas')
          .doc(tarNome)
          .delete();
      setState(() {});
    }

    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: AppColors.secondaryDark,
          appBar: AppBar(),
          body: TabBarView(children: [
            Form(
              child: StreamBuilder(
                  stream: db
                      .collection('salas')
                      .doc(sala.codigo)
                      .collection('tarefas')
                      .snapshots(),
                  builder: (_, AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                          child: CircularProgressIndicator(
                              color: AppColors.primary));
                    }
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (_, index) {
                          var doc = snapshot.data!.docs[index];
                          return Container(
                            padding: EdgeInsets.fromLTRB(5, 8, 5, 8),
                            width: double.infinity,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Container(
                                color: AppColors.secondary,
                                child: ListTile(
                                  trailing: PopupMenuButton(
                                    color: AppColors.secondary,
                                    itemBuilder: (_) => [
                                      PopupMenuItem(
                                          child: ListTile(
                                              leading: Icon(Icons.delete,
                                                  color: AppColors.delete),
                                              title: Text('Apagar',
                                                  style: TextStyle(
                                                      color: AppColors.delete)),
                                              onTap: () {
                                                deleteTarefa(doc['nome']);
                                                Navigator.pop(context);
                                              })),
                                    ],
                                  ),
                                  title: Text(doc['nome'],
                                      style: TextStyles.blackTitleText),
                                  subtitle: Text(doc['descricao'],
                                      style: TextStyles.blackHintText),
                                ),
                              ),
                            ),
                          );
                        });
                  }),
            ),
            StreamBuilder<QuerySnapshot>(
                stream: db
                    .collection('salas')
                    .doc(sala.codigo)
                    .collection('alunos')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (_, index) {
                        var doc = snapshot.data!.docs[index];
                        return ListTile(title: Text(doc['nome']));
                      });
                })
          ]),
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
                                ],
                              ),
                            ),
                            Button(
                              label: 'Adicionar',
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  addTarefa(_nameController.text,
                                      _descController.text);
                                  Navigator.pop(context);
                                }
                              },
                            )
                          ],
                        ),
                      ));
            },
          ),
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
                        child: Text('Tarefas',
                            style: TextStyles.primaryTitleText))),
                Container(
                    height: size.height * 0.1,
                    child: Center(
                        child:
                            Text('Sala', style: TextStyles.primaryTitleText))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
