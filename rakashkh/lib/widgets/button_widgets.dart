import 'package:flutter/material.dart';


import '../app/Palette.dart';
import '../app/globals.dart';
import 'text_widget.dart';

const button35 = 36.0;
const button45 = 46.0;
const button50 = 50.0;

class FilledButtons extends StatelessWidget {
  final GestureTapCallback? onTap;
  final String text;
  final Color textColor;
  final Color color;

  /// By default it will take border radius of 30
  /// which means its rounded button by default
  final double? borderRadius;
  final double? width;
  final double? height;
  final double? elevation;
  final Color? borderSideColor;
  final Widget? leading;
  final Widget? trailing;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final double? fontSize;
  final double? borderWidth;
  final bool? isDisabled;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final InteractiveInkFeatureFactory? splashFactory;
  final bool applyGradient;
  final bool useExpanded;
  final bool isLoading;

  const FilledButtons({
    Key? key,
    required this.onTap,
    required this.text,
    this.textColor = Colors.white,
    this.color = Palette.white,
    this.borderRadius = 10.0,
    this.width,
    this.height = button50,
    this.elevation,
    this.borderSideColor,
    this.leading,
    this.trailing,
    this.fontWeight = FontWeight.bold,
    this.fontFamily,
    this.fontSize = 17.0,
    this.isDisabled = false,
    this.padding,
    this.margin,
    this.borderWidth = 0.0,
    this.splashFactory,
    this.applyGradient = true,
    this.useExpanded = true,
    this.isLoading =false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textWidget = isLoading?Center(child: const CircularProgressIndicator(color: Palette.commoncolor,)):
    Texts(
      text,
      color: textColor,
      fontSize: fontSize!,
      letterSpacing: 1,
      fontFamily: fontFamily,
      fontWeight: fontWeight!,
      textAlign: TextAlign.center,
    );

    return FilledButton(
      onPressed: onTap,
      autofocus: false,
      style: FilledButton.styleFrom(
        backgroundColor: color,
        shadowColor: Colors.transparent,
        padding: padding,
        elevation: elevation,
        alignment: Alignment.center,
        splashFactory: splashFactory,
        fixedSize: Size(width ?? screenWidth, height!),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius!),
          side: BorderSide(color: borderSideColor ?? Palette.white, width: borderWidth!),
        ),
      ),
      child: SizedBox(
        width: width ?? screenWidth,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            leading ?? const SizedBox(),
            if (useExpanded) Expanded(child: textWidget) else textWidget,
            trailing ?? const SizedBox(),
          ],
        ),
      ),
    );
  }
}

class BorderButton extends StatelessWidget {
  final GestureTapCallback? onTap;
  final String text;
  final Color textColor;
  final Color color;
  final double? borderRadius;
  final double? width;
  final double? height;
  final double? elevation;
  final Color? borderSideColor;
  final Widget? leading;
  final Widget? trailing;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final double? fontSize;
  final double? borderWidth;
  final bool? isDisabled;
  final bool useExpanded;
  final EdgeInsetsGeometry? padding;

  const BorderButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.color = Colors.white,
    this.textColor = Palette.white,
    this.borderRadius = 30.0,
    this.width,
    this.height = button45,
    this.elevation = 0.0,
    this.borderSideColor = Palette.white
    ,
    this.leading,
    this.trailing,
    this.fontWeight = FontWeight.w700,
    this.fontFamily,
    this.fontSize = 16.0,
    this.padding,
    this.borderWidth = 1.0,
    this.isDisabled,
    this.useExpanded = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textWidget = Texts(
      text,
      color: textColor,
      fontSize: fontSize!,
      letterSpacing: 1,
      fontFamily: fontFamily,
      fontWeight: fontWeight!,
      textAlign: TextAlign.center,
    );
    return OutlinedButton(
      onPressed: onTap,
      autofocus: false,
      style: OutlinedButton.styleFrom(
        backgroundColor: color,
        padding: padding,
        elevation: elevation,
        alignment: Alignment.center,
        fixedSize: Size(width ?? screenWidth, height!),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius!),
          side: BorderSide(color: borderSideColor ?? color, width: borderWidth!),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          leading ?? const SizedBox(),
          if (useExpanded) Expanded(child: textWidget) else textWidget,
          trailing ?? const SizedBox(),
        ],
      ),
    );
  }
}

class EmptyButton extends StatelessWidget {
  final GestureTapCallback onTap;
  final String text;
  final Color textColor;
  final Color color;
  final Widget? leading;
  final Widget? trailing;
  final String? fontFamily;
  final double? width;
  final double? height;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? borderRadius;
  final Color? borderSideColor;
  final EdgeInsetsGeometry? padding;

  const EmptyButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.color = Colors.white,
    this.textColor = Palette.white,
    this.leading,
    this.trailing,
    this.fontFamily,
    this.fontWeight = FontWeight.w700,
    this.borderRadius = 30.0,
    this.borderSideColor,
    this.width,
    this.height = button45,
    this.fontSize = 16.0,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      autofocus: false,
      style: TextButton.styleFrom(
        backgroundColor: color,
        fixedSize: Size(width ?? screenWidth, height!),
        alignment: Alignment.center,
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius!),
          side: BorderSide(color: borderSideColor ?? color),
        ),
      ),
      child: Texts(
        text,
        color: textColor,
        fontSize: fontSize!,
        letterSpacing: 1,
        fontFamily: fontFamily,
        fontWeight: fontWeight!,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class CircleButton extends StatelessWidget {
  final Widget icon;
  final double? width;
  final double? height;
  final Color? color;
  final VoidCallback? onTap;

  const CircleButton({
    Key? key,
    required this.icon,
    this.onTap,
    this.width = 35,
    this.height = 35,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        width: width!,
        height: height!,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color ?? Theme.of(context).primaryColor,
          shape: BoxShape.circle,
          boxShadow: const [
            BoxShadow(color: Colors.grey),
          ],
        ),
        child: icon,
      ),
    );
  }
}
