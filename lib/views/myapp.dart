import 'package:flutter/material.dart';
import 'package:ludic/shared/themes/app_colors.dart';
import 'package:ludic/views/home_page/homePage.dart';
import 'package:ludic/views/novaSala/novaSala.dart';
import 'package:ludic/views/register/escolherRegistro.dart';
import 'package:ludic/views/login/login.dart';
import 'package:ludic/views/register/registerAluno.dart';
import 'package:ludic/views/register/registerProf.dart';

class MyApp extends StatelessWidget {
  String? email;
  MyApp({Key? key, this.email}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: AppColors.primary,
                hoverColor: AppColors.secondary),
            brightness: Brightness.light,
            primaryColor: AppColors.primary,
            backgroundColor: AppColors.secondary,
            textTheme: TextTheme(
              headline1: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary),
              bodyText2: TextStyle(
                  fontSize: 14.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            appBarTheme: AppBarTheme(
              centerTitle: true,
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              titleTextStyle: TextStyle(color: Colors.purple.shade900),
              iconTheme: IconThemeData(color: Colors.purple.shade900),
            )),
        initialRoute: email == null ? '/' : '/home',
        routes: {
          '/': (context) => LoginPage(),
          '/escolher-registro': (context) => EscolherRegistroView(),
          '/register-aluno': (context) => RegisterAlunoView(),
          '/register-professor': (context) => RegisterProfView(),
          '/home': (context) => HomePage(),
          '/nova-sala': (context) => NovaSalaView()
        },
      ),
    );
  }
}
