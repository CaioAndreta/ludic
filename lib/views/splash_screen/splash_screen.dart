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
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Center(child: Container(color: AppColors.primary,)),
          Center(child: Text('LUDIC', style: TextStyles.title1,))
        ],
      ),
    );
  }
}
