// Path: lib/commonView/image_selection.dart

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart'; // Keep this
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../config/colors.dart';
import '../config/dimens.dart';
import '../main.dart'; // Assuming this exports languages
import 'my_widgets.dart';
import '../utils/common_util.dart'; // <-- ADD THIS IMPORT

class ImageSelection extends StatelessWidget {
  final Function onPressedCamera, onPressedGallery;

  const ImageSelection(
      {super.key,
      required this.onPressedCamera,
      required this.onPressedGallery});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: deviceHeight * 0.01, horizontal: deviceWidth * 0.01),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(deviceAverageSize * 0.05),
            topRight: Radius.circular(deviceAverageSize * 0.05),
          ),
          color: colorMainBackground),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: deviceWidth * 0.12,
            child: Divider(
              color: colorPrimary,
              thickness: deviceHeight * 0.0035,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: CustomRoundedButton(
                  context,
                  languages.camera.toUpperCase(),
                  () {
                    onPressedCamera();
                  },
                  bgColor: colorPrimary,
                  maxLine: 1,
                  textAlign: TextAlign.center,
                  textSize: textSizeRegular,
                  textColor: colorWhite,
                  fontWeight: FontWeight.w700,
                  minHeight: commonBtnHeightSmall,
                  setBorder: false,
                  minWidth: 0.4,
                  icon: const Icon(
                    Icons.camera_alt,
                    color: colorWhite,
                  ),
                  margin: EdgeInsetsDirectional.only(
                      start: deviceWidth * 0.04,
                      end: deviceWidth * 0.04,
                      top: deviceHeight * 0.015,
                      bottom: deviceHeight * 0.015),
                ),
              ),
              Expanded(
                flex: 1,
                child: CustomRoundedButton(
                  context,
                  languages.gallery.toUpperCase(),
                  () {
                    onPressedGallery();
                  },
                  bgColor: colorPrimary,
                  maxLine: 1,
                  textAlign: TextAlign.center,
                  textSize: textSizeRegular,
                  textColor: colorWhite,
                  fontWeight: FontWeight.w700,
                  minHeight: commonBtnHeightSmall,
                  setBorder: false,
                  minWidth: 0.4,
                  icon: const Icon(
                    Icons.photo_library_rounded,
                    color: colorWhite,
                  ),
                  margin: EdgeInsetsDirectional.only(
                      start: deviceWidth * 0.04,
                      end: deviceWidth * 0.04,
                      top: deviceHeight * 0.015,
                      bottom: deviceHeight * 0.015),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// --- Updated Function ---
Future<File?> _getImage(
    BuildContext context, bool isCamera, String toolbarTitle) async {
  final ImagePicker picker = ImagePicker();
  CroppedFile? croppedFile;

  // Step 1: Pick Image (returns XFile?)
  final XFile? pickedFile = await picker.pickImage(
      source: isCamera ? ImageSource.camera : ImageSource.gallery);

  if (pickedFile != null) {
    // Step 2: Crop Image (returns CroppedFile?)
    croppedFile = await ImageCropper().cropImage(
      sourcePath: pickedFile.path,
      uiSettings: [
        // Use named constructors
        AndroidUiSettings(
          toolbarTitle: toolbarTitle,
          toolbarColor: colorPrimary,
          toolbarWidgetColor: colorWhite,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
        ),
        IOSUiSettings(
          title: toolbarTitle, // Use title for iOS
          minimumAspectRatio: 1.0,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
        ),
        // Add WebUiSettings if needed for web support
      ],
    );
  }
  // Step 3: Return File? from CroppedFile? path
  if (croppedFile != null) {
    return File(croppedFile.path);
  } else {
    return null; // Return null if picking or cropping failed/was cancelled
  }
}

selectImgFromCameraOrGallery(
    BuildContext context, Function(File file) fileCallback) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return ImageSelection(
        onPressedCamera: () {
          Navigator.pop(context);
          _getImage(context, true, languages.cropper).then((file) {
            // Check if file is not null and exists
            if (file != null && file.existsSync()) {
              fileCallback(file);
            }
          });
        },
        onPressedGallery: () {
          Navigator.pop(context);
          _getImage(context, false, languages.cropper).then((file) {
            // Check if file is not null and exists
            if (file != null && file.existsSync()) {
              fileCallback(file);
            }
          });
        },
      );
    },
  );
}

Future<File?> compressImage(File file) async {
  final filePath = file.absolute.path;
  // Try to create a unique output path in the temp directory
  final Directory tempDir = await Directory.systemTemp.createTemp();
  final String fileExtension = filePath.split('.').last;
  final String outPath = "${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.$fileExtension";

  try {
    final XFile? compressedXFile = await FlutterImageCompress.compressAndGetFile(
        filePath, outPath,
        quality: 85); // Returns XFile? now

    return compressedXFile != null ? File(compressedXFile.path) : null;
  } catch (e) {
    logd("CompressImage", "Error compressing image: $e");
    return null; // Return null on error
  } finally {
     // Clean up temp directory if needed, though system temp is usually managed
     // tempDir.delete(recursive: true);
  }
}