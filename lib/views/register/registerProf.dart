import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ludic/shared/auth/auth_controller.dart';
import 'package:ludic/shared/models/user_model.dart';
import 'package:ludic/shared/themes/app_colors.dart';
import 'package:ludic/shared/themes/app_textstyles.dart';
import 'package:ludic/shared/widgets/button.dart';
import 'package:ludic/shared/widgets/input_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterProfView extends StatelessWidget {
  const RegisterProfView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    TextEditingController _nameController = TextEditingController();
    final auth = FirebaseAuth.instance;

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text('REGISTRAR NOVO PROFESSOR',
                      style: TextStyles.purpleTitleText)),
              InputField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Nome',
                    labelStyle: TextStyles.purpleHintText,
                    icon: Icon(
                      Icons.person,
                      color: AppColors.primary,
                    ),
                    border: InputBorder.none,
                  )),
              InputField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyles.purpleHintText,
                    icon: Icon(
                      Icons.mail,
                      color: AppColors.primary,
                    ),
                    border: InputBorder.none,
                  )),
              InputField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    labelStyle: TextStyles.purpleHintText,
                    icon: Icon(
                      Icons.lock,
                      color: AppColors.primary,
                    ),
                    border: InputBorder.none,
                  )),
              Button(
                  label: 'Registrar',
                  onPressed: () {
                    AuthController.doSignUp(_nameController.text,
                        _emailController.text, _passwordController.text);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
