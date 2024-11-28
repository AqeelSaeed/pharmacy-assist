import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_assist/main_barrel.dart';

// ignore: must_be_immutable
class DrugDepotDesktopView extends StatefulWidget {
  final int totalPages;
  final int currentPage;
  List<DrugDepot> drugDeposList;
  final TextEditingController controller;
  int? selectedIndex;
  final void Function(String)? onChanged;
  DrugDepotDesktopView(
      {super.key,
      required this.totalPages,
      required this.controller,
      required this.currentPage,
      required this.drugDeposList,
      required this.onChanged,
      required this.selectedIndex});

  @override
  State<DrugDepotDesktopView> createState() => _DrugDepotDesktopViewState();
}

class _DrugDepotDesktopViewState extends State<DrugDepotDesktopView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => widget.selectedIndex = null),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(45, 49, 45, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            const SizedBox(height: 20),
            Expanded(
              child: Column(
                children: [
                  const DrugDepoTableRowWidget(isHeading: true),
                  widget.drugDeposList.isNotEmpty
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: widget.drugDeposList.length,
                            itemBuilder: (context, index) {
                              var depo = widget.drugDeposList[index];
                              return DrugDepoTableRowWidget(
                                srNo: (index + 1).toString(),
                                depoModel: depo,
                                isSelected: widget.selectedIndex == index,
                                onTap: () {
                                  setState(() {
                                    widget.selectedIndex = index;
                                  });
                                  context
                                      .read<NavigationCubit>()
                                      .updateNavigation(
                                          context,
                                          NavigationModel(
                                            productDetails.tr(),
                                            DrugDepoProductView(
                                                uid: depo.uid ?? ''),
                                          ));
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
                                noDrugDepotFound.tr(),
                                style: CustomFontStyle.boldText,
                              ),
                            ],
                          ),
                        ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: widget.drugDeposList.isNotEmpty
                        ? PaginationWidget(
                            currentPage: widget.currentPage,
                            totalPages: widget.totalPages,
                            onPageChanged: (page) {
                              context.read<DrugDepoCubit>().changePage(page);
                            },
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
