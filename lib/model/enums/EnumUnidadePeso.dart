enum EnumUnidadePeso { GRAMA, KILO }

class UnidadePesoHandler {
  static String handle(String value) {
    switch (value) {
      case 'GRAMA':
        return 'GR';

      case 'KILO':
        return 'KG';

      default:
        return '';
    }
  }
}
