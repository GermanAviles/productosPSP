import 'package:flutter/material.dart';
import 'package:productos/src/pages/home_page.dart';
import 'package:productos/src/pages/producto_page.dart';
import 'package:productos/src/providers/bloc_provider.dart';
import 'package:productos/src/providers/productos_bloc.dart';

void main() {

  return runApp(
    BlocProvider<ProductosBloc>(
      bloc: ProductosBloc(),
      child: MyApp(),
    )
  );
}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Productos'),
        ),
      ),
      initialRoute: 'home',
      routes: {
        'home'     : ( BuildContext context ) => HomePage(),
        'producto' : ( BuildContext context ) => ProductoPage()
      },
    );
  }
}