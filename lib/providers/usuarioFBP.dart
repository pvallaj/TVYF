import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UsuarioFBP with ChangeNotifier {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _registrado = false;

  bool estaRegistrado() => _registrado;
  Future acceder() async {
    var user = await _handleSignIn();

    if (user != null) {
      _registrado = true;
    } else {
      _registrado = false;
    }
    //notifyListeners();
    return user;
  }

  void salir() {
    _registrado = false;
    notifyListeners();
  }

  Future _handleSignIn() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final user = (await _auth.signInWithCredential(credential)).user;
    print("signed in " + user.displayName);
    FirebaseFirestore.instance.collection('users').doc(user.email).set({
      "nombre": user.displayName,
      "telefono": user.phoneNumber,
      "foto": user.photoURL
    });
    return user;
  }
}
