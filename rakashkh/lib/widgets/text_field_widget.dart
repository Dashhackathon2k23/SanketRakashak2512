import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rakashkh/app/globals.dart';
import 'package:rakashkh/utils/context_ext.dart';

import 'text_widget.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextInputType? textInputType;
  final String? hintText;
  final TextDirection? hintTextDirection;
  final TextStyle? hintStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? defaultText;
  final String? errorText;
  final String? fontFamily;
  final FocusNode? focusNode;
  final bool? isObscure;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final TextInputAction? textInputAction;
  final ValueChanged<String?>? onSaved;
  final ValueChanged<String>? onFieldSubmitted;
  final Function? onFieldTap;
  final Function(String)? onChanged;
  final String? label;
  final String? richS1;
  final String? richS2;
  final bool? hasDecoration;
  final int? minLines;
  final int? maxLines;
  final bool readOnly;
  final bool? enabled;
  final bool? autoFocus;
  final bool? filled;
  final Color? filledColor;
  final Color? labelColor;
  final bool? hasFocus;
  final bool? isRequired;
  final String? obscureSymbol;
  final InputBorder? border;
  final InputBorder? errorBorder;
  final InputBorder? focusedBorder;
  final InputBorder? focusedErrorBorder;
  final InputBorder? enabledBorder;
  final InputBorder? disabledBorder;
  final bool? wantListeners;
  final Function(bool)? onFocusChange;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final bool? showCursor;
  final bool? showCounter;
  final EdgeInsetsGeometry? contentPadding;
  final TextAlign? textAlign;
  final TextCapitalization textCapitalization;
  final bool? autoCorrect;
  final bool? enableSuggestions;
  final TextStyle? style;
  final AutovalidateMode? autovalidateMode;

  const TextFormFieldWidget({
    this.controller,
    Key? key,
    this.hintText,
    this.hintTextDirection,
    this.hintStyle,
    this.focusNode,
    this.textInputType,
    this.defaultText,
    this.fontFamily,
    this.errorText,
    this.isObscure = false,
    this.validator,
    this.textInputAction = TextInputAction.next,
    this.onSaved,
    this.onFieldSubmitted,
    this.onFieldTap,
    this.onChanged,
    this.prefixIcon,
    this.suffixIcon,
    this.label,
    this.richS1 = '',
    this.richS2 = '',
    this.hasDecoration = true,
    this.minLines = 1,
    this.maxLines = 1,
    this.readOnly = false,
    this.enabled = true,
    this.autoFocus = false,
    this.filled = false,
    this.filledColor = Colors.white,
    this.labelColor,
    this.hasFocus = false,
    this.isRequired = false,
    this.showCursor,
    this.obscureSymbol,
    this.border,
    this.errorBorder,
    this.focusedBorder,
    this.focusedErrorBorder,
    this.enabledBorder,
    this.disabledBorder,
    this.wantListeners = false,
    this.onFocusChange,
    this.inputFormatters,
    this.maxLength,
    this.showCounter,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 17.0, vertical: 16.0),
    this.textAlign,
    this.textCapitalization = TextCapitalization.none,
    this.style,
    this.autoCorrect = true,
    this.enableSuggestions = true,
    this.autovalidateMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var roundedBorder = OutlineInputBorder(
      borderSide: BorderSide(color: context.lightGreyColor!, width: 1),
      borderRadius: BorderRadius.circular(BR10),
    );

    Color filledColorDynamic = context.isDark ?Colors.white38 : Colors.white70;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          showCursor: showCursor,
          autovalidateMode: autovalidateMode,
          autocorrect: autoCorrect!,
          cursorColor: Theme.of(context).primaryColor,
          obscureText: isObscure!,
          keyboardType: textInputType,
          textInputAction: textInputAction,
          focusNode: focusNode,
          readOnly: readOnly,
          enabled: enabled,
          autofocus: autoFocus!,
          enableSuggestions: enableSuggestions!,
          textCapitalization: textCapitalization,
          style: style ?? context.titleSmall,
          strutStyle: const StrutStyle(
            fontSize: 15.0,
            forceStrutHeight: true,
          ),
          initialValue: defaultText,
          onChanged: onChanged,
          minLines: minLines,
          maxLines: maxLines,
          keyboardAppearance: Theme.of(context).brightness,
          textAlign: textAlign ?? TextAlign.start,
          buildCounter: (context, {int? currentLength, int? maxLength, bool? isFocused}) => null,
          decoration: InputDecoration(
            enabled: true,
            // alignLabelWithHint: true,
            // labelText: "email",

            // label: Texts(
            //   label!,
            //   style: TextStyle(
            //     color: Palette.grey,
            //     fontSize: 17,
            //   ),
            //   //style: context.labelSmall?.copyWith(color: labelColor ?? context.textColor),
            // ),
            suffixIcon: suffixIcon,

            // prefix: prefixIcon,

            // suffix: suffixIcon,
            prefixIcon: prefixIcon,
            filled: filled,
            fillColor: filled! ? filledColorDynamic : null,
            hintText: hintText,
            hintTextDirection: hintTextDirection,
            hintStyle: hintStyle,
            border: hasDecoration! ? border ?? roundedBorder : InputBorder.none,
            errorBorder: hasDecoration!
                ? errorBorder ??
                    OutlineInputBorder(
                      borderRadius: BorderRadius.circular(BR10),
                      borderSide:  const BorderSide(color:Colors.red)
                    )
                : InputBorder.none,
            focusedBorder: hasDecoration!
                ? focusedBorder ??
                    OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(BR10),
                    )
                : null,
            focusedErrorBorder: hasDecoration!
                ? focusedErrorBorder ??
                    OutlineInputBorder(
                      borderRadius: BorderRadius.circular(BR10),
                      borderSide: const BorderSide(color: Colors.red),
                    )
                : InputBorder.none,
            enabledBorder: hasDecoration!
                ? enabledBorder ??
                    OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(BR10),
                    )
                : InputBorder.none,
            disabledBorder: hasDecoration!
                ? disabledBorder ??
                    OutlineInputBorder(
                      borderRadius: BorderRadius.circular(BR10),
                      borderSide: BorderSide(color: Colors.grey),
                    )
                : InputBorder.none,
            contentPadding: contentPadding,
            isDense: true,
            errorText: errorText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            errorMaxLines: 2,
            errorStyle: Texts.customTextStyle(
              color: Colors.red,
              fontSize: 12.0,
              shadows: <Shadow>[
                const Shadow(
                  offset: Offset(1.0, 1.0),
                  blurRadius: 5.0,
                  color: Colors.black38,
                ),
                // const Shadow(
                //   offset: Offset(10.0, 10.0),
                //   blurRadius: 8.0,
                //   color: Color.fromARGB(125, 0, 0, 255),
                // ),
              ],
            ),
          ),
          controller: controller,
          validator: validator,
          maxLength: maxLength,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          inputFormatters: inputFormatters,
          onSaved: onSaved,
          onFieldSubmitted: onFieldSubmitted,
          onTap: () {
            if (onFieldTap != null) onFieldTap?.call();
          },
        ),
      ],
    );
  }
}

