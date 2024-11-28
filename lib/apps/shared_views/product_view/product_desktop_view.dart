import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_assist/main_barrel.dart';

// ignore: must_be_immutable
class ProductDesktopView extends StatefulWidget {
  final List<ProductModel> products;
  final int totalPages;
  final int currentPage;
  final TextEditingController? controller;
  int? selectedIndex;
  final Function(String query)? onChanged;
  ProductDesktopView(
      {super.key,
      required this.products,
      required this.currentPage,
      required this.selectedIndex,
      required this.onChanged,
      required this.controller,
      required this.totalPages});

  @override
  State<ProductDesktopView> createState() => _ProductDesktopViewState();
}

class _ProductDesktopViewState extends State<ProductDesktopView> {
  final int itemsPerPage = 7;
  String userUid = '';
  String keyword = '';

  @override
  Widget build(BuildContext context) {
    context.locale.toString();
    return GestureDetector(
      onTap: () => setState(() => widget.selectedIndex = null),
      child: Padding(
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
                  Responsive.isMobile(context) || Responsive.isTablet(context)
                      ? const SizedBox.shrink()
                      : ProductFeatureButton(
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
                child: Column(
              children: [
                const ProductTableRow(isHeading: true),
                widget.products.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: widget.products.length,
                          itemBuilder: (context, index) {
                            var product = widget.products[index];
                            int currentPage = widget.currentPage;
                            return ProductTableRow(
                              srNo:
                                  (index + 1 + (currentPage - 1) * itemsPerPage)
                                      .toString(),
                              product: product,
                              isSelected: widget.selectedIndex == index,
                              onTap: () {
                                if (widget.selectedIndex == index) {
                                  setState(() => widget.selectedIndex = null);
                                } else {
                                  setState(() => widget.selectedIndex = index);
                                }
                              },
                            );
                          },
                        ),
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
            ))
          ],
        ),
      ),
    );
  }
}
