import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CustomNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;
  final Border? border;
  final BorderRadius? borderRadius;
  final BoxShape boxShape;
  final Color? backgroundColor;
  final Widget? child;
  final BoxFit? boxFit;
  final ColorFilter? colorFilter;
  const CustomNetworkImage(
      {super.key,
      this.child,
      this.colorFilter,
      required this.imageUrl,
      this.backgroundColor,
      required this.height,
      required this.width,
      this.border,
      this.borderRadius,
      this.boxShape = BoxShape.rectangle,
      this.boxFit = BoxFit.cover});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        imageUrl: imageUrl,
        imageBuilder: (context, imageProvider) => Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                border: border,
                borderRadius: borderRadius,
                shape: boxShape,
                color: backgroundColor,
                image: DecorationImage(
                    image: imageProvider,
                    fit: boxFit,
                    colorFilter: colorFilter),
              ),
              child: child,
            ),
        placeholder: (context, url) => Skeletonizer(
            enabled: true,
            child: Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                border: border,
                color: Colors.grey.withOpacity(0.6),
                borderRadius: borderRadius,
                shape: boxShape,
              ),
            )),
        errorWidget: (context, url, error) => Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                border: border,
                color: Colors.grey.withOpacity(0.6),
                borderRadius: borderRadius,
                shape: boxShape,
              ),
              child: const Icon(Icons.error),
            ));
  }
}
