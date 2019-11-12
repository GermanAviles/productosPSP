import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:productos/src/models/producto_model.dart';

final databaseReference = Firestore.instance;

class ProductosProvider {

  ProductoModel productoModel = new ProductoModel();

  ProductosProvider();

  createProducto( ProductoModel producto ) async {

    final result = await databaseReference.collection('productos').add( producto.toJson() );
    print('id: ${result.documentID}');
    print('ruta: ${result.path}');

  }

  Future getProductos() async {
    List products = [];

    databaseReference.collection('productos').snapshots().listen( (data)  {
      data.documents.forEach( (product) {

        productoModel.id          = product.documentID;
        productoModel.valor       = product.data['valor'];
        productoModel.titulo      = product.data['titulo'];
        productoModel.disponible  = product.data['disponible'];
        
        products.add( productoModel.toJson() );

        // print('${product.documentID} - ${product.data}');
      } );

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

}