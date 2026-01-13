import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Common text field widget with consistent styling
/// Supports validation, icons, and various input types
class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? errorText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final int? maxLines;
  final int? maxLength;
  final bool enabled;
  final bool readOnly;
  final TextCapitalization textCapitalization;

  const AppTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.maxLines = 1,
    this.maxLength,
    this.enabled = true,
    this.readOnly = false,
    this.textCapitalization = TextCapitalization.none,
  });

  const AppTextField.email({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.errorText,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.enabled = true,
  })  : prefixIcon = Icons.email_outlined,
        suffixIcon = null,
        obscureText = false,
        keyboardType = TextInputType.emailAddress,
        inputFormatters = null,
        maxLines = 1,
        maxLength = null,
        readOnly = false,
        textCapitalization = TextCapitalization.none;

  const AppTextField.password({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.errorText,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.enabled = true,
  })  : prefixIcon = Icons.lock_outlined,
        obscureText = true,
        keyboardType = null,
        inputFormatters = null,
        maxLines = 1,
        maxLength = null,
        readOnly = false,
        textCapitalization = TextCapitalization.none;

  const AppTextField.multiline({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.errorText,
    this.prefixIcon,
    this.onChanged,
    this.validator,
    this.maxLines = 5,
    this.maxLength,
    this.enabled = true,
  })  : suffixIcon = null,
        obscureText = false,
        keyboardType = TextInputType.multiline,
        inputFormatters = null,
        onSubmitted = null,
        readOnly = false,
        textCapitalization = TextCapitalization.sentences;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        errorText: errorText,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        suffixIcon: suffixIcon,
        border: const OutlineInputBorder(),
        filled: !enabled,
      ),
      obscureText: obscureText,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      validator: validator,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      maxLines: obscureText ? 1 : maxLines,
      maxLength: maxLength,
      enabled: enabled,
      readOnly: readOnly,
      textCapitalization: textCapitalization,
    );
  }
}
