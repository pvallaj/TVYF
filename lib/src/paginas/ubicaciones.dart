import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tvyamel/modelos/sucursal.dart';
import 'package:tvyamel/providers/db_provider.dart';

class Ubicaciones extends StatefulWidget {
  static final CameraPosition _kInitialPosition = const CameraPosition(
    target: LatLng(19.527919, -99.228449),
    zoom: 10.0,
  );

  @override
  _UbicacionesState createState() => _UbicacionesState();
}

class _UbicacionesState extends State<Ubicaciones> {
  List<String> _estilosMapas = [
    MapboxStyles.MAPBOX_STREETS,
    MapboxStyles.SATELLITE,
    MapboxStyles.OUTDOORS,
    MapboxStyles.TRAFFIC_DAY
  ];

  MapboxMapController controller;
  Symbol _sucursalSeleccionada;
  List<Sucursal> _sucursales = new List<Sucursal>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
          appBar: AppBar(
            title: Text('Sucursales Yamel'),
          ),
          //bottomNavigationBar: BarraNavegacion(),
          body: _paginas()),
    );
  }

  Widget _paginas() {
    this._sucursales.add(Sucursal(
        nombre: 'Polanco',
        subtitulo: "En Plaza Pabellon Polanco",
        lat: 1.0,
        lng: 1.0));
    this._sucursales.add(Sucursal(
        nombre: 'Americas',
        subtitulo: "En Plaza Las Américas Ecatepec",
        lat: 1.0,
        lng: 1.0));
    return PageView(
      children: [_listaSucursales(), _crearMapa()],
    );
  }

  void _onMapCreated(MapboxMapController controller) async {
    this.controller = controller;
    this.controller.onSymbolTapped.add(_seleccionarSucursal);
    // Query qry = FirebaseFirestore.instance.collection('ubicaciones');

    // await qry.get().then((QuerySnapshot queryss) async {
    //   queryss.docs.forEach((f) => {_agregarMarcador(f.data())});
    // });
    print("Agregando datos ....");
    List<Sucursal> l = await DBProvider.db.getSucursales();
    l.forEach((elemento) {
      print('Agegando: $elemento.nombre');
      _agregarSucursal(elemento);
    });
  }

  // void _agregarMarcador(Map<String, dynamic> p) {
  //   this.controller.addSymbol(SymbolOptions(
  //       iconSize: .12,
  //       geometry: LatLng(p['lat'], p['lng']),
  //       iconImage: 'assets/imagotipo_yamel.png',
  //       iconOpacity: .5,
  //       textField: p['nombre'],
  //       textSize: 12,
  //       textColor: "#33b2c0",
  //       textHaloColor: "#000000",
  //       textHaloWidth: .5,
  //       textOffset: Offset(0, -2.2)));
  // }

  void _agregarSucursal(Sucursal p) {
    this.controller.addSymbol(SymbolOptions(
        iconSize: .12,
        geometry: LatLng(p.lat, p.lng),
        iconImage: 'assets/imagotipo_yamel.png',
        iconOpacity: .5,
        textField: p.nombre,
        textSize: 12,
        textColor: "#33b2c0",
        textHaloColor: "#000000",
        textHaloWidth: .5,
        textOffset: Offset(0, -2.2)));
  }

  void _seleccionarSucursal(Symbol s) {
    print('---1');
    print(this._sucursalSeleccionada);
    setState(() {
      if (this._sucursalSeleccionada != null) {
        this.controller.removeCircle(this.controller.circles.last);
        this.controller.updateSymbol(this._sucursalSeleccionada,
            SymbolOptions(iconOpacity: .5, textColor: "#33b2c0"));
      }
      this._sucursalSeleccionada = s;
    });
    this.controller.addCircle(CircleOptions(
        geometry: s.options.geometry,
        circleColor: "#33b2c0",
        circleOpacity: 0,
        circleStrokeColor: "#000000",
        circleStrokeWidth: 3,
        circleRadius: 19));

    this
        .controller
        .updateSymbol(s, SymbolOptions(iconOpacity: 1, textColor: "#000000"));
    print('---2');
    print(this._sucursalSeleccionada);
  }

  Widget _crearMapa() {
    return new MapboxMap(
      initialCameraPosition: Ubicaciones._kInitialPosition,
      compassEnabled: true,
      zoomGesturesEnabled: true,
      myLocationEnabled: true,
      styleString: _estilosMapas[0],
      onMapCreated: _onMapCreated,
      myLocationTrackingMode: MyLocationTrackingMode.Tracking,
      myLocationRenderMode: MyLocationRenderMode.GPS,
    );
  }

//   Widget _listaSucursales() {
//     return ListView.builder(
//         itemCount: _sucursales.length,
//         itemBuilder: (BuildContext context, int index) {
//           return ListTile(
//               title: Center(child: Text('${_sucursales[index].nombre} ')));
//         });
//   }
// }
  Widget _listaSucursales() {
    List<Widget> lista = new List<Widget>();

    for (Sucursal suc in this._sucursales) {
      final tmp = ListTile(
        title: Text(suc.nombre),
        subtitle: Text(suc.subtitulo),
        leading: Icon(Icons.store),
        trailing: Icon(Icons.keyboard_arrow_right),
      );
      lista..add(tmp)..add(Divider());
    }
    return ListView(children: lista);
  }
}

class BarraNavegacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(items: [
      BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Buscar'),
      BottomNavigationBarItem(icon: Icon(Icons.zoom_in), label: 'Acercar'),
      BottomNavigationBarItem(icon: Icon(Icons.zoom_out), label: 'Alejar')
    ]);
  }
}
