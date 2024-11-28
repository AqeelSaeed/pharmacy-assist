import 'package:flutter/material.dart';
import '../../../../../main_barrel.dart';
import '../widgets/depo_product_tile_widget.dart';

// ignore: must_be_immutable
class DepotProductMobileView extends StatefulWidget {
  final TextEditingController controller;
  int? selectedIndex;
  final List<ProductModel> productList;
  final int totalPages;
  final int currentPage;
  final void Function(String)? onChanged;
  DepotProductMobileView(
      {super.key,
      required this.controller,
      required this.currentPage,
      required this.onChanged,
      required this.productList,
      required this.selectedIndex,
      required this.totalPages});

  @override
  State<DepotProductMobileView> createState() => _DepotProductMobileViewState();
}

class _DepotProductMobileViewState extends State<DepotProductMobileView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
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
          child: widget.productList.isNotEmpty
              ? ListView.separated(
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  itemCount: widget.productList.length,
                  shrinkWrap: true,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width - 32,
                      child: DepoProductTileWidget(
                        onTap: () {},
                        productDetail: widget.productList[index],
                      ),
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
      ],
    );
  }
}
