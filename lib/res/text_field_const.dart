import 'package:aim_swasthya/res/color_const.dart';
import 'package:aim_swasthya/res/size_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final InputDecoration? decoration = const InputDecoration();
  final TextStyle? style;
  final String? fontFamily;
  final StrutStyle? strutStyle;
  final TextAlign textAlign = TextAlign.start;
  final TextAlignVertical? textAlignVertical;
  final TextDirection? textDirection;
  final bool readOnly = false;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final Widget? icon;
  final Color? iconColor;
  final String? hintText;
  final String? labelText;
  final bool? filled;
  final Color? fillColor;
  final Color? focusColor;
  final Color? hoverColor;
  final void Function(String)? onChanged;
  final double? height;
  final double? width;
  final double? labelSize;
  final double? hintSize;
  final double? fontSize;
  final BoxBorder? border;
  final BorderRadiusGeometry? borderRadius;
  final List<BoxShadow>? boxShadow;
  final EdgeInsetsGeometry? contentPadding;
  final double? cursorHeight;
  final Color? cursorColor;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final BorderRadius? fieldRadius;
  final bool? enabled;
  final void Function()? onTap;
  final bool? autofocus;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final EdgeInsetsGeometry? margin;
  final Color? labelColor;
  final Color? hintColor;
  final String? errorText;
  final BorderSide? borderSide;
  final Color? textColor;
  final FontWeight? fontWeight;
  final FontWeight? hintWeight;
  final FontWeight? labelWeight;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;


  const CustomTextField({
    super.key,
    this.controller,
    this.labelText,
    this.style,
    this.strutStyle,
    this.textAlignVertical,
    this.textDirection,
    this.minLines,
    this.maxLength,
    this.obscureText=false,
    this.keyboardType,
    this.icon,
    this.iconColor,
    this.hintText,
    this.filled,
    this.fillColor,
    this.focusColor,
    this.hoverColor,
    this.onChanged,
    this.height,
    this.width,
    this.labelSize,
    this.hintSize,
    this.fontSize,
    this.border,
    this.borderRadius,
    this.boxShadow,
    this.contentPadding,
    this.cursorHeight,
    this.cursorColor,
    this.prefixIcon,
    this.suffixIcon,
    this.fieldRadius,
    this.enabled,
    this.maxLines,
    this.onTap,
    this.autofocus,
    this.onSaved,
    this.validator,
    this.margin,
    this.labelColor,
    this.hintColor,
    this.errorText,
    this.borderSide,
    this.textColor,
    this.fontWeight,
    this.labelWeight,
    this.hintWeight,
    this.textInputAction,
    this.focusNode,
    this.inputFormatters, this.fontFamily
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      focusNode: focusNode,
      inputFormatters: inputFormatters,
      textInputAction: textInputAction?? TextInputAction.done,
      validator: validator,
      onSaved: onSaved,
      autofocus: autofocus ?? false,
      textAlignVertical: TextAlignVertical.center,
      enabled: enabled,
      controller: controller,
      cursorColor: cursorColor,
      cursorHeight: cursorHeight,
      onChanged: onChanged,
      maxLines: maxLines,
      maxLength: maxLength,
      readOnly: readOnly,
      obscureText: obscureText!,
      keyboardType: keyboardType,
      style: style ?? TextStyle(
        fontFamily: 'Poppins-Bold',
        fontWeight: FontWeight.w500,
        fontSize: Sizes.fontSizeFive,

        color: AppColor.blue,
      ),
      decoration: InputDecoration(
        constraints: BoxConstraints(
          minHeight:height ??60,
          maxHeight:height ??60,
        ),
        labelText:labelText,
        labelStyle: TextStyle(
            fontSize: labelSize ?? 16,
            fontWeight: labelWeight??FontWeight.normal,
            color: labelColor ?? Colors.grey),
        errorText: errorText,
        counterText: "",
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        filled: filled ?? true,
        fillColor: fillColor ?? AppColor.white,
        hintText: hintText,
        hintStyle:
        TextStyle(
          fontFamily: "Poppins-Regular",
            fontSize: hintSize ?? 14,
            fontWeight: hintWeight??FontWeight.normal,
            color: hintColor ?? AppColor.textfieldTextColor),
        contentPadding: contentPadding ??
            const EdgeInsets.only(left: 10, right: 5, top: 16, bottom: 16),
        border: OutlineInputBorder(
            borderSide: borderSide == null
                ? const BorderSide(width: 0, color: AppColor.white)
                : borderSide!,
            borderRadius: fieldRadius == null
                ? const BorderRadius.all(Radius.circular(15))
                : fieldRadius!),
        focusedBorder: OutlineInputBorder(
            borderSide: borderSide == null
                ? BorderSide(width: 0, color: AppColor.white.withOpacity(0.5))
                : borderSide!,
            borderRadius: fieldRadius == null
                ? const BorderRadius.all(Radius.circular(15))
                : fieldRadius!),
        disabledBorder: OutlineInputBorder(
            borderSide: borderSide == null
                ? const BorderSide(width: 0, color:AppColor.white,)
                : borderSide!,
            borderRadius: fieldRadius == null
                ? const BorderRadius.all(Radius.circular(15))
                : fieldRadius!),
        enabledBorder: OutlineInputBorder(
            borderSide: borderSide == null
                ? const BorderSide(width: 0, color: AppColor.white)
                : borderSide!,
            borderRadius: fieldRadius == null
                ? const BorderRadius.all(Radius.circular(15))
                : fieldRadius!),
      ),
    );
  }
}