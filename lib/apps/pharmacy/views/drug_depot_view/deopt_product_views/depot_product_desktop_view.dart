import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_assist/main_barrel.dart';

// ignore: must_be_immutable
class DepotProductDesktopView extends StatefulWidget {
  final bool isDrugDeop;
  final String uid;
  final TextEditingController controller;
  int? selectedIndex;
  final List<ProductModel> productList;
  final int totalPages;
  final int currentPage;
  final void Function(String)? onChanged;
  DepotProductDesktopView(
      {super.key,
      this.isDrugDeop = false,
      required this.uid,
      required this.controller,
      required this.currentPage,
      required this.onChanged,
      required this.productList,
      required this.selectedIndex,
      required this.totalPages});

  @override
  State<DepotProductDesktopView> createState() =>
      _DepotProductDesktopViewState();
}

class _DepotProductDesktopViewState extends State<DepotProductDesktopView> {
  @override
  Widget build(BuildContext context) {
    context.locale.languageCode;
    return GestureDetector(
      onTap: () => setState(() => widget.selectedIndex = null),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(45, 45, 45, 0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  BackPressWidget(title: productDetails.tr()),
                  const Spacer(),
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.25,
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
                child: Column(
              children: [
                const DrugProductRowWidget(isHeading: true),
                widget.productList.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: widget.productList.length,
                          itemBuilder: (context, index) {
                            var product = widget.productList[index];
                            return DrugProductRowWidget(
                              srNo: (index + 1).toString(),
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
                        child: Center(
                          child: Text(
                            noProductsFound.tr(),
                            style: CustomFontStyle.boldText,
                          ),
                        ),
                      ),
                const SizedBox(height: 15),
                widget.productList.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: PaginationWidget(
                          currentPage: widget.currentPage,
                          totalPages: widget.totalPages,
                          onPageChanged: (page) {
                            context.read<ProductCubit>().changePage(page);
                          },
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
