import 'package:flutter/material.dart';

import '../../../main_barrel.dart';
import 'widgets/staff_row_widget.dart';

// ignore: must_be_immutable
class StaffDesktopView extends StatefulWidget {
  final int totalPages;
  final int currentPage;
  final TextEditingController? controller;
  int? selectedIndex;
  final Function(String query)? onChanged;
  StaffDesktopView(
      {super.key,
      required this.currentPage,
      required this.selectedIndex,
      required this.onChanged,
      required this.controller,
      required this.totalPages});

  @override
  State<StaffDesktopView> createState() => _StaffDesktopViewState();
}

class _StaffDesktopViewState extends State<StaffDesktopView> {
  @override
  Widget build(BuildContext context) {
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
                  ProductFeatureButton(
                    iconPath: Assets.staffIcon,
                    text: addProduct.tr(),
                    backgroundColor: Palette.primary,
                    iconColor: Palette.secondary,
                    onTap: () {},
                  ),
                ],
              ),
            ),
            Expanded(
                child: Column(
              children: [
                const StaffRowWidget(isHeading: true),
                Expanded(
                  child: ListView.builder(
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return StaffRowWidget(
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
                ),
                const SizedBox(height: 15),
                Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: PaginationWidget(
                      currentPage: widget.currentPage,
                      totalPages: widget.totalPages,
                      onPageChanged: (page) {},
                    )),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
