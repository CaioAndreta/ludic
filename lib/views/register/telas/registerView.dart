import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ludic/shared/auth/auth_controller.dart';
import 'package:ludic/shared/themes/app_textstyles.dart';
import 'package:ludic/shared/widgets/button.dart';
import 'package:ludic/shared/widgets/inputField.dart';
import 'package:ludic/shared/widgets/passwordInput.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    TextEditingController _nameController = TextEditingController();
    return Center(
      child: SingleChildScrollView(
        reverse: true,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text('REGISTRAR NOVA CONTA',
                      style: TextStyles.primaryTitleText)),
              InputField(
                label: 'Nome',
                icon: Icons.person,
                controller: _nameController,
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
                label: 'Email',
                icon: Icons.mail,
                controller: _emailController,
                validator: (email) {
                  if ((email!.isEmpty)) {
                    return 'Insira um email';
                  } else if (!EmailValidator.validate(email)) {
                    return 'Email Inv??lido';
                  }
                  return null;
                },
              ),
              InputPassword(
                label: 'Senha',
                icon: Icons.lock,
                controller: _passwordController,
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
                  onPressed: () {
                    final authController = AuthController();
                    if (_formKey.currentState!.validate())
                      authController.userRegister(context,
                          email: _emailController.text,
                          password: _passwordController.text,
                          name: _nameController.text);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}