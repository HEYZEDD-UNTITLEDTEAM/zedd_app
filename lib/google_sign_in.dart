//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GoogleSignInProvider extends ChangeNotifier{
  final googleSignin =GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user =>_user!;

  Future googleLogin() async {
    final googleUser = await googleSignin.signIn();
    if (googleUser == null) return;
    _user = googleUser;

    final googleAuth= await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
      
    );
     
    await FirebaseAuth.instance.signInWithCredential(credential);

    notifyListeners();
  }
}