import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ludic/shared/themes/app_colors.dart';
import 'package:ludic/shared/themes/app_textstyles.dart';
import 'package:ludic/shared/widgets/button.dart';
import 'package:ludic/shared/widgets/input_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                      Text('REGISTRAR NOVO ALUNO', style: TextStyles.purpleTitleText)),
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
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Insira um Nome';
                  } else if (value.length < 3) {
                    return 'O nome deve ter mais de 3 caracteres';
                  }
                  return null;
                },
              ),
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
                ),
                validator: (email) {
                  if ((email!.isEmpty)) {
                    return 'Insira um email';
                  } else if (!EmailValidator.validate(email)) {
                    return 'Email Inválido';
                  }
                  return null;
                },
              ),
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
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Insira uma senha';
                  } else if (value.length < 6) {
                    return 'A senha deve ter mais de 6 caracteres';
                  }
                  return null;
                },
              ),
              Button(
                  label: 'Registrar',
                  onPressed: () async {
                    auth.createUserWithEmailAndPassword(
                        email: _emailController.text,
                        password: _passwordController.text);
                        SharedPreferences preferences = await SharedPreferences.getInstance();
                    preferences.setString('email', _emailController.text);
                    preferences.setString('name', auth.currentUser!.displayName!.toUpperCase().toString());
                    Navigator.of(context).pushReplacementNamed('/home');
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
