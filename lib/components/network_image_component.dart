import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_assist/main_barrel.dart';

class NetworkImageComponent extends StatelessWidget {
  final String imageUrl;
  final double? size;
  final double? height;
  final double? width;
  final Color? color;
  final BoxFit? fit;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;
  final double? topRightRadius;
  final double? bottomRightRadius;
  final double? topLeftRadius;
  final double? bottomLeftRadius;
  final bool hideProgressIndicator;
  final bool showBorder;

  const NetworkImageComponent({
    super.key,
    this.fit = BoxFit.cover,
    this.size,
    this.height,
    this.width,
    this.color,
    this.margin,
    required this.imageUrl,
    this.borderRadius = 999.0,
    this.topRightRadius,
    this.bottomRightRadius,
    this.topLeftRadius,
    this.bottomLeftRadius,
    this.hideProgressIndicator = false,
    this.showBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      clipBehavior: Clip.hardEdge,
      padding: showBorder ? const EdgeInsets.all(1) : null,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: showBorder
            ? Border.all(
                color: Palette.lightGrey,
                width: 1,
              )
            : null,
      ),
      child: SizedBox(
        height: size ?? height,
        width: size ?? width,
        child: imageUrl.contains('.mp4')
            ? const Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.error, size: 30),
                  Text('Invalid Image type'),
                ],
              )
            : CachedNetworkImage(
                placeholderFadeInDuration: const Duration(milliseconds: 150),
                fadeInDuration: const Duration(milliseconds: 500),
                fadeOutDuration: const Duration(milliseconds: 500),
                imageUrl: imageUrl,
                fit: fit,
                color: color,
                cacheKey: imageUrl,
                useOldImageOnUrlChange: true,
                fadeInCurve: Curves.easeIn,
                fadeOutCurve: Curves.easeOut,
                // placeholder: (context, url) => ,
                progressIndicatorBuilder: (context, url, progress) =>
                    hideProgressIndicator
                        ? const SizedBox.shrink()
                        : Expanded(
                            child: Center(
                              //   child: SpinKitFadingGrid(
                              //   size: 20,
                              //   color: color ?? Palette.primaryColor,
                              // )
                              child: CircularProgressIndicator(
                                value: progress.progress,
                                color: Palette.primary,
                              ),
                            ),
                          ),
                errorWidget: (context, url, error) {
                  return Image.asset(
                    Assets.dummyParmacy,
                    height: height,
                  );
                },
                // errorWidget: (context, url, error) => Column(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: const [
                //     Icon(Icons.error, size: 30),
                //     Text('Invalid Image'),
                //   ],
                // ),
              ),
      ),
    );
  }
}
