enum EnumTipoTelefone {
  PRINCIPAL,
  ADICIONAL,
}

String getTipoTelefone(EnumTipoTelefone tipoTelefone) {
  switch (tipoTelefone) {
    case EnumTipoTelefone.PRINCIPAL:
      return "Principal";

    case EnumTipoTelefone.ADICIONAL:
      return "Adicional";
    default:
      return "Enum Não encontrada.";
  }
}
