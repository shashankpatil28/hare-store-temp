// Path: lib/commonView/load_image_with_placeholder.dart

import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

import '../utils/common_util.dart';

class LoadImageWithPlaceHolder extends StatelessWidget {
  final double height;
  final double width;
  final Color? color;
  final Color? defaultAssetColor;
  final Color? placeholderColor;
  final String image;
  final String? defaultAssetImage;
  final Widget? placeholder;
  final Widget? errorHolder;
  final String? errorImage;
  final BorderRadius borderRadius;
  final BoxFit? imageFit;
  final BoxFit? placeholderFit;

  const LoadImageWithPlaceHolder({
    Key? key,
    required this.width,
    required this.height,
    required this.image,
    this.errorImage,
    this.defaultAssetImage,
    this.defaultAssetColor,
    this.placeholderColor,
    this.imageFit,
    this.placeholderFit,
    this.color,
    this.placeholder,
    this.errorHolder,
    this.borderRadius = BorderRadius.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Image(
          // image: getImageProvider(),
          image: getFile(image),
          color: getColor(),
          fit: getBoxFit(),
          height: height,
          width: width,
          errorBuilder: (context, error, stackTrace) {
            return getErrorHolder();
          },
          frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
            return getFrameBuilder(child, frame, wasSynchronouslyLoaded);
          },
        ),
      ),
    );
  }

  getImageProvider() {
    return (image.isNotEmpty ? NetworkImage(image) : AssetImage(defaultAssetImage ?? "assets/images/placeholder_image.png"));
  }

  ImageProvider getFile(String filePath) {
    ImageProvider file = AssetImage(defaultAssetImage ?? "assets/images/placeholder_image.png");

    if (filePath.isNotEmpty) {
      if (isURL(filePath)) {
        file = NetworkImage(filePath);
      } else {
        file = AssetImage(filePath);
      }
    }
    return file;
  }

  getColor() {
    return (image).isNotEmpty ? (color) : ((defaultAssetImage == null) ? colorPrimary : (defaultAssetColor));
  }

  getBoxFit() {
    return imageFit ?? (((image).isNotEmpty ? BoxFit.cover : BoxFit.scaleDown));
  }

  getErrorHolder() {
    return Center(
      child: errorHolder ?? Container(color: colorShimmerBg),
    );
  }

  getFrameBuilder(Widget child, int? frame, bool wasSynchronouslyLoaded) {
    if (wasSynchronouslyLoaded) {
      return child;
    } else {
      return AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        transitionBuilder: (Widget child, Animation<double> animation) => FadeTransition(
          opacity: animation,
          child: child,
        ),
        child: frame != null ? child : placeholder ?? Container(color: colorShimmerBg),
      );
    }
  }
}
