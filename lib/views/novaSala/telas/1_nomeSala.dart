import 'package:flutter/material.dart';
import 'package:ludic/shared/themes/app_colors.dart';
import 'package:ludic/shared/themes/app_textstyles.dart';

class NomeSalaView extends StatefulWidget {
  TextEditingController? controller;
  NomeSalaView({Key? key, this.controller}) : super(key: key);

  @override
  _NomeSalaViewState createState() => _NomeSalaViewState();
}

class _NomeSalaViewState extends State<NomeSalaView> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(height: size.height * 0.15),
          Text('Digite um nome para a sala de aula',
              style: TextStyles.secondaryTitleText),
          Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              width: size.width * 0.8,
              child: TextFormField(
                  controller: widget.controller,
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
    );
  }
}
