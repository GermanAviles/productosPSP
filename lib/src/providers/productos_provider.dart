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

    final productos = await databaseReference.collection('productos').getDocuments();

    productos.documents.forEach( (product) {

      productoModel.id          = product.documentID;
      productoModel.valor       = product.data['valor'];
      productoModel.titulo      = product.data['titulo'];
      productoModel.disponible  = product.data['disponible'];
      
      products.add( productoModel.toJson() );
    });

    return products;
  }

}