import 'package:flutter/material.dart';
import 'package:rakashkh/app/Palette.dart';

extension InclusibContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);

  bool get isLight => Theme.of(this).brightness == Brightness.light;

  bool get isDark => !isLight;

  TextTheme get textTheme => theme.textTheme;

  Color get primaryColor => theme.primaryColor;

  // Color? get shadowColor => isLight ? colorLightGrey : kGreyColor1;
  //
  // Color? get labelGrey => !isLight ? colorGrey : kGreyColor5;

  Color get backgroundColor => theme.colorScheme.background;

  // Color? get contentBackgroundColor => isLight ? colorGreyBackground : greyColor;

  // Color? get containerBackgroundColor => isLight ? contentBackgroundColor : colorLightGrey.withOpacity(0.3);

  // Color? get lightBackground => colorLightBackground;
  //
  // Color? get darkBackground => colorDarkBackground;

  // Color? get inverseBackgroundColor => isLight ? colorDarkBackground : colorLightBackground;

  Color? get greyColor => theme.textTheme.labelLarge?.color;

  Color? get lightGreyColor => theme.textTheme.bodyLarge?.color;

  // Color? get disabledColor => disabledGrayColor;
  //
  // Color? get borderColor => disabledGrayColor;

  Color? get textColor => theme.textTheme.titleMedium?.color;

  // Color? get cardColor => isDark ? lightGreyColor : kWhite;

  // Color? get lightTitleTextColor => kBlack;

  // Color? get lightLabelTextColor => colorGrey;

  TextStyle? get labelMedium => theme.textTheme.labelMedium;

  TextStyle? get labelMediumBold => theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold);

  TextStyle? get labelSmall => theme.textTheme.labelSmall;

  TextStyle? get labelSmallBold => theme.textTheme.labelSmall?.copyWith(fontWeight: FontWeight.bold);

  TextStyle? get labelExtraSmall => theme.textTheme.labelSmall?.copyWith(fontSize: 12);

  TextStyle? get labelLarge => theme.textTheme.labelLarge;

  TextStyle? get labelLargeBold => theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold);

  TextStyle? get titleExtraSmall => theme.textTheme.titleSmall?.copyWith(fontSize: 13);

  TextStyle? get title12 => theme.textTheme.titleSmall?.copyWith(fontSize: 12);

  TextStyle? get title12SmallBold => theme.textTheme.titleSmall?.copyWith(fontSize: 12, fontWeight: FontWeight.bold);

  TextStyle? get titleExtraSmallBold => theme.textTheme.titleSmall?.copyWith(fontSize: 13, fontWeight: FontWeight.bold);

  TextStyle? get titleSmall => theme.textTheme.titleSmall;

  TextStyle? get titleSmallBold => theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold);

  TextStyle? get body13Small => theme.textTheme.bodySmall?.copyWith(fontSize: 13);

  TextStyle? get body13SmallBold => theme.textTheme.bodySmall?.copyWith(fontSize: 13, fontWeight: FontWeight.bold);

  TextStyle? get bodyExtraSmall => theme.textTheme.bodySmall?.copyWith(fontSize: 12);

  TextStyle? get bodySmall => theme.textTheme.bodySmall;

  TextStyle? get bodySmallBold => theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold);

  TextStyle? get bodyMedium => theme.textTheme.bodyMedium;

  TextStyle? get bodyMediumBold => theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold);

  TextStyle? get body15 => bodyMedium?.copyWith(fontSize: 15);

  TextStyle? get body15Bold => body15?.copyWith(fontWeight: FontWeight.bold);

  TextStyle? get body16 => bodyMedium?.copyWith(fontSize: 16);

  TextStyle? get body16Bold => body16?.copyWith(fontWeight: FontWeight.bold);

  TextStyle? get titleMedium => theme.textTheme.titleMedium;

  TextStyle? get titleMediumBold => theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold);

  TextStyle? get titleLarge => theme.textTheme.titleLarge;

  TextStyle? get titleLargeBold => theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold);

  TextStyle? get titleLargeExtraBold => theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900);

  TextStyle? get title15 => theme.textTheme.titleMedium?.copyWith(fontSize: 15);

  TextStyle? get title16 => theme.textTheme.titleMedium?.copyWith(fontSize: 16);

  TextStyle? get title16Bold => theme.textTheme.titleMedium?.copyWith(fontSize: 16, fontWeight: FontWeight.bold);

  TextStyle? get title15Bold => theme.textTheme.titleMedium?.copyWith(fontSize: 15, fontWeight: FontWeight.bold);

  TextStyle? get label15 => theme.textTheme.labelMedium?.copyWith(fontSize: 15);

  TextStyle? get label15Bold => theme.textTheme.labelMedium?.copyWith(fontSize: 15, fontWeight: FontWeight.bold);

  TextStyle? get filledButtonPrimary =>
      label15?.copyWith(fontSize: 16, fontWeight: FontWeight.bold, color: Palette.white);

  TextStyle? get headlineSmall => textTheme.headlineSmall;

  TextStyle? get headlineSmallBold => textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold);

  TextStyle? get headlineMedium => textTheme.headlineMedium;

  TextStyle? get headlineMediumBold => textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold);

  TextStyle? get headlineLarge => textTheme.headlineLarge;

  TextStyle? get headlineLargeBold => textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold);

  TextStyle? get hintStyle => theme.textTheme.bodySmall?.copyWith(color: Colors.grey);

  TextStyle? get hintStyle2 => theme.textTheme.bodySmall?.copyWith(color: lightGreyColor);

  /// Returns same as MediaQuery.of(context)
  MediaQueryData get mq => MediaQuery.of(this);

  /// Returns if Orientation is landscape
  bool get isLandscape => mq.orientation == Orientation.landscape;
}
