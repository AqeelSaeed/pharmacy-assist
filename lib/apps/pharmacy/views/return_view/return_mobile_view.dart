import 'package:flutter/material.dart';
import 'package:pharmacy_assist/apps/pharmacy/views/return_view/widgets/return_tile_widget.dart';
import 'package:pharmacy_assist/models/return_product_model.dart';
import '../../../../../main_barrel.dart';

class ReturnMobileView extends StatefulWidget {
  final List<Return> returns;
  final int totalPages;
  final int currentPage;
  final TextEditingController? controller;
  final Function(String query)? onChanged;
  const ReturnMobileView(
      {super.key,
      required this.returns,
      required this.currentPage,
      required this.onChanged,
      required this.controller,
      required this.totalPages});

  @override
  State<ReturnMobileView> createState() => _ReturnMobileViewState();
}

class _ReturnMobileViewState extends State<ReturnMobileView> {
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
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  itemCount: widget.returns.length, // Single item per row
                  shrinkWrap: true,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width:
                          MediaQuery.of(context).size.width - 32, // Full width
                      child: ReturnTileWidget(
                        returns: widget.returns[index],
                        onTap: () {},
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ],
    );
  }
}
