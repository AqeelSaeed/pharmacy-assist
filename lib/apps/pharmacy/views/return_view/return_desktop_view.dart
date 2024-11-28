import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_assist/apps/pharmacy/views/return_view/widgets/return_row_widget.dart';
import 'package:pharmacy_assist/cubits/return_cubit/return_cubit.dart';
import 'package:pharmacy_assist/main_barrel.dart';
import 'package:pharmacy_assist/models/return_product_model.dart';

// ignore: must_be_immutable
class ReturnDesktopView extends StatefulWidget {
  final List<Return> retunsList;
  final int totalPages;
  final int currentPage;
  final TextEditingController? controller;
  int? selectedIndex;
  final Function(String query)? onChanged;
  ReturnDesktopView(
      {super.key,
      required this.retunsList,
      required this.currentPage,
      required this.selectedIndex,
      required this.onChanged,
      required this.controller,
      required this.totalPages});
  @override
  State<ReturnDesktopView> createState() => _ReturnDesktopViewState();
}

class _ReturnDesktopViewState extends State<ReturnDesktopView> {
  TextEditingController searchController = TextEditingController();
  int? selectedIndex;

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
                  const ReturnRowWidget(isHeading: true),
                  widget.retunsList.isNotEmpty
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: widget.retunsList.length,
                            itemBuilder: (context, index) {
                              final returns = widget.retunsList[index];
                              return ReturnRowWidget(
                                srNo: (index + 1).toString(),
                                isHeading: false,
                                isSelected: widget.selectedIndex == index,
                                info: Return(
                                  id: returns.id,
                                  totalPrice: returns.totalPrice.toString(),
                                  createdAt: returns.createdAt!,
                                  pharmacyId: returns.pharmacyId,
                                  saleId: returns.saleId,
                                ),
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
                    child: widget.retunsList.isNotEmpty
                        ? PaginationWidget(
                            currentPage: widget.currentPage,
                            totalPages: widget.totalPages,
                            onPageChanged: (page) {
                              context.read<ReturnCubit>().changePage(page);
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
