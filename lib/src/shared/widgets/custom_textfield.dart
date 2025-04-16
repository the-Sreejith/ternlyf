import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/app_colors.dart';
import '../../theme/app_fonts.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final double? width, height;
  final int? maxLength;
  final String? floatingText, hintText, errorText;
  final TextStyle? floatingStyle;
  final void Function(String? value)? onSaved, onChanged;
  final Widget? prefix, suffix;
  final bool showCursor;
  final bool? enabled;
  final bool multiline;
  final bool expands;
  final bool readOnly;
  final bool autofocus;
  final bool showErrorBorder;
  final bool showFocusedBorder;
  final BorderSide border;
  final TextAlign textAlign;
  final TextAlignVertical textAlignVertical;
  final Alignment errorAlign, floatingAlign;
  final Color? fillColor, focusColor;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String? value)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final bool fillColorState;
  final Color focusBorderColor, unFocusBorderColor;
  final double fontSize;

  const CustomTextField({
    super.key,
    this.controller,
    this.width,
    this.maxLength,
    this.floatingText,
    this.floatingStyle,
    this.onSaved,
    this.onChanged,
    this.prefix,
    this.suffix,
    this.enabled,
    this.keyboardType,
    this.textInputAction,
    this.hintText,
    this.validator,
    this.height = 47,
    this.readOnly = false,
    this.showFocusedBorder = true,
    this.multiline = false,
    this.expands = false,
    this.showCursor = true,
    this.showErrorBorder = false,
    this.autofocus = false,
    this.textAlign = TextAlign.start,
    this.border = BorderSide.none,
    this.textAlignVertical = TextAlignVertical.center,
    this.errorAlign = Alignment.centerRight,
    this.floatingAlign = Alignment.centerLeft,
    this.fillColor = AppColors.bg,
    this.focusColor = Colors.white,
    this.inputFormatters,
    this.fillColorState = false,
    this.focusBorderColor = AppColors.primaryColor,
    this.unFocusBorderColor = AppColors.bg,
    this.fontSize = 14,
    this.errorText
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late FocusNode _myFocusNode;
  final ValueNotifier<bool> _myFocusNotifier = ValueNotifier<bool>(false);

  String? errorText;

  bool hidePassword = true;

  bool get hasError => errorText != null;

  bool get showErrorBorder => widget.showErrorBorder && hasError;

  bool get hasFloatingText => widget.floatingText != null;

  bool get isPasswordField => widget.keyboardType == TextInputType.visiblePassword;

  @override
  void initState() {
    super.initState();

    _myFocusNode = FocusNode();
    _myFocusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _myFocusNode.removeListener(_onFocusChange);
    _myFocusNode.dispose();
    _myFocusNotifier.dispose();

    super.dispose();
  }

  void _onFocusChange() {
    _myFocusNotifier.value = _myFocusNode.hasFocus;
  }


  void _onSaved(String? value) {
    final trimmedValue = value!.trim();
    widget.controller?.text = trimmedValue;
    widget.onSaved?.call(trimmedValue);
  }

  void _onChanged(String value) {
    if (widget.onChanged != null) {
      _runValidator(value);
      widget.onChanged!(value);
    }
  }

  String? _runValidator(String? value) {
    final error = widget.validator?.call(value!.trim());
    setState(() {
      errorText = error;
    });
    return error;
  }

  void _togglePasswordVisibility() {
    setState(() {
      hidePassword = !hidePassword;
    });
  }


  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _myFocusNotifier,
      builder: (_, isFocus, child) {
        return TextFormField(
          focusNode: _myFocusNode,
          controller: widget.controller,
          textAlign: widget.textAlign,
          textAlignVertical: widget.textAlignVertical,
          autofocus: widget.autofocus,
          maxLength: widget.maxLength,
          enabled: widget.enabled,
          expands: widget.expands,
          readOnly: widget.readOnly,
          maxLines: widget.multiline ? 12 : 1,
          minLines: widget.multiline ? 6 : 1,
          enableInteractiveSelection: false,
          keyboardType: widget.keyboardType ?? (widget.multiline ? TextInputType.multiline : null),
          textInputAction: widget.textInputAction ?? (widget.multiline ? TextInputAction.newline : null),
          showCursor: widget.showCursor,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          autovalidateMode: AutovalidateMode.disabled,
          cursorColor: AppColors.primaryColor,
          obscureText: isPasswordField && hidePassword,
          validator: _runValidator,
          onFieldSubmitted: _runValidator,
          onSaved: _onSaved,
          onChanged: _onChanged,
          inputFormatters: widget.inputFormatters,
          style: TextStyle(
            fontSize: 16,
            color: AppColors.black,
            fontWeight: FontWeight.w400,
            fontFamily: AppFonts.radioCanadaBig,
          ),
          decoration: InputDecoration(
            hintText: widget.hintText,
            alignLabelWithHint: true,
            fillColor: isFocus ? widget.focusColor : widget.fillColor,
            prefixIcon: widget.prefix,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            isDense: true,
            filled: widget.fillColorState,
            counterText: '',
            labelStyle: TextStyle(
              fontSize: 16,
              color: AppColors.black,
              fontWeight: FontWeight.w400,
              fontFamily: AppFonts.radioCanadaBig,
            ),
            hintStyle: TextStyle(
              fontSize: 16,
              color: AppColors.black,
              fontWeight: FontWeight.w400,
              fontFamily: AppFonts.radioCanadaBig,
            ),
            errorStyle: TextStyle(
              fontSize: 16,
              color: Colors.red,
              fontWeight: FontWeight.w400,
              fontFamily: AppFonts.radioCanadaBig,
            ),
            errorText: widget.errorText,
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.black, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(36)),
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(36)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.black, width: 2),
              borderRadius: const BorderRadius.all(Radius.circular(36)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.black, width: 2),
              borderRadius: const BorderRadius.all(Radius.circular(36)),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.black, width: 2),
              borderRadius: const BorderRadius.all(Radius.circular(36)),
            ),
            contentPadding: const EdgeInsets.all(16),
            suffixIcon: widget.suffix ?? (isPasswordField
              ? IconButton(
                  onPressed: _togglePasswordVisibility,
                  icon: Icon(!hidePassword
                    ? Icons.visibility
                    : Icons.visibility_off
                    , color: Colors.black, size: 20,),
                )
              : null),
          ),
        );
      }
    );
  }
}
