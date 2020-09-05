import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:tvyamel/src/paginas/nuevaCuenta.dart';
import 'package:tvyamel/providers/provider.dart';
import 'package:tvyamel/src/paginas/principal.dart';
import 'package:tvyamel/src/paginas/registro.dart';
import 'package:tvyamel/src/paginas/ubicaciones.dart';
import 'package:tvyamel/utils/preferencias_usuario.dart';
//import 'package:tvyamel/providers/db_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = new PreferenciasUsuario();

  await prefs.initPrefs();

  await Firebase.initializeApp();

  // DBProvider.db.agregarSucursal(Sucursal(
  //     id: '1', nombre: 'Nicolas Romero', lat: 19.626711, lng: -99.292138));
  // DBProvider.db.agregarSucursal(
  //     Sucursal(id: '2', nombre: 'Cosmopol', lat: 19.63219, lng: -99.124413));
  // DBProvider.db.agregarSucursal(Sucursal(
  //     id: '3', nombre: 'Patio Texcoco', lat: 19.516061, lng: -98.866334));
  // DBProvider.db.agregarSucursal(
  //     Sucursal(id: '3', nombre: 'El Rosario', lat: 19.503073, lng: -99.203192));
  // DBProvider.db.agregarSucursal(
  //     Sucursal(id: '4', nombre: 'Tecamac', lat: 19.503075, lng: -99.203192));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prefs = new PreferenciasUsuario();
    print(prefs);
    return Provider(
        child: MaterialApp(
      title: 'Tarjeta Virtual Yamel',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (BuildContext context) => Ubicaciones(),
        'registro': (BuildContext context) => Registro(),
        'principal': (BuildContext context) => Princial(),
        'nuevaCuenta': (BuildContext context) => NuevaCuenta(),
        'ubicaciones': (BuildContext context) => Ubicaciones()
      },
      theme: ThemeData(primaryColor: Colors.cyan),
    ));
  }
}
