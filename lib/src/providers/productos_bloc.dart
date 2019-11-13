
// import 'package:productos/src/models/producto_model.dart';
import 'package:productos/src/providers/bloc_provider.dart';
import 'package:rxdart/subjects.dart';

class ProductosBloc implements BlocBase {

  final _productosTotales = BehaviorSubject<List>();

  // STREAMS
  Stream<List> get productoStream => _productosTotales.stream;

  // SINKS
  Function(List) get productosSink => _productosTotales.sink.add;

  List get productosFinales => _productosTotales.value;


  void dispose() {
    _productosTotales.close();
  }


  // void clear(){
  //   _productosTotales.sink.add([]);
  // }

}