import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImageWidget extends StatelessWidget {
  final String url;
  final double? height;
  final double? width;
  final String? fallbackImage;
  final bool? showBorder;
  const CachedImageWidget(
      {super.key,
      required this.url,
      this.fallbackImage,
      this.height,
      this.showBorder,
      this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: showBorder != false
            ? Border.all(color: const Color(0xFFD9D9D9), width: 1)
            : null,
      ),
      height: height ?? 60,
      width: width ?? 60,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: CachedNetworkImage(
            imageUrl: url,
            httpHeaders: const {'Content-Type': 'application/json'},
            fit: BoxFit.cover,
            fadeInCurve: Curves.easeIn,
            fadeOutCurve: Curves.easeOut,
            fadeInDuration: const Duration(milliseconds: 500),
            placeholder: (context, url) => fallbackImage != null
                ? Image.asset(
                    fallbackImage!,
                  )
                : Container(),
            errorWidget: (context, url, error) {
              return fallbackImage != null
                  ? Image.asset(
                      fallbackImage!,
                    )
                  : Container();
            },
          ),
        ),
      ),
    );
  }
}
