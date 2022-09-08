enum EnumUnidadePeso { GRAMA, KILO }

class UnidadePesoHandler {
  static String handle(String value) {
    switch (value) {
      case 'GRAMA':
        return 'Gramas';

      case 'KILO':
        return 'Quilos';

      default:
        return '';
    }
  }
}
