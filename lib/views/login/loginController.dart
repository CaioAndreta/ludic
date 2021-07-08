import 'package:firebase_auth/firebase_auth.dart';

class LoginController{
  static final auth = FirebaseAuth.instance;
  static login(var email, var password) async {
      try {
        await auth.signInWithEmailAndPassword(
            email: email, password: password);
      } on FirebaseAuthException catch (e) {
        print(e);
      }
    }
}