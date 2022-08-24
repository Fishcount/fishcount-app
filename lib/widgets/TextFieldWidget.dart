import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class TextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final Icon? prefixIcon;
  final Color focusedBorderColor;
  final Color iconColor;
  final bool obscureText;
  final TextInputType? keyBoardType;
  final MaskTextInputFormatter? inputMask;
  final String? labelText;

  const TextFieldWidget(
      {Key? key,
      required this.controller,
      required this.hintText,
      required this.focusedBorderColor,
      required this.iconColor,
      required this.obscureText,
      this.prefixIcon,
      this.keyBoardType,
      this.inputMask,
      this.labelText})
      : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: [
        widget.inputMask != null
            ? widget.inputMask!
            : FilteringTextInputFormatter.singleLineFormatter
      ],
      controller: widget.controller,
      obscureText: widget.obscureText,
      keyboardType: widget.keyBoardType,
      autofocus: false,
      decoration: InputDecoration(
        labelText: widget.labelText,
        filled: true,
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon,
        prefixIconColor: widget.iconColor,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            style: BorderStyle.none,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: widget.focusedBorderColor,
            style: BorderStyle.solid,
          ),
        ),
      ),
    );
  }
}
