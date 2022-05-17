

enum EnumTipoEmail {
  PRINCIPAL,
  ADICIONAL,
  COMERCIAL,
}

class EnumTipoEmailHelper{

  EnumTipoEmail getEnum(String enumValue) {
    switch (enumValue) {
      case "PRINCIPAL":
        return EnumTipoEmail.PRINCIPAL;

      case "ADICIONAL":
        return EnumTipoEmail.ADICIONAL;

      case "COMERCIAL":
        return EnumTipoEmail.COMERCIAL;

      default:
        return EnumTipoEmail.ADICIONAL;
    }
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
}
