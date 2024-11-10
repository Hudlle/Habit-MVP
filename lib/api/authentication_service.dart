import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // create a new account
  static Future<String> createAccountWithEmail(String username, String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      editUsername(username);
      return "signup successful";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    } catch (e) {
      return e.toString();
    }
  }

  // get display name
  static String getUsername() {
    var user = FirebaseAuth.instance.currentUser;
    return user?.displayName ?? "username";
  }

  // edit display name
  static Future<String> editUsername(String username) async {
    await FirebaseAuth.instance.currentUser!.updateDisplayName(username);
    return "username edit successful";
  }

  // login
  static Future<String> loginWithEmail(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      return "login successful";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    } catch (e) {
      return e.toString();
    }
  }

  // logout 
  static Future logout() async {
    await FirebaseAuth.instance.signOut();
  }

  // check whether the user is sign in or not
  static Future<bool> isLoggedIn() async {
    var user = FirebaseAuth.instance.currentUser;
    return user != null;
  }
}