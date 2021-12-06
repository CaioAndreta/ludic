import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ludic/shared/models/user_model.dart';
import 'package:ludic/shared/themes/app_textstyles.dart';
import 'package:ludic/shared/widgets/button.dart';
import 'package:ludic/shared/widgets/passwordInput.dart';

class UpdateUsuarioView extends StatelessWidget {
  UpdateUsuarioView({Key? key, required this.user}) : super(key: key);
  UserModel user;

  @override
  final _formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;
  Widget build(BuildContext context) {
    TextEditingController _passwordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
          child: Form(
        key: _formKey,
        child: Center(
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.symmetric(vertical: 50),
                  child: Text('Alterar Senha',
                      style: TextStyles.primaryTitleText)),
              InputPassword(
                label: 'Nova Senha',
                controller: _passwordController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Insira uma Senha';
                  } else if (value.length < 6) {
                    return 'A senha deve ter mais de 6 caracteres';
                  }
                  return null;
                },
              ),
              Button(
                  label: 'Alterar',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      auth.currentUser
                          ?.updatePassword(_passwordController.text);
                      Navigator.of(context).pop();
                    }
                  })
            ],
          ),
        ),
      )),
    );
  }
}
