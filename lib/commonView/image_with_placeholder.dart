// Path: lib/commonView/image_with_placeholder.dart

import 'package:flutter/material.dart';

import '../utils/common_util.dart';

class ImageWithPlaceholder extends StatelessWidget {
  const ImageWithPlaceholder({
    Key? key,
    required this.image,
    this.placeholder,
    this.errorHolder,
    this.size,
    this.radius,
    this.isCircular,
  }) : super(key: key);

  final ImageProvider image;
  final Widget? placeholder;
  final Widget? errorHolder;
  final double? size;
  final double? radius;
  final bool? isCircular;

  @override
  Widget build(BuildContext context) {
    final double defaultSize = isCircular ?? false ? radius ?? deviceAverageSize * 0.07 : size ?? deviceAverageSize * 0.07;

    final double defaultRadius = isCircular ?? false ? (radius ?? defaultSize / 2) : radius ?? 0;
    return SizedBox(
      height: defaultSize,
      width: defaultSize,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(defaultRadius),
        child: Image(
          image: image,
          fit: BoxFit.cover,
          height: defaultSize,
          width: defaultSize,
          errorBuilder: (context, error, stackTrace) {
            return Center(child: errorHolder ?? const Icon(Icons.error));
          },
          frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
            if (wasSynchronouslyLoaded) {
              return child;
            } else {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: frame != null ? child : placeholder,
              );
            }
          },
        ),
      ),
    );
  }
}
