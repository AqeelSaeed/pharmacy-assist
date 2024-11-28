import 'package:flutter/material.dart';
import 'package:pharmacy_assist/apps/pharmacy/views/drug_depot_view/widgets/depo_product_tile_widget.dart';
import '../../../../../main_barrel.dart';

// ignore: must_be_immutable
class DepotProductTabView extends StatefulWidget {
  final TextEditingController controller;
  int? selectedIndex;
  final List<ProductModel> productList;
  final int totalPages;
  final int currentPage;
  final void Function(String)? onChanged;
  DepotProductTabView(
      {super.key,
      required this.controller,
      required this.currentPage,
      required this.onChanged,
      required this.productList,
      required this.selectedIndex,
      required this.totalPages});

  @override
  State<DepotProductTabView> createState() => _DepotProductTabViewState();
}

class _DepotProductTabViewState extends State<DepotProductTabView> {
  int calculateColumns(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth > 1200) {
      return 2;
    } else if (screenWidth > 800) {
      return 2;
    } else {
      return 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              BackPressWidget(title: productDetails.tr()),
              const Spacer(),
              Container(
                constraints: BoxConstraints(
                  maxWidth: Responsive.isMobile(context)
                      ? MediaQuery.sizeOf(context).width * 0.55
                      : 356,
                ),
                child: TextFieldComponent(
                    hintText: searchPlaceholder.tr(),
                    controller: widget.controller,
                    onChanged: widget.onChanged,
                    hideBorder: true,
                    prefixIconPath: Assets.searchIcon),
              ),
            ],
          ),
        ),
        Expanded(
          child: Expanded(
            child: widget.productList.isNotEmpty
                ? GridView.builder(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: calculateColumns(context),
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      childAspectRatio:
                          MediaQuery.of(context).size.aspectRatio * 2.25,
                    ),
                    itemCount: widget.productList.length,
                    itemBuilder: (context, index) {
                      return DepoProductTileWidget(
                        onTap: () {},
                        productDetail: widget.productList[index],
                      );
                    },
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        Assets.noProductsIcon,
                        height: 120,
                      ),
                      Text(
                        noProductsFound.tr(),
                        style: CustomFontStyle.boldText,
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}
