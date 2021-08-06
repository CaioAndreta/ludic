import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ludic/shared/models/sala_model.dart';
import 'package:ludic/shared/models/user_model.dart';
import 'package:ludic/shared/themes/app_colors.dart';
import 'package:ludic/shared/themes/app_textstyles.dart';
import 'package:ludic/shared/widgets/HomeDrawer.dart';

class HomePage extends StatefulWidget {
  final UserModel user;
  const HomePage({Key? key, required this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double appBarHeight = size.height * 0.09;
    final db = FirebaseFirestore.instance;
    var tarefas = db
        .collection('salas')
        .where('alunos', arrayContains: widget.user.email)
        .orderBy('nome')
        .snapshots();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: AppColors.secondary,
          key: scaffoldKey,
          drawerEnableOpenDragGesture: true,
          drawer: HomeDrawer(userInfo: widget.user),
          appBar: AppBar(
              toolbarHeight: appBarHeight,
              title: Container(
                  height: appBarHeight * 0.45,
                  child: Image(image: AssetImage('assets/logo.png'))),
              actions: [
                PopupMenuButton(
                  color: AppColors.secondary,
                  icon: Icon(Icons.add),
                  itemBuilder: (_) => [
                    PopupMenuItem(
                        child: ListTile(
                            onTap: () {
                              Navigator.of(context).pushReplacementNamed(
                                  '/nova-sala',
                                  arguments: widget.user);
                            },
                            title: Text('Criar uma Sala de Aula',
                                style: TextStyles.primaryHintText))),
                    PopupMenuItem(
                        child: ListTile(
                            onTap: () {
                              Navigator.of(context).pushReplacementNamed(
                                  '/entrar-sala',
                                  arguments: widget.user);
                            },
                            title: Text('Entrar em uma Sala de Aula',
                                style: TextStyles.primaryHintText)))
                  ],
                ),
              ],
              bottom: TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.home, color: AppColors.primary)),
                  Tab(icon: Icon(Icons.person, color: AppColors.primary))
                ],
                indicatorColor: AppColors.primary,
              )),
          body: TabBarView(children: [
            StreamBuilder<QuerySnapshot>(
                stream: tarefas,
                builder: (_, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                        heightFactor: size.height,
                        widthFactor: size.width,
                        child: CircularProgressIndicator(
                            color: AppColors.primary));
                  }
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (_, index) {
                        var doc = snapshot.data!.docs[index];
                        return Container(
                          padding: EdgeInsets.all(5),
                          height: 300,
                          width: double.infinity,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: GestureDetector(
                              onTap: () {
                                Sala sala = Sala(
                                  codigo: doc['codigo'],
                                  nome: doc['nome'],
                                  professor: doc['professor'],
                                );
                                Navigator.of(context)
                                    .pushNamed('/sala', arguments: sala);
                              },
                              child: Container(
                                color: AppColors.primary,
                                height: double.infinity,
                                width: double.infinity,
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: ListTile(
                                    title: Text(doc['nome'],
                                        style:
                                            TextStyles.secondaryTxtCodigoSala),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                }),
            Container(
                height: size.height * 0.5,
                width: size.width * 0.5,
                color: Colors.red,
                child: Center(
                    child: Column(
                  children: [
                    Text('${widget.user.name}'),
                    Text('${widget.user.email}'),
                    Text('${widget.user.id}'),
                  ],
                ))),
          ])),
    );
  }
}
