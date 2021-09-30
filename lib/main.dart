import 'dart:html';

import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ludic/shared/themes/app_textstyles.dart';
import 'package:ludic/views/myapp.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(AppFirebase());
}

class AppFirebase extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _AppFirebaseState createState() => _AppFirebaseState();
}

class _AppFirebaseState extends State<AppFirebase> {
  Future<void> appCheck() async {
    await FirebaseAppCheck.instance
        .activate(webRecaptchaSiteKey: 'recaptcha-v3-site-key');
  }

  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemStatusBarContrastEnforced: true,
      statusBarColor: Colors.transparent,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          if(kIsWeb)
          return Material(
            child: Center(
              child: Text(
                'Não foi possível inicializar o Firebase',
                textDirection: TextDirection.ltr,
                style: TextStyles.primaryCodigoSala,
              ),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          appCheck();
          return GestureDetector(
            child: AppWidget(),
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
