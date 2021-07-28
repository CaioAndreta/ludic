import 'package:flutter/material.dart';
import 'package:ludic/shared/themes/app_colors.dart';
import 'package:ludic/shared/themes/app_textstyles.dart';
import 'package:ludic/views/register/registerController.dart';

class EscolherRegistroView extends StatelessWidget {
  const EscolherRegistroView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.primary,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Escolha o tipo de cadastro',
            style: TextStyle(color: AppColors.secondary)),
        iconTheme: IconThemeData(color: AppColors.secondary),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Container(
                child: TextButton(
                  onPressed: () {
                    RegisterController.isTeacher = true;
                    Navigator.of(context).pushNamed('/register');
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Sou um professor',
                          style: TextStyles.secondaryTitleText),
                      SizedBox(height: 15),
                      Text(
                        '👨‍🏫',
                        style: TextStyle(fontSize: 36),
                      ),
                    ],
                  ),
                ),
                width: size.width,
                height: size.height / 2,
                decoration: BoxDecoration(color: AppColors.primary)),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Divider(
              thickness: 1,
              color: AppColors.secondary,
            ),
          ),
          Expanded(
            child: Container(
                child: TextButton(
                  onPressed: () {
                    RegisterController.isTeacher = false;
                    Navigator.of(context).pushNamed('/register');
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Sou um aluno',
                          style: TextStyles.secondaryTitleText),
                      SizedBox(height: 15),
                      Text(
                        '👨‍🎓',
                        style: TextStyle(fontSize: 36),
                      ),
                    ],
                  ),
                ),
                width: size.width,
                height: size.height / 2,
                decoration: BoxDecoration(color: AppColors.primary)),
          ),
        ],
      ),
    );
  }
}
