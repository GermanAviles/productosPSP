import 'package:flutter/material.dart';

class ProductoPage extends StatelessWidget {

  const ProductoPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Productos'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[

        ],
      ),
    );
  }
}