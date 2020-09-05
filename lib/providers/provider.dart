import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tvyamel/blocs/registroBloc.dart';
export 'package:tvyamel/blocs/registroBloc.dart';

class Provider extends InheritedWidget {
  final regBloc = RegistroBloc();

  static Provider _instancia;

  factory Provider({Key key, Widget child}) {
    if (_instancia == null) {
      _instancia = new Provider._internal(key: key, child: child);
    }

    return _instancia;
  }

  Provider._internal({Key key, Widget child}) : super(key: key, child: child);
  // Provider({Key key, Widget child})
  // : super( key:key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static RegistroBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>().regBloc;
  }

  // Stream<bool> get formValidStream =>
  //      Rx.combineLatest2(emailStream, passwStream, (e, p) => true);

}