void changeFocus(BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}

class EnsureVisible extends StatefulWidget {
  final Widget child;

  const EnsureVisible({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  EnsureVisibleState createState() => EnsureVisibleState();
}

class EnsureVisibleState extends State<EnsureVisible> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.focusManager.addListener(autoScroll);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    WidgetsBinding.instance.focusManager.removeListener(autoScroll);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    // autoScroll();
  }

  @override
  Widget build(BuildContext context) => widget.child;

  void autoScroll() async {
    var focussedNode = WidgetsBinding.instance.focusManager.primaryFocus;
    if (focussedNode != null) {
      var v = focussedNode.context?.findAncestorWidgetOfExactType<EnsureVisible>();
      if (v == widget) {
        // Flutter ALSO tries to adjust the focus / scroll
        await Future.delayed(
          const Duration(
            milliseconds: 50,
          ),
        );
        // Make sure it's not past the bottom
        if (mounted) {
          Scrollable.ensureVisible(
            context,
            alignmentPolicy: ScrollPositionAlignmentPolicy.keepVisibleAtEnd,
          );
          // // ...nor the top
          Scrollable.ensureVisible(
            context,
            alignmentPolicy: ScrollPositionAlignmentPolicy.keepVisibleAtStart,
          );
        }
      }
    }
  }
}
