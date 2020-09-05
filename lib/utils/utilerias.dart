import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void alerta(BuildContext context, String mensaje) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('¡ IMPORTANTE !'),
          content: Text(mensaje),
          actions: <Widget>[
            FlatButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('ACEPTAR'))
          ],
        );
      });
}
