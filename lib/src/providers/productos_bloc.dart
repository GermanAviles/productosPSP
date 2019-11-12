
import 'package:productos/src/models/producto_model.dart';
import 'package:rxdart/subjects.dart';

class ProductosBloc {

  final _productosTotales = BehaviorSubject< List<ProductoModel> >();

  Stream< List<ProductoModel> > get productoStream => _productosTotales.stream;

  Function( List<ProductoModel> ) get productosSink => _productosTotales.sink.add;

  void dispose() {
    _productosTotales.close();
  }

}