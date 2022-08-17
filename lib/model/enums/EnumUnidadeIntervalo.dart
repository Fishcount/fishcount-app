enum EnumUnidadeIntervalo {
  DIAS,
  SEMANAS,
  MESES,
}

class UnidadeIntervaloHandler {

  static EnumUnidadeIntervalo handle(String value) {
    switch (value) {
      case 'DIAS':
        return EnumUnidadeIntervalo.DIAS;

      case 'SEMANAS':
        return EnumUnidadeIntervalo.SEMANAS;

      case 'MESES':
        return EnumUnidadeIntervalo.MESES;

      default:
        return EnumUnidadeIntervalo.DIAS;
    }
  }
}
