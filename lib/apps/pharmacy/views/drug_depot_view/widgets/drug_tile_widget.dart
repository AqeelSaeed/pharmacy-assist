import 'package:flutter/material.dart';

import '../../../../../main_barrel.dart';

class DrugTileWidget extends StatelessWidget {
  final VoidCallback onTap;
  final DrugDepot depoModel;

  const DrugTileWidget(
      {super.key, required this.depoModel, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          const SizedBox(width: 16),
          CachedImageWidget(
              fallbackImage: "assets/icons/amoxil.png",
              url: "$storageBaseUrl${depoModel.profilePicture}"),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  depoModel.name ?? '',
                  style: CustomFontStyle.regularText.copyWith(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
                RichTextWidget(
                  text1: "Email: ",
                  text2: depoModel.email ?? '',
                  color2: Colors.red,
                  fontSize1: 14.0,
                  fontSize2: 12.0,
                ),
                RichTextWidget(
                  text1: "Total Products: ",
                  text2: depoModel.totalProducts.toString(),
                  color1: Palette.grey,
                  fontSize1: 14.0,
                  fontSize2: 13.0,
                ),
                RichTextWidget(
                  text1: "Phone No: ",
                  text2: depoModel.phoneNumber ?? '',
                  color1: Palette.grey,
                  fontSize1: 14.0,
                  fontSize2: 13.0,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: onTap,
                  child: Image.asset(
                    Assets.greenPile,
                    height: 20,
                    width: 20,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
