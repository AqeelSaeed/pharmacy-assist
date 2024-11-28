import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pharmacy_assist/main_barrel.dart';

final Map<String, LinearGradient> gradientCache = {};

class PosTileWidget extends StatefulWidget {
  final ProductModel product;
  final VoidCallback onTap;
  final List<ProductModel> cartItems;

  const PosTileWidget({
    super.key,
    required this.product,
    required this.onTap,
    required this.cartItems,
  });

  @override
  State<PosTileWidget> createState() => _PosTileWidgetState();
}

class _PosTileWidgetState extends State<PosTileWidget> {
  late final LinearGradient gradient;

  @override
  void initState() {
    super.initState();

    gradient = gradientCache.putIfAbsent(
        widget.product.id!, () => generateRandomGradient());
  }

  @override
  Widget build(BuildContext context) {
    final isInCart =
        widget.cartItems.any((item) => item.id == widget.product.id);
    final iconColor = isInCart ? Colors.grey : Colors.green;
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Palette.secondary),
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: context.locale.languageCode == 'en'
                        ? const Radius.circular(10)
                        : const Radius.circular(0),
                    bottomLeft: context.locale.languageCode == 'en'
                        ? const Radius.circular(10)
                        : const Radius.circular(0),
                    topRight: context.locale.languageCode == 'ar'
                        ? const Radius.circular(10)
                        : const Radius.circular(0),
                    bottomRight: context.locale.languageCode == 'ar'
                        ? const Radius.circular(10)
                        : const Radius.circular(0),
                  ),
                  gradient: generateRandomGradient(),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: CachedImageWidget(
                    height: 80,
                    showBorder: false,
                    fallbackImage: Assets.dummyParmacy1,
                    url: '$storageBaseUrl${widget.product.productImage ?? ''}',
                  ),
                ),
              ),
            ),
            Expanded(
                flex: 2,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichTextWidget(
                        text1: '${name.tr()}: ',
                        text2: widget.product.productName ?? '',
                        color1: Palette.primary,
                        color2: Palette.black,
                        fontSize1: 13,
                        fontSize2: 13,
                        fontWeight1: FontWeight.w400,
                        fontWeight2: FontWeight.w400,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      RichTextWidget(
                        text1: '1 ${boxPrice.tr()}: ',
                        text2: widget.product.retailPrice!.toStringAsFixed(2),
                        color1: Palette.primary,
                        color2: Palette.black,
                        fontSize1: 13,
                        fontSize2: 13,
                        fontWeight1: FontWeight.w400,
                        fontWeight2: FontWeight.w400,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      RichTextWidget(
                        text1: '${remainingBox.tr()}: ',
                        text2: widget.product.boxQuantity.toString(),
                        color1: Palette.primary,
                        color2: Palette.black,
                        fontSize1: 13,
                        fontSize2: 13,
                        fontWeight1: FontWeight.w400,
                        fontWeight2: FontWeight.w400,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      RichTextWidget(
                        text1: '${remainingSheets.tr()}: ',
                        text2: widget.product.extraSheets.toString(),
                        color1: Palette.primary,
                        color2: Palette.black,
                        fontSize1: 13,
                        fontSize2: 13,
                        fontWeight1: FontWeight.w400,
                        fontWeight2: FontWeight.w400,
                      ),
                    ],
                  ),
                )),
            Padding(
              padding: EdgeInsets.only(
                  right: context.locale.languageCode == 'en' ? 18.0 : 0,
                  left: context.locale.languageCode == 'ar' ? 18.0 : 0),
              child: AbsorbPointer(
                absorbing: isInCart,
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: widget.onTap,
                    child: Icon(
                      Icons.shopping_cart,
                      color: iconColor,
                      size: 25,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  LinearGradient generateRandomGradient() {
    final random = Random();
    // Generate random colors
    final color1 = Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    ).withOpacity(0.15);
    final color2 = Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    ).withOpacity(0.15);
    return LinearGradient(
        colors: [color1, color2],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter);
  }
}
