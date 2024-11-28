import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pharmacy_assist/main_barrel.dart';
import 'package:sizer/sizer.dart';

class ImagePickerWidget extends StatelessWidget {
  final Uint8List? image;
  final String? initialUrl;
  final String assetPath;
  final void Function(Uint8List? image) onImageSelected;

  const ImagePickerWidget({
    super.key,
    required this.image,
    required this.onImageSelected,
    required this.assetPath,
    this.initialUrl,
  });

  @override
  Widget build(BuildContext context) {
    log(initialUrl.toString());
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFFD9D9D9), width: 1),
      ),
      width: 120,
      height: 120,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Stack(children: [
          CircularImageWidget(
            size: 120,
            child: (initialUrl != null && initialUrl!.isNotEmpty)
                ? Image.network(initialUrl!, fit: BoxFit.cover)
                : image != null && image!.isNotEmpty
                    ? Image.memory(image!, fit: BoxFit.cover)
                    : Image.asset(
                        assetPath,
                        fit: BoxFit.cover,
                      ),
          ),
          Positioned.fill(
              child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(60),
            ),
          )),
          Positioned(
            bottom: 0,
            right: 0,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => pickImage(context),
                child: Container(
                  width: 30,
                  height: 30,
                  padding: EdgeInsets.all(0.7.h),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Image.asset(
                      Assets.cameraIcon,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  void pickImage(BuildContext context) async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageBytes = await image.readAsBytes();
    onImageSelected(imageBytes);
  }
}
