import 'package:flutter/material.dart';
import 'package:ludic/shared/themes/app_colors.dart';
import 'package:ludic/views/register/telas/registerAluno.dart';
import 'package:ludic/views/register/registerController.dart';
import 'package:ludic/views/register/telas/registerProf.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({
    Key? key,
  }) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(),
      body: RegisterController.isTeacher == false
          ? RegisterAlunoView()
          : RegisterProfView(),
    );
  }
}
