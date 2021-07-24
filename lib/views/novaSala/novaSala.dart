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
  int index = 0;
  var novaSalaController = NovaSalaController();
  final pages = [NomeSalaView(), AddTarefasView(), CodigoSalaView()];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: AppColors.primary,
        appBar: AppBar(
          iconTheme: IconThemeData(color: AppColors.secondary),
        ),
        body: IndexedStack(
          children: [NomeSalaView(), AddTarefasView(), CodigoSalaView()],
          index: index,
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
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
                  if (index < 2) {
                    index += 1;
                  } else {
                    ScaffoldMessenger.of(context)
                      ..removeCurrentSnackBar()
                      ..showSnackBar(SnackBar(
                        content: Text('Cadastro efetuado com sucesso!'),
                      ));
                  }
                  setState(() {});
                }),
          ),
        ));
  }
}
