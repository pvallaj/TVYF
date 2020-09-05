import 'dart:async';


class Validadores{

final validarClave = StreamTransformer<String, String>.fromHandlers(
  handleData: (clave , sink){
    if(clave.length>=6){
      sink.add(clave);
    }else{
      sink.addError('Error: contraseña invalida');
    }
  }
);

final validarCorreoElectronico = StreamTransformer<String, String>.fromHandlers(
  handleData: (usuario , sink){
    Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp= new RegExp(pattern);

    if(regExp.hasMatch(usuario))
      sink.add(usuario);
    else
      sink.addError('Error: Usuario no valido, se requiere un email');
  }
);

}