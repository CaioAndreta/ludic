import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ludic/shared/models/tarefa_aluno_model.dart';
import 'package:ludic/shared/models/tarefa_model.dart';
import 'package:ludic/shared/models/user_model.dart';
import 'package:ludic/shared/themes/app_colors.dart';
import 'package:ludic/views/corrigir_tarefa/corrigir_tarefa_view.dart';
import 'package:ludic/views/detalhes_tarefa_aluno/tarefa_aluno_view.dart';
import 'package:ludic/views/home_page/homePage.dart';
import 'package:ludic/views/lista_correcao/lista_correcao_view.dart';
import 'package:ludic/views/register/escolherRegistro.dart';
import 'package:ludic/views/login/login.dart';
import 'package:ludic/views/register/register.dart';
import 'package:ludic/views/sala/salaView.dart';
import 'package:ludic/views/sala/telas/infoSala.dart';
import 'package:ludic/views/splash_screen/splash_screen.dart';
import 'package:ludic/views/update_usuario/update_usuario_view.dart';

import 'detalhes_tarefa_professor/tarefa_professor_view.dart';
import 'entrar_sala/entrarSala.dart';
import 'nova_sala/novaSala.dart';

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
  @override
  _AppFirebaseState createState() => _AppFirebaseState();
}

class _AppFirebaseState extends State<AppFirebase> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
  
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      systemStatusBarContrastEnforced: true,
      statusBarColor: Colors.transparent,
    ));
  }

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
            backgroundColor: AppColors.secondary,
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
        '/register': (context) => Register(),
        '/nova-sala': (context) => NovaSalaView(),
        '/entrar-sala': (context) => EntrarSalaView(),
        '/sala': (context) => SalaView(),
        '/tarefa-professor': (context) => TarefaProfessor(
            tarefa: ModalRoute.of(context)!.settings.arguments as Tarefa),
        '/tarefa-aluno': (context) => TarefaAlunoView(
            tarefa: ModalRoute.of(context)!.settings.arguments as Tarefa),
        '/lista-correcao': (context) => ListaCorrecao(
            tarefa: ModalRoute.of(context)!.settings.arguments as Tarefa),
        '/corrigir-tarefa': (context) => CorrigirTarefa(
            tarefaAluno:
                ModalRoute.of(context)!.settings.arguments as TarefaAluno),
        '/update-usuario': (context) => UpdateUsuarioView(
            user: ModalRoute.of(context)!.settings.arguments as UserModel),
        '/info-sala': (context) => InfoSala()
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
