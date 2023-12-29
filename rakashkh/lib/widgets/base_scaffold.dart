
import 'package:flutter/material.dart';

import 'package:rakashkh/app/Palette.dart';
import 'package:rakashkh/utils/context_ext.dart';
import 'package:rakashkh/widgets/text_widget.dart';

class BaseScaffold extends StatefulWidget {
  final bool isLeading;
  final bool hasAppbar;
  final bool hasBack;
  final bool centerTitle;
  final dynamic title;
  final Color? backgroundColor;
  final VoidCallback? onLeading;
  final bool? resizeToAvoidBottomInset;
  final Widget? floatingActionButton;

  final Widget child;
  final Widget? leading;
  final List<Widget>? actions;

  final Color? appBarColor;
  final bool hasNavBar;

  final bool applyShape;
  final bool extendBody;
  final bool extendBodyBehindAppBar;

  final FloatingActionButtonLocation? fabLocation;

  final TextStyle? titleStyle;

  final Widget? bottomNavigationBar;

  final double? toolbarHeight;
  final double? leadingWidth;

  const BaseScaffold({
    Key? key,
    required this.child,
    this.backgroundColor,
    this.isLeading = true,
    this.hasBack = false,
    this.centerTitle = true,
    this.title,
    this.actions,
    this.onLeading,
    this.hasAppbar = true,
    this.leading,
    this.resizeToAvoidBottomInset,
    this.floatingActionButton,
    this.appBarColor,
    this.hasNavBar = false,
    this.applyShape = false,
    this.fabLocation,
    this.titleStyle,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.bottomNavigationBar,
    this.toolbarHeight,
    this.leadingWidth,
  }) : super(key: key);

  @override
  BaseScaffoldState createState() => BaseScaffoldState();
}

class BaseScaffoldState extends State<BaseScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: widget.child,
      extendBody: widget.extendBody,
      extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
      floatingActionButton: widget.floatingActionButton,
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
      backgroundColor: widget.backgroundColor ?? context.theme.scaffoldBackgroundColor,
      floatingActionButtonLocation: widget.fabLocation,
      bottomNavigationBar: widget.bottomNavigationBar,
    );
  }

  Widget backButton() => BackButton(
        color: Palette.white,
        onPressed: widget.onLeading ??
            () {
              // hideKeyboard(context);
              Navigator.of(context).maybePop();
            },
      );

  AppBar? getAppBar() {
    if (!widget.hasAppbar) {
      return null;
    }
    // Color filledColorDynamic = context.isDark ? Palette.black.withOpacity(0.3) :Palette.accent;

    return AppBar(
      elevation: 0.0,
      toolbarHeight: widget.toolbarHeight,
      leadingWidth: widget.leadingWidth,
      centerTitle: widget.centerTitle,
      backgroundColor: widget.appBarColor,
          //?? filledColorDynamic,
      leading: widget.hasBack ? widget.leading ?? backButton() : const SizedBox(),
      title: widget.title == null
          ? null
          : widget.title is Widget
              ? widget.title
              : Transform.translate(
                  offset: const Offset(0.0, 2.0),
                  child: Texts(
                    widget.title ?? "",
                    style: widget.titleStyle ??
                        context.titleMediumBold ??
                        Texts.customTextStyle(
                          fontSize: 20.0,
                          color: Theme.of(context).appBarTheme.titleTextStyle?.color,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
      actions: [
        if (widget.actions != null) ...widget.actions!,
      ],
    );
  }
}
