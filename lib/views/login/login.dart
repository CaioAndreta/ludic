import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ludic/shared/auth/auth_controller.dart';
import 'package:ludic/shared/themes/app_colors.dart';
import 'package:ludic/shared/themes/app_textstyles.dart';
import 'package:ludic/shared/widgets/button.dart';
import 'package:ludic/shared/widgets/inputField.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          reverse: true,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text('LOGIN', style: TextStyles.primaryTitleText)),
                InputField(
                  label: 'Email',
                  icon: Icons.mail,
                  controller: _emailController,
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
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: IconButton(
                        icon: Icon(Icons.visibility, color: AppColors.primary),
                        onPressed: () {}),
                  ),
                  icon: Icons.lock,
                  label: 'Senha',
                  controller: _passwordController,
                  obscureText: true,
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
                  label: 'Login',
                  onPressed: () {
                    final form = _formKey.currentState!;
                    if (form.validate()) {
                      final authController = AuthController();
                      authController.userLogin(context, _emailController.text.trim(),
                          _passwordController.text);
                    }
                  },
                ),
                Center(
                  child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      width: size.width * 0.8,
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Não tem uma conta?',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16)),
                          GestureDetector(
                            child: Text(
                              ' Cadastre-se',
                              style: TextStyle(
                                  color: AppColors.primary, fontSize: 16),
                            ),
                            onTap: () => {
                              Navigator.of(context)
                                  .pushNamed('/escolher-registro')
                            },
                          )
                        ],
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
