
bool isNumeric ( String valor ) {

  if ( valor.isEmpty ) return false;

  final isNumber = num.tryParse(valor);

  return isNumber == null ? false : true;


}