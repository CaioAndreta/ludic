import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ludic/shared/auth/auth_controller.dart';
import 'package:ludic/shared/themes/app_colors.dart';
import 'package:ludic/shared/themes/app_textstyles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var authController = AuthController();
    final usuario = authController.getUser(context);
    var size = MediaQuery.of(context).size;
    final _firestore = FirebaseFirestore.instance;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: AppColors.secondary,
          key: scaffoldKey,
          drawerEnableOpenDragGesture: true,
          drawer: Drawer(
            child: ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Sair'),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/', (route) => false);
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                preferences.remove('user');
              },
            ),
          ),
          appBar: AppBar(
              title: Text('LUDIC', style: TextStyles.primaryTitleText),
              actions: [
                PopupMenuButton(
                  color: AppColors.secondary,
                  icon: Icon(Icons.add),
                  itemBuilder: (_) => [
                    PopupMenuItem(
                        child: ListTile(
                            onTap: () {
                              Navigator.of(context)
                                  .pushReplacementNamed('/nova-sala');
                            },
                            title: Text('Criar uma Sala de Aula',
                                style: TextStyles.primaryHintText))),
                    PopupMenuItem(
                        child: ListTile(
                            onTap: () {
                              Navigator.of(context)
                                  .pushReplacementNamed('/entrar-sala');
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
                stream: _firestore
                    .collection('salas')
                    // .where('alunos', arrayContains: userInfo.name)
                    .orderBy('nome')
                    .snapshots(),
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
                          padding: EdgeInsets.fromLTRB(5, 8, 5, 8),
                          height: 300,
                          color: AppColors.secondary,
                          width: double.infinity,
                          child: GestureDetector(
                            onTap: () {},
                            child: Card(
                              elevation: 8,
                              child: Container(
                                color: AppColors.secondary,
                                height: double.infinity,
                                width: double.infinity,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(height: 20),
                                    Container(
                                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      child: Column(
                                        children: [
                                          Center(
                                            child: Text(doc['nome'],
                                                style: TextStyles
                                                    .primaryTitleText),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
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
              child: Center(child: Text('s')),
            )
          ])),
    );
  }
}
