// import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:productos/src/models/producto_model.dart';
import 'package:productos/src/providers/productos_bloc.dart';

final databaseReference = Firestore.instance;

class ProductosProvider {

  // instanciamos nuestro modelo
  ProductoModel productoModel = new ProductoModel();

  // Metodo para crear un nuevo producto 
  crearProducto( ProductoModel producto ) async {
    final result = await databaseReference.collection('productos').add( producto.toJson() );

    print('id: ${result.documentID}');
    print('ruta: ${result.path}');

  }

  // Metodo para obtener los productos
  cargarProductos( ProductosBloc bloc ) async {
    List products = [];

    // final productBloc = new ProductosBloc();

    databaseReference.collection('productos').snapshots().listen( (data)  {
      products = [];

      data.documents.forEach( (product) {

        productoModel.id          = product.documentID;
        productoModel.valor       = product.data['valor'];
        productoModel.titulo      = product.data['titulo'];
        productoModel.disponible  = product.data['disponible'];
        
        products.add( productoModel.toJson() );
      } );

      // bloc.productosSink([]);
      bloc.productosSink(products);

      // data.documentChanges.forEach( (doc) {
      //   print('${doc.document.data} - ${doc.document.documentID}');
      // });
    });

    // final productos = await databaseReference.collection('productos').getDocuments();

    // productos.documents.forEach( (product) {
    //   productoModel.id          = product.documentID;
    //   productoModel.valor       = product.data['valor'];
    //   productoModel.titulo      = product.data['titulo'];
    //   productoModel.disponible  = product.data['disponible'];
      
    //   products.add( productoModel.toJson() );
    // });

    return products;
  }

  eliminarProducto( productoId ) {
    databaseReference.collection('productos').document( productoId ).delete();
  }

}