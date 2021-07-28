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
  var showWidget = false;
  TextEditingController _codigoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var db = FirebaseFirestore.instance;
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(iconTheme: IconThemeData(color: AppColors.secondary)),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(height: size.height * 0.2),
            Text('Insira o código da sala de aula:',
                style: TextStyles.secondaryTitleText),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              width: size.width * 0.8,
              child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      showWidget = true;
                    });
                  },
                  style: TextStyle(color: Colors.white),
                  controller: _codigoController,
                  cursorColor: AppColors.secondary,
                  decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.secondary),
                      ),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.secondary)))),
            ),
            if (showWidget)
              Padding(
                padding: EdgeInsets.only(top: size.width * 0.15),
                child: StreamBuilder<QuerySnapshot>(
                    stream: db
                        .collection('salas')
                        .where('codigo', isEqualTo: _codigoController.text)
                        .snapshots(),
                    builder: (_, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.data!.docs.length == 0) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Não há uma sala com esse código.',
                                style: TextStyles.secondaryTitleText),
                            Text('Tente Novamente.',
                                style: TextStyles.secondaryTitleText),
                          ],
                        );
                      }
                      return Container(
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
                          border: Border.all(color: AppColors.secondary),
                          borderRadius: BorderRadius.circular(29),
                        ),
                        width: size.width * 0.8,
                        child: TextButton(
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 40),
                              primary: AppColors.secondary),
                          child: Text(
                            'Continuar',
                            style: TextStyle(color: AppColors.primary),
                          ),
                          onPressed: () {
                            Navigator.of(context).pushReplacementNamed('/home');
                          },
                        ),
                      );
                    }),
              )
            else
              Container(),
          ],
        ),
      ),
    );
  }
}
