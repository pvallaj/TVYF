import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AccesoProvider with ChangeNotifier {
  bool _logeado = false;

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void acceder() async {
    var user = await _handleSignIn();

    if (user != null) {
      _logeado = true;
      notifyListeners();
    } else {
      _logeado = false;
      notifyListeners();
    }
  }

  void salir() {
    _logeado = false;
    notifyListeners();
  }

  bool estaLogeado() => _logeado;

  Future _handleSignIn() async {
    print('--------------------1');
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    print('--------------------2');
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final user = (await _firebaseAuth.signInWithCredential(credential)).user;
    print('--------------------');
    print(user.toString());
    print('--------------------');
    return user;
  }
}
