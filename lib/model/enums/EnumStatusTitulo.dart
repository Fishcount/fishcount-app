enum EnumStatusTitulo {
  EM_ABERTO,
  LIQUIDADO,
  LIQUIDADO_PARCIALMENTE,
  CANCELADO
}

String getStatusTitulo(EnumStatusTitulo statusTitulo) {
  switch (statusTitulo) {
    case EnumStatusTitulo.EM_ABERTO:
      return "Em aberto";

    case EnumStatusTitulo.LIQUIDADO:
      return "Liquidado";

    case EnumStatusTitulo.LIQUIDADO_PARCIALMENTE:
      return "Liquidado parcialmente";

    case EnumStatusTitulo.CANCELADO:
      return "Cancelado";
  }
}
