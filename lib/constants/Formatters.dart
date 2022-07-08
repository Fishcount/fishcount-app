import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Formatters {

  static final MaskTextInputFormatter phoneMask = MaskTextInputFormatter(
      mask: '+55 (##) #####-####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy,
  );

  static final MaskTextInputFormatter cpfFormat = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );
}
