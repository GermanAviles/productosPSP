import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Productos'),
      ),
      body: Container(
        child: Text('Lista de productos'),
      ),
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
}