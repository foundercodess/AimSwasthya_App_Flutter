import 'package:flutter/material.dart';

class TextConst extends StatelessWidget {
  final String title;
  final double? size;
  final String? fontFamily;
  final FontWeight? fontWeight;
  final Color? color;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final EdgeInsetsGeometry? padding;
  final TextDecoration? decoration;
  final Color? decorationColor;
  final List<FontVariation>? fontVariations;
  final int? maxLines;

  TextConst(
    this.title, {
    super.key,
    this.size,
    this.fontWeight,
    this.color,
    this.overflow,
    this.textAlign,
    this.padding,
    this.fontFamily,
    this.decoration,
    this.decorationColor,
    this.fontVariations, this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(0),
      child: Text(
        title,
        textAlign: textAlign,
        maxLines: maxLines??null,
        style: TextStyle(
          fontVariations: fontVariations,
          overflow: overflow,
          fontFamily: fontFamily ?? 'Poppins',
          color: color ?? Colors.black,
          fontSize: size ?? 16.0,
          fontWeight: fontWeight ?? FontWeight.w400,
          decoration: decoration ?? TextDecoration.none,
          decorationColor: decorationColor ?? Colors.black, // Underline color
        ),
      ),
    );
  }
}


class ConstText extends StatelessWidget {
  final String? title;
  final double? size;
  final String? fontFamily;
  final FontWeight? fontWeight;
  final Color? color;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final EdgeInsetsGeometry? padding;
  final TextDecoration? decoration;
  final Color? decorationColor;
  final List<FontVariation>? fontVariations;

  const ConstText(
      {super.key,
      required this.title,
      this.size,
      this.fontFamily,
      this.fontWeight,
      this.color,
      this.overflow,
      this.textAlign,
      this.padding,
      this.decoration,
      this.decorationColor,
      this.fontVariations});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(0),
      child: Text(
        title ?? "Data not found",
        textAlign: textAlign,
        style: TextStyle(
          fontVariations: fontVariations,
          overflow: overflow,
          fontFamily: fontFamily ?? 'Poppins',
          color: color ?? Colors.grey,
          fontSize: size ?? 12.0,
          fontWeight: fontWeight ?? FontWeight.w500,
          decoration: decoration ?? TextDecoration.none,
          decorationColor: decorationColor ?? Colors.grey, // Underline color
        ),
      ),
    );
  }
}

class ImageContainer extends StatelessWidget {
  final double height;
  final BoxFit fit;
  final String imagePath;

  const ImageContainer({
    super.key,
    required this.imagePath,
    this.height = 160,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: height,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: fit,
        ),
      ),
    );
  }
}
