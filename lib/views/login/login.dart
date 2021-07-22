import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ludic/shared/auth/auth_controller.dart';
import 'package:ludic/shared/themes/app_colors.dart';
import 'package:ludic/shared/themes/app_textstyles.dart';
import 'package:ludic/shared/widgets/button.dart';
import 'package:ludic/shared/widgets/input_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    var size = MediaQuery.of(context).size;

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
                  child: Text('LOGIN', style: TextStyles.purpleTitleText)),
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
                obscureText: _isObscure,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  labelStyle: TextStyles.purpleHintText,
                  icon: Icon(
                    Icons.lock,
                    color: AppColors.primary,
                  ),
                  suffixIcon: IconButton(
                      icon: Icon(
                        _isObscure ? Icons.visibility : Icons.visibility_off,
                        color: AppColors.primary,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      }),
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
                label: 'Login',
                onPressed: () {
                  AuthController.userLogin(context,
                      _emailController.text.trim(), _passwordController.text);
                },
              ),
              Center(
                child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    width: size.width * 0.8,
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
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
    );
  }
}
