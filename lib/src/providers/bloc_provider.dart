import 'package:flutter/material.dart';

class BlocProvider<T extends BlocBase> extends InheritedWidget {

  // static BlocProvider _instancia;
  final T bloc;
  final Widget child;

  // Solo instanciamos una vez el servicio
  // factory BlocProvider({ Key key, Widget child }) {
  //       if ( _instancia == null ) {
  //     _instancia = new BlocProvider._internal( key: key, child: child );
  //   }
  //   return _instancia;
  // }

  BlocProvider({Key key, @required this.child, @required this.bloc}) : super(key: key);

  @override bool updateShouldNotify(InheritedWidget oldWidget) => true; 


  static T ofBloc<T extends BlocBase>(BuildContext context) {
    final type = _typeOf< BlocProvider<T> >();
    BlocProvider<T> provider = context.inheritFromWidgetOfExactType(type);
    return provider.bloc;
  }

  static Type _typeOf<T>() => T;

}

abstract class BlocBase {
  void dispose();
}