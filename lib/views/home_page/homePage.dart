import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
  String email = '';
  String name = '';
  Future getEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      email = preferences.getString('email')!;
    });
  }

  @override
  void initState() {
    super.initState();
    getEmail();
  }

  @override
  Widget build(BuildContext context) {
    final _firestore = FirebaseFirestore.instance;
    return Scaffold(
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
              preferences.remove('email');
            },
          ),
        ),
        appBar: AppBar(actions: [
          PopupMenuButton(
            icon: Icon(Icons.add),
            itemBuilder: (_) => [
              PopupMenuItem(
                  child: ListTile(
                      onTap: () {
                        Navigator.of(context)
                            .pushReplacementNamed('/nova-sala');
                      },
                      title: Text('Criar uma Sala de Aula'))),
              PopupMenuItem(
                  child: ListTile(
                      onTap: () {}, title: Text('Entrar em uma Sala de Aula')))
            ],
          )
        ]),
        body: StreamBuilder<QuerySnapshot>(
            stream: _firestore.collection('salas').orderBy('nome').snapshots(),
            builder: (_, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                    heightFactor: double.infinity,
                    widthFactor: double.infinity,
                    child: CircularProgressIndicator(color: AppColors.primary));
              }
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (_, index) {
                    var doc = snapshot.data!.docs[index];
                    return Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      height: 220,
                      width: double.infinity,
                      child: GestureDetector(
                        onTap: () {},
                        child: Card(
                          elevation: 5,
                          child: Container(
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
                                            style: TextStyles.purpleHintText),
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
            }));
  }
}
