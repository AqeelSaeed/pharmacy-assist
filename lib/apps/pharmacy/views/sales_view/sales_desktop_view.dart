import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_assist/main_barrel.dart';
import 'widgets/sales_row_widget.dart';

// ignore: must_be_immutable
class SalesDesktopView extends StatefulWidget {
  final List<Sale> salesList;
  final int totalPages;
  final int currentPage;
  final TextEditingController? controller;
  int? selectedIndex;
  final Function(String query)? onChanged;
  SalesDesktopView(
      {super.key,
      required this.salesList,
      required this.currentPage,
      required this.selectedIndex,
      required this.onChanged,
      required this.controller,
      required this.totalPages});

  @override
  State<SalesDesktopView> createState() => _SalesDesktopViewState();
}

class _SalesDesktopViewState extends State<SalesDesktopView> {
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
              padding: const EdgeInsets.only(bottom: 20),
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
                        hideShadow: true,
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
                  const SalesRowWidget(isHeading: true),
                  widget.salesList.isNotEmpty
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: widget.salesList.length,
                            itemBuilder: (context, index) {
                              final sale = widget.salesList[index];
                              return SalesRowWidget(
                                srNo: (index + 1).toString(),
                                sales: sale,
                                index: index,
                                isSelected: widget.selectedIndex == index,
                                onTap: () {
                                  if (widget.selectedIndex == index) {
                                    setState(() => widget.selectedIndex = null);
                                  } else {
                                    setState(
                                        () => widget.selectedIndex = index);
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
                              const Text(
                                'No Sale Found',
                                style: CustomFontStyle.boldText,
                              ),
                            ],
                          ),
                        ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: widget.salesList.isNotEmpty
                        ? PaginationWidget(
                            currentPage: widget.currentPage,
                            totalPages: widget.totalPages,
                            onPageChanged: (page) {
                              context.read<SalesCubit>().changePage(page);
                            },
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
