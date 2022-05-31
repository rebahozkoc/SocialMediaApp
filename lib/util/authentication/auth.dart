import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import "package:shared_preferences/shared_preferences.dart";

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late SharedPreferences prefs;

  User? _userFromFirebase(User? user) {
    return user;
  }

  Stream<User?> get user {
    return _auth.authStateChanges().map(_userFromFirebase);
  }

  Future<dynamic> signInWithEmailPass(String email, String pass) async {
    try {
      prefs = await SharedPreferences.getInstance();

      UserCredential uc =
          await _auth.signInWithEmailAndPassword(email: email, password: pass);
      prefs.setInt(
          "user", (uc.credential != null) ? uc.credential!.token ?? -1 : -1);
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

  Future<User?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    UserCredential uc = await _auth.signInWithCredential(credential);
    return uc.user;
  }
}
