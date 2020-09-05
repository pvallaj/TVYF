import 'package:flutter/material.dart';
//import 'package:provider/provider.dart' as provd;

import 'package:tvyamel/providers/provider.dart';
import 'package:tvyamel/providers/usuarioFBP.dart';
import 'package:tvyamel/providers/usuariosProv.dart';
import 'package:tvyamel/utils/utilerias.dart' as Util;

class Registro extends StatelessWidget {
  final _usuarioProv = new UsuarioProvider();
  final _auth = new UsuarioFBP();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[_fondo(context), _formulario(context)]),
    );
  }

  Widget _fondo(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    final _fondoAgua = Container(
      height: size.height * .4,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
        Color.fromRGBO(84, 232, 249, 1.0),
        Color.fromRGBO(67, 174, 186, 1.0)
      ])),
    );

    return Stack(
      children: <Widget>[
        _fondoAgua,
        Container(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            children: <Widget>[
              Icon(Icons.person_pin_circle, color: Colors.white, size: 100.0),
              SizedBox(
                height: 10.0,
                width: double.infinity,
              ),
              Text('Tarjeta Virtual Yamel',
                  style: TextStyle(color: Colors.white, fontSize: 25.0)),
            ],
          ),
        )
      ],
    );
  }

  Widget _formulario(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final blocReg = Provider.of(context);
    return SingleChildScrollView(
      child: Column(children: <Widget>[
        SafeArea(
          child: Container(height: 200.0),
        ),
        Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5.0,
                      offset: Offset(0.0, 10.0),
                      spreadRadius: 5.0),
                ]),
            child: Column(
              children: <Widget>[
                Text(
                  'Acceso',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(height: 60.0),
                _usuario(blocReg),
                SizedBox(height: 30.0),
                _contrasena(blocReg),
                SizedBox(height: 30.0),
                _boton(blocReg),
                SizedBox(height: 30.0),
                _botonGoogle(blocReg),
              ],
            )),
        FlatButton(
          child: Text('Nueva cuenta',
              style: TextStyle(fontSize: 12.0, color: Colors.redAccent)),
          onPressed: () =>
              Navigator.pushReplacementNamed(context, 'nuevaCuenta'),
        ),
        SizedBox(
          height: 100.0,
        )
      ]),
    );
  }

  Widget _usuario(RegistroBloc bloc) {
    return StreamBuilder(
      stream: bloc.usuarioStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                icon: Icon(Icons.alternate_email, color: Colors.deepPurple),
                hintText: 'ejemplo@servicio.com',
                labelText: 'Correo Electrónico',
                counterText: snapshot.data,
                errorText: snapshot.error),
            onChanged: bloc.changeUsuario,
          ),
        );
      },
    );
  }

  Widget _contrasena(RegistroBloc bloc) {
    return StreamBuilder(
      stream: bloc.claveStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
                icon: Icon(Icons.lock_outline, color: Colors.deepPurple),
                labelText: 'Contraseña',
                counterText: snapshot.data,
                errorText: snapshot.error),
            onChanged: bloc.changeClave,
          ),
        );
      },
    );
  }

  Widget _boton(RegistroBloc bloc) {
    return StreamBuilder(
      stream: bloc.validaInitSesion,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 20.0),
            child: Text(
              'Entrar',
              style: TextStyle(fontSize: 20),
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          elevation: 0.0,
          color: Colors.cyan,
          textColor: Colors.white,
          onPressed:
              snapshot.hasData ? () => _registroCorreo(bloc, context) : null,
        );
      },
    );
  }

  Widget _botonGoogle(RegistroBloc bloc) {
    return StreamBuilder(
      stream: bloc.validaInitSesion,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 20.0),
              child: Text(
                'Google',
                style: TextStyle(fontSize: 20),
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            elevation: 0.0,
            color: Colors.cyan,
            textColor: Colors.white,
            onPressed: () => _registro(bloc, context));
      },
    );
  }

  _registroCorreo(RegistroBloc bloc, BuildContext context) async {
    Map resp = await _usuarioProv.accesoUsuario(bloc.usuario, bloc.password);

    print(resp);
    if (resp != null) {
      print('Abriendo ubicaciones');
      Navigator.pushReplacementNamed(context, 'ubicaciones');
    } else
      Util.alerta(context, 'Usuario / contraseña incorrectos.');
  }

  _registro(RegistroBloc bloc, BuildContext context) async {
    var resp;
    try {
      print('Registrando usuario con google');
      resp = await _auth.acceder();
    } catch (e) {
      print(e);
    }

    print(resp);
    if (resp != null)
      Navigator.pushReplacementNamed(context, 'ubicaciones');
    else
      Util.alerta(context, 'Usuario / contraseña incorrectos.');
  }
}
