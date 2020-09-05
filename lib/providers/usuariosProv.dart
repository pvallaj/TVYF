import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tvyamel/utils/preferencias_usuario.dart';

class UsuarioProvider {
  static String _firebaseToken = 'AIzaSyBstnJImEhbCp95eJA15jLH8ogUwajTMDU';

  final String _urlSU =
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken';
  final String _urlSI =
      'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseToken';

  final _pref = new PreferenciasUsuario();

  Future<Map<String, dynamic>> accesoUsuario(
      String correo, String password) async {
    final authData = {
      'email': correo,
      'password': password,
      'returnSecureToken': true
    };

    final resp = await http.post(_urlSI, body: json.encode(authData));

    Map<String, dynamic> dResp = json.decode(resp.body);

    print(dResp);

    if (dResp.containsKey('idToken')) {
      _pref.token = dResp['idToken'];
      return {'resp': 0, 'token': dResp['idToken']};
    } else {
      return {'resp': -1, 'mensaje': dResp['error']['message']};
    }
  }

  Future<Map<String, dynamic>> nuevoUsuario(
      String correo, String password) async {
    final authData = {
      'email': correo,
      'password': password,
      'returnSecureToken': true
    };

    final resp = await http.post(_urlSU, body: json.encode(authData));

    Map<String, dynamic> dResp = json.decode(resp.body);

    if (dResp.containsKey('idToken')) {
      _pref.token = dResp['idToken'];
      return {'resp': 0, 'token': dResp['idToken']};
    } else {
      return {'resp': -1, 'mensaje': dResp['error']['message']};
    }
  }
}
