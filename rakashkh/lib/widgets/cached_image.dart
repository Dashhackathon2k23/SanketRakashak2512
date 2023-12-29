import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rakashkh/widgets/native_loader.dart';


class CachedImage extends StatefulWidget {
  final String? imageUrl;
  final bool isRound;
  final double radius;
  final double? height;
  final double? width;

  final BoxFit fit;
  final String placeholder;
  final bool isLocal;

  final BorderRadius? borderRadius;

  const CachedImage(
    this.imageUrl, {
    Key? key,
    this.isRound = true,
    this.radius = 50.0,
    this.isLocal = false,
    this.height = 50.0,
    this.width = 50.0,
    this.fit = BoxFit.cover,
    this.placeholder = "",
    this.borderRadius,
  }) : super(key: key);

  @override
  State<CachedImage> createState() => _CachedImageState();
}

class _CachedImageState extends State<CachedImage> {
  final String noImageAvailable = "https://www.esm.rochester.edu/uploads/NoPhotoAvailable.jpg";

  @override
  Widget build(BuildContext context) {
    Widget placeHolderWidget = Container(
      height: widget.isRound ? widget.radius : widget.height,
      width: widget.isRound ? widget.radius : widget.width,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        shape: widget.isRound ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: !widget.isRound ? widget.borderRadius ?? BorderRadius.circular(5) : null,
      ),
      child: const Center(
        child: Opacity(
          opacity: 0.25,
          child: NativeLoader.android(),
          // child: Image.asset(
          //   "",
          //   width: (widget.width ?? 50) * 0.4,
          //   height: (widget.height ?? 50) * 0.4,
          //   color: Colors.grey[300],
          //   colorBlendMode: BlendMode.saturation,
          // ),
        ),
      ),
    );

    try {
      if (widget.isLocal) {
        return Container(
          height: widget.isRound ? widget.radius : widget.height,
          width: widget.isRound ? widget.radius : widget.width,
          decoration: BoxDecoration(
            shape: widget.isRound ? BoxShape.circle : BoxShape.rectangle,
            image: DecorationImage(
              image: AssetImage(widget.placeholder),
              fit: BoxFit.cover,
            ),
          ),
          child: ClipOval(
            child: Image.file(
              File(widget.imageUrl!),
              fit: widget.fit,
              height: widget.isRound ? widget.radius : widget.height,
              width: widget.isRound ? widget.radius : widget.width,
            ),
          ),
        );
      }

      if (widget.imageUrl == null) {
        return ClipRRect(
          key: ValueKey(widget.imageUrl),
          borderRadius: widget.borderRadius ?? BorderRadius.circular(5),
          child: placeHolderWidget,
        );
      }

      return ClipRRect(
        key: ValueKey(widget.imageUrl),
        borderRadius: widget.borderRadius ?? BorderRadius.circular(5),
        child: CachedNetworkImage(
          imageUrl: widget.imageUrl ?? "",
          fit: widget.fit,
          height: widget.isRound ? widget.radius : widget.height,
          width: widget.isRound ? widget.radius : widget.width,
          fadeInDuration: const Duration(milliseconds: 200),
          placeholder: (context, url) => placeHolderWidget,
          errorWidget: (context, url, error) => placeHolderWidget,
        ),
      );
    } catch (e) {
      return ClipRRect(
        borderRadius: !widget.isRound ? widget.borderRadius ?? BorderRadius.circular(30) : BorderRadius.zero,
        child: placeHolderWidget,
      );
    }
  }
}
