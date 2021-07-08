import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ludic/shared/themes/app_textstyles.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _firestore = FirebaseFirestore.instance;
    return Scaffold(
        appBar: AppBar(),
        body: StreamBuilder<QuerySnapshot>(
            stream: _firestore.collection('salas').snapshots(),
            builder: (_, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                    heightFactor: double.infinity,
                    widthFactor: double.infinity,
                    child: CircularProgressIndicator());
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
                                  child: Center(
                                    child: Text(doc['nome'],
                                        style: TextStyles.hintText),
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
