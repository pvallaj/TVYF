import 'dart:async';

import 'package:rxdart/rxdart.dart';

import 'package:tvyamel/blocs/validaciones.dart';

class RegistroBloc with Validadores {
  // final _usuarioCtrl = StreamController<String>.broadcast();
  // final _claveCtrl = StreamController<String>.broadcast() ;
  //Los bihaviors son son equivalentes a los StreamControles, con el brotcast incluido y se requiere para trabajar con RXdart
  final _usuarioCtrl = BehaviorSubject<String>();
  final _claveCtrl = BehaviorSubject<String>();

  //Get
  Stream<String> get usuarioStream =>
      _usuarioCtrl.stream.transform(validarCorreoElectronico);
  Stream<String> get claveStream => _claveCtrl.stream.transform(validarClave);
  //set
  Function(String) get changeUsuario => _usuarioCtrl.sink.add;
  Function(String) get changeClave => _claveCtrl.sink.add;

  //Combinando stream para controlar el botón

  Stream<bool> get validaInitSesion =>
      Rx.combineLatest2(usuarioStream, claveStream, (e, p) => true);

  //Ultimo valor de los stream

  String get usuario => _usuarioCtrl.value;
  String get password => _claveCtrl.value;

  dispose() {
    _usuarioCtrl?.close();
    _claveCtrl?.close();
  }
}
