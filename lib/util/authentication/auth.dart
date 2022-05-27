import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<dynamic> signInWithEmailPass(String email, String pass) async {
    try {
      UserCredential uc =
          await _auth.signInWithEmailAndPassword(email: email, password: pass);
      return uc.user;
      //print(uc.toString());
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        return e.message ?? "E-mail and/or Password not Found";
        //registerUser();
      } else if (e.code == "wrong-password") {
        return e.message ?? "Wrong Password";
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> registerWithEmailPass(String email, String pass) async {
    try {
      UserCredential uc = await _auth.createUserWithEmailAndPassword(
          email: email, password: pass);
      return uc.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        return e.message ?? "Email is already occupied";
      } else if (e.code == "weak-password") {
        return e.message ?? "Weak Password";
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
