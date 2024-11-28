import 'package:flutter/material.dart';
import 'package:pharmacy_assist/apps/pharmacy/views/return_view/widgets/return_tile_widget.dart';
import 'package:pharmacy_assist/models/return_product_model.dart';
import '../../../../main_barrel.dart';

// ignore: must_be_immutable
class ReturnTabView extends StatefulWidget {
  final List<Return> returns;
  final int totalPages;
  final int currentPage;
  int? selectedIndex;
  final TextEditingController? controller;
  final Function(String query)? onChanged;
  ReturnTabView(
      {super.key,
      required this.returns,
      required this.currentPage,
      required this.selectedIndex,
      required this.onChanged,
      required this.controller,
      required this.totalPages});

  @override
  State<ReturnTabView> createState() => _ReturnTabViewState();
}

class _ReturnTabViewState extends State<ReturnTabView> {
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
    return GestureDetector(
      onTap: () => setState(() => widget.selectedIndex = null),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(45, 45, 45, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Container(
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
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.only(right: 16, bottom: 16),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: calculateColumns(context),
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        childAspectRatio: 4,
                      ),
                      itemCount: widget.returns.length,
                      itemBuilder: (context, index) {
                        return ReturnTileWidget(
                          returns: widget.returns[index],
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
