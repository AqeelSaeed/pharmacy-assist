import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../main_barrel.dart';

class ProductsTabletView extends StatefulWidget {
  final List<ProductModel> products;
  final int totalPages;
  final int currentPage;
  final TextEditingController? controller;
  final Function(String query)? onChanged;
  const ProductsTabletView(
      {super.key,
      required this.products,
      required this.currentPage,
      required this.onChanged,
      required this.controller,
      required this.totalPages});

  @override
  State<ProductsTabletView> createState() => _ProductsTabletViewState();
}

class _ProductsTabletViewState extends State<ProductsTabletView> {
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(45, 47, 45, 0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
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
                const Spacer(),
                Responsive.isMobile(context) || Responsive.isTablet(context)
                    ? const SizedBox.shrink()
                    : const SizedBox(
                        width: 15,
                      ),
                const SizedBox(
                  width: 15,
                ),
                ProductFeatureButton(
                  iconPath: Assets.bulkImportIcon,
                  text: bulkImport.tr(),
                  backgroundColor: Palette.secondary,
                  iconColor: Palette.black,
                  onTap: () {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          return const Dialog(
                            alignment: Alignment.center,
                            child: BulkAlertDialog(),
                          );
                        });
                  },
                ),
                const SizedBox(
                  width: 15,
                ),
                ProductFeatureButton(
                  iconPath: Assets.addProductsIcon,
                  text: addProduct.tr(),
                  backgroundColor: Palette.primary,
                  iconColor: Palette.secondary,
                  onTap: () {
                    context.read<NavigationCubit>().updateNavigation(
                          context,
                          NavigationModel(
                            'Add Products',
                            const AddUpdateProductView(),
                          ),
                        );
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: widget.products.isNotEmpty
                ? Column(
                    children: [
                      Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: calculateColumns(context),
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                            childAspectRatio: 3.65,
                          ),
                          itemCount: widget.products.length,
                          itemBuilder: (context, index) {
                            return ProductTileWidget(
                              productDetail: widget.products[index],
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: widget.products.isNotEmpty
                            ? PaginationWidget(
                                currentPage: widget.currentPage,
                                totalPages: widget.totalPages,
                                onPageChanged: (page) {
                                  context.read<ProductCubit>().changePage(page);
                                },
                              )
                            : const SizedBox.shrink(),
                      ),
                    ],
                  )
                : Expanded(
                    child: Column(
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
          )
        ],
      ),
    );
  }
}
