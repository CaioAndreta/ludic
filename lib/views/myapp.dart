import 'package:flutter/material.dart';
import 'package:ludic/shared/themes/app_colors.dart';
import 'package:ludic/views/home_page/homePage.dart';
import 'package:ludic/views/register/escolherRegistro.dart';
import 'package:ludic/views/login/login.dart';
import 'package:ludic/views/register/registerAluno.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ludic/views/register/registerProf.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.white,
          backgroundColor: Colors.white,
          textTheme: TextTheme(
            headline1: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: AppColors.primary),
            headline2: GoogleFonts.roboto(
                fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
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
      routes: {
        '/': (context) => LoginPage(),
        '/escolher-registro': (context) => EscolherRegistroView(),
        '/register-aluno': (context) => RegisterAlunoView(),
        '/register-professor': (context) => RegisterProfView(),
        '/home': (context) => HomePage(),
      },
    );
  }
}
