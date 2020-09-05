import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'fb_auth_service.dart';


class Principal extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
              children: <Widget>[
                Text('Estamos dentro'),
                RaisedButton(
                  child: Text('Salir'),
                  onPressed: (){
                    Provider.of<AccesoProvider>(context, listen:false).salir();
                  },
                )
              ],
            )
        )
    );
  }

}