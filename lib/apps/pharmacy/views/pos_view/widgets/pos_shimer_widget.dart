import 'package:flutter/material.dart';
import 'package:pharmacy_assist/main_barrel.dart';
import 'package:shimmer/shimmer.dart';

class PosShimerWidget extends StatefulWidget {
  const PosShimerWidget({super.key});

  @override
  State<PosShimerWidget> createState() => _PosShimerWidgetState();
}

class _PosShimerWidgetState extends State<PosShimerWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25, right: 25),
      child: Container(
        width: double.infinity,
        height: 100,
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
                    color: Palette.lightGrey),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Shimmer.fromColors(
                    baseColor: Palette.lightGrey,
                    highlightColor: Palette.primaryLight,
                    enabled: true,
                    child: Container(
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: const Icon(
                        Icons.circle,
                        size: 70,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
                flex: 2,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Shimmer.fromColors(
                          baseColor: Palette.lightGrey,
                          highlightColor: Palette.primaryLight,
                          child: Container(
                            height: 15,
                            width: 50,
                            margin: const EdgeInsets.only(right: 20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          )),
                      const SizedBox(
                        height: 8,
                      ),
                      Shimmer.fromColors(
                          baseColor: Palette.lightGrey,
                          highlightColor: Palette.primaryLight,
                          child: Container(
                            height: 15,
                            width: 60,
                            margin: const EdgeInsets.only(right: 20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          )),
                      const SizedBox(
                        height: 8,
                      ),
                      Shimmer.fromColors(
                          baseColor: Palette.lightGrey,
                          highlightColor: Palette.primaryLight,
                          child: Container(
                            height: 15,
                            width: 80,
                            margin: const EdgeInsets.only(right: 20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          )),
                      const SizedBox(
                        height: 8,
                      ),
                      Shimmer.fromColors(
                          baseColor: Palette.lightGrey,
                          highlightColor: Palette.primaryLight,
                          child: Container(
                            margin: const EdgeInsets.only(right: 20),
                            height: 15,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          )),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
