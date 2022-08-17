enum EnumUnidadeAumento {
  CENTIMETROS,
  MILIMETROS,
  METROS,
}

class UnidadeAumentoHandler {

  static EnumUnidadeAumento handle(String value) {
    switch (value) {
      case 'CENTIMETROS':
        return EnumUnidadeAumento.CENTIMETROS;

      case 'MILIMETROS':
        return EnumUnidadeAumento.MILIMETROS;

      case 'METROS':
        return EnumUnidadeAumento.METROS;

      default:
        return EnumUnidadeAumento.CENTIMETROS;
    }
  }
}
