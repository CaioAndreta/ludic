import 'package:flutter/material.dart';
import 'package:ludic/shared/auth/auth_controller.dart';
import 'package:ludic/shared/themes/app_colors.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  
  @override
  void initState() {
    final authController = AuthController();
    authController.currentUser(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            height: 150,
            width: 150,
            child: Image(
              image: AssetImage('assets/logo.png'),
            ),
          ))
        ],
      ),
    );
  }
}
