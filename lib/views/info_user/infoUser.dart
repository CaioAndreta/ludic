import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ludic/shared/level/level_controller.dart';
import 'package:ludic/shared/models/user_model.dart';
import 'package:ludic/shared/themes/app_colors.dart';
import 'package:ludic/shared/themes/app_textstyles.dart';

class InfoUser extends StatelessWidget {
  const InfoUser({
    Key? key,
    required this.userMail,
  }) : super(key: key);

  final String userMail;

  @override
  Widget build(BuildContext context) {
    LevelController levelController = LevelController();
    var db = FirebaseFirestore.instance;

    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<DocumentSnapshot>(
          future: db.collection('usuarios').doc(userMail).get(),
          builder: (_, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            var xpUser = snapshot.data!['xp'];
            num lvl = levelController.getLevel(xpUser);
            num xpNivel = 500 + (lvl - 1) * 100;
            num xpUserLevel = xpUser - (50 * (pow(lvl - 1, 2) + 9 * (lvl - 1)));
            return Container(
              color: AppColors.secondary,
              height: double.infinity,
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    height: 200,
                    child: Column(
                      children: [
                        Expanded(
                            child: Container(
                              child: CircleAvatar(
                                radius: 30.0,
                                backgroundImage:
                                    AssetImage('assets/profile.png'),
                                backgroundColor: Color(0xFFebe6d6),
                              ),
                              width: double.infinity,
                            ),
                            flex: 3),
                        Expanded(
                          child: Container(
                              width: double.infinity,
                              child: Center(
                                child: Text('${snapshot.data!['nome']}',
                                    style: TextStyles.blackHintText),
                              )),
                          flex: 1,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 30),
                        child: LinearProgressIndicator(
                          backgroundColor: AppColors.secondaryDark,
                          color: AppColors.primary,
                          minHeight: 10,
                          value: xpUserLevel / xpNivel,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 30),
                              padding: EdgeInsets.only(bottom: 30),
                              child: Text(
                                'Nível $lvl',
                                style: TextStyles.blackHintText,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 30),
                              padding: EdgeInsets.only(bottom: 30),
                              child: Text(
                                '$xpUserLevel/$xpNivel XP',
                                style: TextStyles.blackHintText,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Container(
                      //   margin: EdgeInsets.all(10),
                      //   height: 150,
                      //   width: double.infinity,
                      //   child: ClipRRect(
                      //     borderRadius: BorderRadius.circular(15),
                      //     child: Card(
                      //       child: Container(
                      //         color: AppColors.secondaryDark,
                      //         height: double.infinity,
                      //         width: double.infinity,
                      //         child: Container(
                      //           padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      //           child: ListTile(
                      //             title: Text('Conquistas',
                      //                 style: TextStyles.primaryHintText),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // Container(
                      //   height: 200,
                      //   child: ListView(
                      //     shrinkWrap: true,
                      //     scrollDirection: Axis.horizontal,
                      //     children: List.generate(10, (int index) {
                      //       return Card(
                      //         color: Colors.blue[index * 100],
                      //         child: Container(
                      //           width: 50.0,
                      //           height: 50.0,
                      //           child: Text("$index"),
                      //         ),
                      //       );
                      //     }),
                      //   ),
                      // ),
                    ],
                  )
                ],
              ),
            );
          }),
    );
  }
}
