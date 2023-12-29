import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rakashkh/app/Palette.dart';
import 'package:rakashkh/app/globals.dart';
import 'package:rakashkh/utils/context_ext.dart';

enum LoaderPlatform { android, ios }

class NativeLoader extends StatelessWidget {
  final double scale;
  final Color? valueColor;
  final LoaderPlatform? platform;

  const NativeLoader({
    Key? key,
    this.scale = 1.0,
    this.valueColor,
    this.platform,
  }) : super(key: key);

  const NativeLoader.android({
    Key? key,
    this.valueColor = Palette.white,
    this.scale = 1.0,
  })  : platform = LoaderPlatform.android,
        super(key: key);

  const NativeLoader.ios({
    Key? key,
    this.valueColor,
    this.scale = 1.0,
  })  : platform = LoaderPlatform.ios,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isAndroidP = isAndroid;

    /// null = PlatformSpecific meaning native loader will be shown
    if (platform != null) {
      isAndroidP = platform == LoaderPlatform.android;
    }

    return Transform.scale(
      scale: scale,
      child: Center(
        child: isAndroidP
            ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(valueColor ?? context.primaryColor),
              )
            : const CupertinoActivityIndicator(),
      ),
    );
  }
}

class ApiLoader extends StatelessWidget {
  const ApiLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const NativeLoader.android();
  }
}
