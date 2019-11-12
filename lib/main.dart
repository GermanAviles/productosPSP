import 'package:flutter/material.dart';
import 'package:productos/src/pages/home_page.dart';
import 'package:productos/src/pages/producto_page.dart';

void main() => runApp(MyApp());
 
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