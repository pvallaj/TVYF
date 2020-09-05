import 'package:flutter/material.dart';

import 'package:tvyamel/providers/provider.dart';

class Princial extends StatelessWidget {
  const Princial({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    return Scaffold(
        appBar: AppBar(title: Text('Tarjeta Virtual Yamel')),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('usuario: ${bloc.usuario}'),
              Divider(),
              Text('pass:${bloc.password}')
            ]));
  }
}
