import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class TextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final Function(String)? onChanged;
  final Color focusedBorderColor;
  final Color iconColor;
  final bool obscureText;
  final String? errorText;
  final Icon? prefixIcon;
  final bool? isPassword;
  final TextInputType? keyBoardType;
  final MaskTextInputFormatter? inputMask;
  final String? labelText;

  const TextFieldWidget({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.focusedBorderColor,
    required this.iconColor,
    required this.obscureText,
    this.errorText,
    this.prefixIcon,
    this.isPassword = false,
    this.keyBoardType,
    this.inputMask,
    this.labelText,
    this.onChanged,
  }) : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: [
        widget.inputMask != null
            ? widget.inputMask!
            : FilteringTextInputFormatter(RegExp(r'[a-z\d A-Z0-9.@_-]'), allow: true)
      ],
      controller: widget.controller,
      obscureText: widget.isPassword != null && widget.isPassword!
          ? _isObscure
          : widget.obscureText,
      keyboardType: widget.keyBoardType,
      autofocus: false,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        errorText: widget.controller.text.isEmpty ? widget.errorText : null,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide:
              const BorderSide(style: BorderStyle.solid, color: Colors.red),
        ),
        labelText: widget.labelText,
        filled: true,
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon,
        prefixIconColor: widget.iconColor,
        suffixIcon: _handlePasswordField(),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            style: BorderStyle.none,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: Colors.black,
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

  GestureDetector? _handlePasswordField() {
    return widget.isPassword != null && widget.isPassword!
        ? _isObscure
            ? GestureDetector(
                child: const Icon(Icons.visibility_off),
                onTap: () => setState(() => _isObscure = false),
              )
            : GestureDetector(
                child: const Icon(Icons.visibility),
                onTap: () => setState(() => _isObscure = true),
              )
        : null;
  }
}
