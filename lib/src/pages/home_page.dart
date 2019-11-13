import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:productos/src/providers/bloc_provider.dart';
import 'package:productos/src/providers/productos_bloc.dart';
import 'package:productos/src/providers/productos_provider.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:typed_data';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;

  final productoProvider = new ProductosProvider();

  @override
  Widget build(BuildContext context) {

    final productsBloc = BlocProvider.ofBloc<ProductosBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Productos'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.print),
            onPressed: _imprimir( context ),
          ),
        ],
      ),
      body: _crearListado(context, productsBloc),
      floatingActionButton: _crearBoton( context ),
    );
  }

  _crearBoton( BuildContext context ) {
    return FloatingActionButton(
      child: Icon( Icons.add ),
      backgroundColor: Colors.blue,
      onPressed: () => Navigator.pushNamed(context, 'producto'),
    );
  }

  Widget _crearListado( BuildContext context, ProductosBloc bloc ) {

    productoProvider.cargarProductos( bloc );

    return StreamBuilder(
      stream: bloc.productoStream,
      builder: ( BuildContext context, AsyncSnapshot snapshot ) {

        if ( snapshot.hasData ) {

          final productos = snapshot.data;

          return ListView.builder(
            itemCount: productos.length,
            itemBuilder: (context, index) => _crearItem( context, bloc, productos[index] ),
          );
        } else {
          return Center( child: Text('Sin data'), );
        }

      },
    );

  }

  Widget _crearItem( BuildContext context, ProductosBloc productosBloc, producto ) {

    return Dismissible(
      key: UniqueKey(),
      background: Container( 
        color: Colors.amber
      ),
       onDismissed: ( direccion ) {
        if ( direccion.index == 3 ) {
          Navigator.pushNamed(context, 'producto');
        }
        if ( direccion.index == 2 ) {
          productoProvider.eliminarProducto( producto['id'] );
        }
        // productoProvider.eliminarProducto(producto.id);
       },
      child: Card(
        child: Column(
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                radius: 30.0,
                backgroundImage: _mostrarImagen(producto),
              ),
              title: Text('${ producto["id"] }', style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold) ),
              subtitle: Text( producto['titulo'] ),
              trailing: Column(
                children: <Widget>[
                  Text('CO\$ ${ producto["valor"] }', style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold) ),
                    // amount(producto.existencia),
                ],
              ),
            )
          ],
        ),
      ),
    );

  }

  _mostrarImagen(producto){
      if (producto['fotoUrl'] == null || producto['fotoUrl'] == ""){
        return AssetImage('assets/images/no-image.png');
      } else {
        return NetworkImage(producto['fotoUrl']);
      }
  }

  Widget amount(double existencia){
    return Text( existencia.toString() );
  }

  _imprimir( BuildContext context ) async {
    
    var pathImage = "";
    
    final filename = 'no-image.png';
    var bytes = await rootBundle.load("assets/images/no-image.png");
    String dir = (await getApplicationDocumentsDirectory()).path;

    writeToFile(bytes,'$dir/$filename');

    pathImage='$dir/$filename';

    print('RUTA: $pathImage');
    _tesPrint( pathImage );
  }

  Future<void> writeToFile(ByteData data, String path) {
    final buffer = data.buffer;

    return new File(path).writeAsBytes( buffer.asUint8List(data.offsetInBytes, data.lengthInBytes) );
  }

  void _tesPrint( pathImage ) async {
    //SIZE
    // 0- normal size text
    // 1- only bold text
   // 2- bold with medium text
   // 3- bold with large text
   //ALIGN
   // 0- ESC_ALIGN_LEFT
   // 1- ESC_ALIGN_CENTER
    // 2- ESC_ALIGN_RIGHT
    bluetooth.isConnected.then((isConnected) {
      if (isConnected) {
        bluetooth.printCustom("HEADER",3,1);
        bluetooth.printNewLine();
        bluetooth.printImage(pathImage);
        bluetooth.printNewLine();
        bluetooth.printLeftRight("LEFT", "RIGHT",0);
        bluetooth.printLeftRight("LEFT", "RIGHT",1);
        bluetooth.printNewLine();
        bluetooth.printLeftRight("LEFT", "RIGHT",2);
        bluetooth.printCustom("Body left",1,0);
        bluetooth.printCustom("Body right",0,2);
        bluetooth.printNewLine();
        bluetooth.printCustom("Terimakasih",2,1);
        bluetooth.printNewLine();
        // bluetooth.printQRcode("Insert Your Own Text to Generate");
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.paperCut();
      }
    });
  }
}