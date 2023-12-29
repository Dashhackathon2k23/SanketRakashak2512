import 'dart:core';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:rakashkh/app/Palette.dart';
import 'package:rakashkh/app/globals.dart';

import 'package:rakashkh/utils/context_ext.dart';
import 'package:rakashkh/widgets/native_loader.dart';
import 'package:rakashkh/widgets/text_widget.dart';
import 'package:stacked_services/stacked_services.dart';


CancelFunc? loading;

void showLoader({String? request, Duration? timeout, bool showLogo = false}) {
  loading = BotToast.showCustomLoading(
    backgroundColor: Colors.black54,
    toastBuilder: (func) {
      return const NativeLoader.android();
    },
    duration: timeout,
    backButtonBehavior: BackButtonBehavior.ignore,

    onClose: () {},
  );
}

void hideLoader() => loading?.call();

Future<dynamic> showConfirmationDialog({
  required String title,
  required String message,
  String? confirmText,
  bool barrierDismissible = false,
}) async {
  final context = StackedService.navigatorKey!.currentContext!;

  /// goto choose type of contribution screen
  final result = await showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (_) => AlertDialog(
      backgroundColor: context.backgroundColor,
      title: Texts(
        title,
        style: context.titleMediumBold,
      ),
      content: Texts(
        message,
        style: context.label15,
      ),
      actions: [
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: Colors.grey[400],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(BR10),
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: Texts(
            "Cancel",
            style: context.label15?.copyWith(color: Palette.white),
          ),
        ),
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: context.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(BR10),
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: Texts(
            confirmText ?? "Confirm",
            style: context.label15?.copyWith(color: Palette.white),
          ),
        ),
      ],
    ),
  );

  return result;
}

Future<dynamic> showInfoDialog({
  required String title,
  required String message,
  bool barrierDismissible = false,
}) async {
  final context = StackedService.navigatorKey!.currentContext!;

  /// goto choose type of contribution screen
  final type = await showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (_) => AlertDialog(
      backgroundColor: context.backgroundColor,
      title: Texts(
        title,
        style: context.titleMediumBold,
      ),
      content: Texts(
        message,
        style: context.label15,
      ),
      actions: [
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: context.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(BR10),
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Texts(
            "OK",
            style: context.label15?.copyWith(color: Palette.white),
          ),
        ),
      ],
    ),
  );

  return type;
}

Future<void> showSnackbar([String? msg, BuildContext? context, Color? color]) async {
  ScaffoldMessenger.of(context ?? StackedService.navigatorKey!.currentContext!).showSnackBar(
    SnackBar(
      backgroundColor: color,
      content: Texts(
        msg ?? somethingWentWrongM,
        style: const TextStyle(color: Colors.white),
      ),
      duration: const Duration(milliseconds: 2000),
    ),
  );
}

Future<void> showSuccessSnackbar([String? msg, BuildContext? context, Duration? duration]) async {
  ScaffoldMessenger.of(context ?? StackedService.navigatorKey!.currentContext!).showSnackBar(
    SnackBar(
      backgroundColor: Colors.green,
      content: Texts(
        msg ?? somethingWentWrongM,
        style: const TextStyle(color: Colors.white),
      ),
      duration: duration ?? const Duration(milliseconds: 2000),
    ),
  );
}

Future<void> showErrorSnackbar([String? msg, bool? floating]) async {
  SchedulerBinding.instance.addPostFrameCallback((timestamp) {
    ScaffoldMessenger.of(StackedService.navigatorKey!.currentContext!).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        behavior: floating == true ? SnackBarBehavior.floating : null,
        content: Texts(
          msg ?? somethingWentWrongM,
          style: const TextStyle(color: Colors.white),
        ),
        duration: const Duration(milliseconds: 2000),
      ),
    );
  });
}

void showNotification(
  String? message, {
  bool isError = true,
  VoidCallback? onTap,
}) {
  BotToast.showNotification(
    align: Alignment.topCenter,
    title: (function) {
      if (isError) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Texts(message),
        );
      }

      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Texts(message),
      );
    },
    duration: const Duration(seconds: 4),
  );
}

Future<dynamic> showMyBottomSheet({
  required BuildContext context,
  required WidgetBuilder builder,
  Color? backgroundColor,
}) async {
  return await showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(BR10),
      ),
    ),
    enableDrag: true,
    isDismissible: true,
    backgroundColor: backgroundColor ?? Colors.transparent,
    builder: builder,
  );
}
