import 'package:flutter/material.dart';
import 'package:tvyamel/fb_auth_service.dart';
import 'package:provider/provider.dart';

class PaginaAcceso extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: RaisedButton(
      child: Text('Acceder Google'),
      onPressed: () {
        Provider.of<AccesoProvider>(context, listen: false).acceder();
      },
    )));
  }
}
