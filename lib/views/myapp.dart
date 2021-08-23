import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ludic/shared/models/tarefa_model.dart';
import 'package:ludic/shared/models/user_model.dart';
import 'package:ludic/shared/themes/app_colors.dart';
import 'package:ludic/views/home_page/homePage.dart';
import 'package:ludic/views/register/escolherRegistro.dart';
import 'package:ludic/views/login/login.dart';
import 'package:ludic/views/register/register.dart';
import 'package:ludic/views/sala/salaView.dart';
import 'package:ludic/views/splash_screen/splash_screen.dart';

import 'detalhes_tarefa_professor/tarefa_professor_view.dart';
import 'entrar_sala/entrarSala.dart';
import 'nova_sala/novaSala.dart';
import 'detalhes_tarefa_aluno/tarefa_aluno_view.dart';

class MyApp extends StatelessWidget {
  MyApp({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: AppFirebase());
  }
}

class AppFirebase extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _AppFirebaseState createState() => _AppFirebaseState();
}

class _AppFirebaseState extends State<AppFirebase> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Material(
            child: Center(
              child: Text(
                'Não foi possível inicializar o Firebase',
                textDirection: TextDirection.ltr,
              ),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: AppWidget());
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return ScrollConfiguration(
            behavior: AppScrollBehavior(), child: child!);
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          canvasColor: AppColors.secondary,
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
            titleTextStyle: TextStyle(color: AppColors.primary),
            iconTheme: IconThemeData(color: AppColors.primary),
          )),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashPage(),
        '/home': (context) => HomePage(
            user: ModalRoute.of(context)!.settings.arguments as UserModel),
        '/login': (context) => LoginPage(),
        '/escolher-registro': (context) => EscolherRegistroView(),
        '/register': (context) => RegisterView(),
        '/nova-sala': (context) => NovaSalaView(),
        '/entrar-sala': (context) => EntrarSalaView(),
        '/sala': (context) => SalaView(),
        '/tarefa-professor': (context) => TarefaProfessor(
            tarefa: ModalRoute.of(context)!.settings.arguments as Tarefa),
        '/tarefa-aluno': (context) => TarefaAluno(
            tarefa: ModalRoute.of(context)!.settings.arguments as Tarefa)
      },
    );
  }
}

class AppScrollBehavior extends ScrollBehavior {
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
