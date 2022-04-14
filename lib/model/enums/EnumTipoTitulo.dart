enum EnumTipoTitulo {
  ENTRADA,
  SAIDA,
  ESTORNO,
}

String getTipoTitulo(EnumTipoTitulo tipoTitulo) {
  switch (tipoTitulo) {
    case EnumTipoTitulo.ENTRADA:
      return "Entrada";

    case EnumTipoTitulo.SAIDA:
      return "Saida";

    case EnumTipoTitulo.ESTORNO:
      return "Estorno";
  }
}
