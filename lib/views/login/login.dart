import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ludic/shared/auth/auth_controller.dart';
import 'package:ludic/shared/themes/app_colors.dart';
import 'package:ludic/shared/themes/app_textstyles.dart';
import 'package:ludic/shared/widgets/button.dart';
import 'package:ludic/shared/widgets/input_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

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
                  child: Text('LOGIN', style: TextStyles.title1)),
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
                  suffixIcon: Icon(Icons.visibility, color: AppColors.primary),
                  border: InputBorder.none,
                ),
              ),
              Button(
                label: 'Login',
                onPressed: () {
                  AuthController.userLogin(
                      context, _emailController.text, _passwordController.text);
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
                            style: TextStyle(color: Colors.black)),
                        GestureDetector(
                          child: Text(
                            ' Cadastre-se',
                            style: TextStyle(color: AppColors.primary),
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
