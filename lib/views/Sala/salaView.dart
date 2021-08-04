import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ludic/shared/models/sala_model.dart';
import 'package:ludic/shared/themes/app_colors.dart';
import 'package:ludic/shared/themes/app_textstyles.dart';
import 'package:ludic/views/Sala/telas/teacherView.dart';
import 'package:ludic/views/Sala/telas/teste.dart';

class SalaView extends StatelessWidget {
  const SalaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sala = ModalRoute.of(context)!.settings.arguments as Sala;
    final db = FirebaseFirestore.instance;
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(backgroundColor: AppColors.secondaryDark),
      body: Testezada(),
    );
  }
}
