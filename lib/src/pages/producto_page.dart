import 'package:flutter/material.dart';
import 'package:productos/src/models/producto_model.dart';
import 'package:productos/src/providers/productos_provider.dart';
import 'package:productos/src/utils/utils.dart' as utils;

class ProductoPage extends StatefulWidget {

  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  
  final productoProvider = new ProductosProvider();
  final formKey = GlobalKey<FormState>();

  ProductoModel producto = new ProductoModel();

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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                _crearNombre(),
                _crearPrecio(),
                _crearDisponible(),
                _crearBoton()
              ],
            ),
          ),
        ),
      )
    );
  }

  Widget _crearNombre() {
    return TextFormField(
      initialValue: producto.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration:InputDecoration(
        labelText: 'Producto',
      ),
      onSaved: (value) => producto.titulo = value,
      validator: ( valor ) {
        return valor.length < 3 ? 'Ingrese el nombre del producto' : null;
      },
    );
  }

  Widget _crearPrecio() {
    return TextFormField(
      // initialValue: producto.valor.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      // obscureText: true,
      decoration:InputDecoration(
        labelText: 'Precio',
      ),
      onSaved: (value) => producto.valor = double.parse(value),
      validator:  ( value ) {
        return utils.isNumeric(value) ? null : 'Sólo números';
      },
    );
  }

  Widget _crearBoton() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      textColor: Colors.white,
      color: Colors.deepPurple,
      label: Text('Guardar'),
      icon: Icon( Icons.save ),
      onPressed: () => _submit(),
    );
  }

  Widget _crearDisponible() {
    return SwitchListTile(
      value: producto.disponible,
      title: Text('Disponible'),
      activeColor: Colors.deepPurple,
      onChanged: (value) {
        setState(() {
          producto.disponible = value;
        });
      },
    );
  }

  void _submit() {
    
    if ( !formKey.currentState.validate() ) return;

    formKey.currentState.save();

    print('Titulo: ${producto.titulo}');
    print('Valor: ${producto.valor}');
    print('disponible: ${producto.disponible}' );

    
    productoProvider.crearProducto(producto);
    // productoProvider.cargarProductos();
    
  }
}