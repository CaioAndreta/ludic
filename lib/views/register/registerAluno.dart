import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ludic/shared/themes/app_colors.dart';
import 'package:ludic/shared/themes/app_textstyles.dart';
import 'package:ludic/shared/widgets/button.dart';
import 'package:ludic/shared/widgets/input_field.dart';

class RegisterAlunoView extends StatelessWidget {
  const RegisterAlunoView({Key? key}) : super(key: key);

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
                  child:
                      Text('REGISTRAR NOVO ALUNO', style: TextStyles.title1)),
              InputField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Nome',
                    labelStyle: TextStyles.hintText,
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
                    labelStyle: TextStyles.hintText,
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
                    labelStyle: TextStyles.hintText,
                    icon: Icon(
                      Icons.lock,
                      color: AppColors.primary,
                    ),
                    border: InputBorder.none,
                  )),
              Button(
                  label: 'Registrar',
                  onPressed: () {
                    auth.createUserWithEmailAndPassword(
                        email: _emailController.text,
                        password: _passwordController.text);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
