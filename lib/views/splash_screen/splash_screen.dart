import 'package:flutter/material.dart';
import 'package:ludic/shared/auth/auth_controller.dart';
import 'package:ludic/shared/themes/app_colors.dart';
import 'package:ludic/shared/themes/app_textstyles.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authController = AuthController();
    authController.currentUser(context);
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: Stack(
        children: [
          Center(
              child: Container(
            color: AppColors.secondary,
          )),
          Center(
              child: Container(
                height: 200,
                width: 200,
                child: Image(
            image: AssetImage('assets/logo.png'),
          ),
              ))
        ],
      ),
    );
  }
}
