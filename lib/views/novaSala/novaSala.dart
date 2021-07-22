import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ludic/shared/themes/app_colors.dart';
import 'package:ludic/views/novaSala/novaSalaController.dart';
import 'package:ludic/views/novaSala/telas/1_nomeSala.dart';
import 'package:ludic/views/novaSala/telas/2_addTarefas.dart';
import 'package:ludic/views/novaSala/telas/3_codigoSala.dart';

class NovaSalaView extends StatefulWidget {
  const NovaSalaView({Key? key}) : super(key: key);

  @override
  _NovaSalaViewState createState() => _NovaSalaViewState();
}

class _NovaSalaViewState extends State<NovaSalaView> {
  var novaSalaController = NovaSalaController();
  final pages = [NomeSalaView(), AddTarefasView(), CodigoSalaView()];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: AppColors.primary,
        appBar: AppBar(
          iconTheme: IconThemeData(color: AppColors.background),
        ),
        body: pages[novaSalaController.currentPage],
        bottomNavigationBar: Container(
          width: size.width * 0.8,
          decoration: BoxDecoration(
            color: AppColors.background,
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
                novaSalaController.setPage(1);
                setState(() {});
              }),
        ));
  }
}
