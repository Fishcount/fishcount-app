enum EnumTipoTelefone {
  PRINCIPAL,
  ADICIONAL,
}

class EnumTipoTelefoneHelper {
  EnumTipoTelefone getEnum(String enumValue) {
    switch (enumValue) {
      case "PRINCIPAL":
        return EnumTipoTelefone.PRINCIPAL;

      case "ADICIONAL":
        return EnumTipoTelefone.ADICIONAL;

      default:
        return EnumTipoTelefone.ADICIONAL;
    }
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
}
