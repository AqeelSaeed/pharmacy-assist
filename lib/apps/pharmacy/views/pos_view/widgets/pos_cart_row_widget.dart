import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_assist/cubits/pos_cubit/pos_state.dart';
import 'package:pharmacy_assist/utils/shared_pref.dart';
import '../../../../../main_barrel.dart';

class PosCartRowWidget extends StatefulWidget {
  final bool isHeading;
  final String? srNo;
  final ProductModel? cartItem;
  final VoidCallback? onDelete;

  const PosCartRowWidget({
    super.key,
    this.isHeading = false,
    this.cartItem,
    this.srNo,
    this.onDelete,
  });

  @override
  State<PosCartRowWidget> createState() => _PosCartRowWidgetState();
}

class _PosCartRowWidgetState extends State<PosCartRowWidget> {
  var boxQtyController = TextEditingController();
  final sheetQtyController = TextEditingController();
  String? dropDownValue;
  int boxQuantity = 0;
  int sheetQuantity = 0;
  int counter = 1;
  int maxQuantity = 0;
  int maxSheetQuantity = 0;
  double totalAmount = 0.0;
  List<ProductModel> list = [];
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!widget.isHeading) {
        setState(() {
          boxQtyController.text = counter.toString();
          sheetQtyController.text = 0.toString();

          var product = context.read<ProductCubit>().allProducts.firstWhere(
                (product) => product.id == widget.cartItem!.id,
              );
          maxQuantity = product.boxQuantity ?? 0;
          maxSheetQuantity = product.extraSheets ?? 0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    context.locale.languageCode;
    return Container(
      padding: EdgeInsets.only(top: widget.isHeading ? 10 : 0),
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                widget.isHeading
                    ? medicine.tr()
                    : widget.cartItem!.productName ?? '',
                style: CustomFontStyle.regularText.copyWith(
                  fontSize: widget.isHeading ? 17 : 15,
                  fontWeight:
                      widget.isHeading ? FontWeight.w500 : FontWeight.w400,
                  color: widget.isHeading ? Palette.primary : Colors.black,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(
                alignment: Alignment.center,
                child: widget.isHeading
                    ? Text(
                        quantity.tr(),
                        style: CustomFontStyle.regularText.copyWith(
                          fontSize: widget.isHeading ? 17 : 15,
                          fontWeight: widget.isHeading
                              ? FontWeight.w500
                              : FontWeight.w400,
                          color:
                              widget.isHeading ? Palette.primary : Colors.black,
                        ),
                      )
                    : Column(
                        children: [
                          SizedBox(
                            height: 30,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${box.tr()}:',
                                  style: CustomFontStyle.regularText,
                                ),
                                const SizedBox(width: 32),
                                SizedBox(
                                  width: 100,
                                  child: TextFieldComponent(
                                    onChanged: (value) {
                                      final typedQuantity =
                                          double.tryParse(value)?.toInt() ?? 0;
                                      setState(() {
                                        boxQtyController.text = value;
                                        boxQuantity = boxQtyController
                                                .text.isEmpty
                                            ? 0
                                            : int.parse(boxQtyController.text);
                                      });
                                      if (typedQuantity <= maxQuantity) {
                                        context
                                            .read<POSCubit>()
                                            .updateProductQuantity(
                                                widget.cartItem!,
                                                boxQuantity: typedQuantity);
                                      } else {
                                        snack(
                                            context, quantityExceedsLimit.tr());
                                        boxQtyController.text =
                                            maxQuantity.toString();
                                        boxQtyController.selection =
                                            TextSelection.fromPosition(
                                          TextPosition(
                                              offset:
                                                  boxQtyController.text.length),
                                        );
                                      }
                                    },
                                    controller: boxQtyController,
                                    verticalPadding: 2,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          SizedBox(
                            height: 30,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${sheets.tr()}:',
                                  style: CustomFontStyle.regularText,
                                ),
                                const SizedBox(width: 10),
                                SizedBox(
                                  width: 100,
                                  child: TextFieldComponent(
                                    onChanged: (value) {
                                      setState(() {
                                        sheetQtyController.text = value;
                                        maxSheetQuantity =
                                            sheetQtyController.text.isEmpty
                                                ? 0
                                                : int.parse(
                                                    sheetQtyController.text);
                                      });
                                      final typedQuantity =
                                          int.tryParse(value) ?? 0;
                                      context
                                          .read<POSCubit>()
                                          .updateProductQuantity(
                                              widget.cartItem!,
                                              sheetQuantity: typedQuantity);
                                    },
                                    controller: sheetQtyController,
                                    verticalPadding: 2,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      )),
          ),
          Expanded(
            flex: 3,
            child: Align(
              alignment: Alignment.center,
              child: widget.isHeading
                  ? Text(
                      summary.tr(),
                      style: CustomFontStyle.regularText.copyWith(
                        fontSize: widget.isHeading ? 17 : 15,
                        fontWeight: widget.isHeading
                            ? FontWeight.w500
                            : FontWeight.w400,
                        color:
                            widget.isHeading ? Palette.primary : Colors.black,
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${boxQtyController.text}-/ ${box.tr()} + ${sheetQtyController.text}-/ ${sheets.tr()}",
                          style: CustomFontStyle.regularText,
                        )
                      ],
                    ),
            ),
          ),
          BlocBuilder<POSCubit, POSState>(builder: (context, state) {
            return Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  widget.isHeading
                      ? '${total.tr()} (IQR)'
                      : widget.cartItem != null
                          ? ((boxQuantity * widget.cartItem!.retailPrice!) +
                                  (maxSheetQuantity *
                                      widget.cartItem!.sheetPrice!))
                              .toStringAsFixed(2)
                          : totalAmount.toString(),
                  style: CustomFontStyle.regularText.copyWith(
                    fontSize: widget.isHeading ? 17 : 15,
                    fontWeight:
                        widget.isHeading ? FontWeight.w500 : FontWeight.w400,
                    color: widget.isHeading ? Palette.primary : Colors.black,
                  ),
                ),
              ),
            );
          }),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.center,
              child: widget.isHeading
                  ? Text(
                      actions.tr(),
                      style: CustomFontStyle.regularText.copyWith(
                        fontSize: widget.isHeading ? 17 : 15,
                        fontWeight: widget.isHeading
                            ? FontWeight.w500
                            : FontWeight.w400,
                        color:
                            widget.isHeading ? Palette.primary : Colors.black,
                      ),
                    )
                  : IconButton(
                      icon: const Icon(Icons.delete, color: Palette.error),
                      onPressed: widget.onDelete,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
