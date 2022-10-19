enum EnumUnidadePeso { GRAMA, KILO }

class UnidadePesoHandler {
  static String handle(String value) {
    switch (value) {
      case 'GRAMA':
        return 'Gr';

      case 'KILO':
        return 'Kg';

      default:
        return '';
    }
  }
}
