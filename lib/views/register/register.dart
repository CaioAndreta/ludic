import 'package:flutter/material.dart';
import 'package:ludic/shared/themes/app_colors.dart';
import 'package:ludic/views/register/telas/registerView.dart';

class Register extends StatefulWidget {
  const Register({
    Key? key,
  }) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.secondary,
        appBar: AppBar(),
        body: RegisterView());
  }
}
