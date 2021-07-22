import 'package:flutter/material.dart';
import 'package:ludic/shared/themes/app_colors.dart';
import 'package:ludic/views/novaSala/novaSalaController.dart';

class NomeSalaView extends StatefulWidget {
  const NomeSalaView({Key? key}) : super(key: key);

  @override
  _NomeSalaViewState createState() => _NomeSalaViewState();
}

class _NomeSalaViewState extends State<NomeSalaView> {
  var novaSalaController = NovaSalaController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        height: size.height,
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(height: size.height * 0.15),
            Text('Digite um nome para a sala de aula'),
            Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                width: size.width * 0.8,
                child: TextFormField(
                    cursorColor: AppColors.background,
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.background),
                        ),
                        enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.background))))),
          ],
        ),
      ),
    );
  }
}
