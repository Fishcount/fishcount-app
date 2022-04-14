enum EnumTipoEmail {
  PRINCIPAL,
  ADICIONAL,
  COMERCIAL,
}

String getTipoEmail(EnumTipoEmail tipoEmail) {
  switch (tipoEmail) {
    case EnumTipoEmail.PRINCIPAL:
      return "Principal";

    case EnumTipoEmail.ADICIONAL:
      return "Adicional";

    case EnumTipoEmail.COMERCIAL:
      return "Comercial";

    default:
      return "Enum Não encontrada.";
  }
}
