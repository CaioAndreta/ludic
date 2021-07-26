import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ludic/shared/themes/app_colors.dart';
import 'package:ludic/shared/themes/app_textstyles.dart';

class EntrarSalaView extends StatefulWidget {
  const EntrarSalaView({Key? key}) : super(key: key);

  @override
  _EntrarSalaViewState createState() => _EntrarSalaViewState();
}

class _EntrarSalaViewState extends State<EntrarSalaView> {
  TextEditingController _codigoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var db = FirebaseFirestore.instance;
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(iconTheme: IconThemeData(color: AppColors.secondary)),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(height: size.height * 0.15),
            Text('Insira o código da sala de aula:',
                style: TextStyles.secondaryTitleText),
            Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                width: size.width * 0.8,
                child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: _codigoController,
                    cursorColor: AppColors.secondary,
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.secondary),
                        ),
                        enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.secondary))))),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Container(
            decoration: BoxDecoration(
              color: AppColors.secondary,
              borderRadius: BorderRadius.circular(29),
            ),
            margin: EdgeInsets.symmetric(vertical: 10),
            child: TextButton(
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                    primary: AppColors.primary),
                child: Text(
                  'Continuar',
                  style: TextStyle(color: AppColors.primary),
                ),
                onPressed: () {
                  if (db
                          .collection('salas')
                          .where('codigo', isEqualTo: _codigoController.text) == false) {
                    print('n bateu nenhum');
                  } else {
                    print('bateu');
                  }
                })),
      ),
    );
  }
}
