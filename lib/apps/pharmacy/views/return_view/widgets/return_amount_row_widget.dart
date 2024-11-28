import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_assist/cubits/return_cubit/return_cubit.dart';
import '../../../../../main_barrel.dart';

// ignore: must_be_immutable
class ReturnAmountRowWidget extends StatefulWidget {
  final bool isHeading;
  final String? srNo;
  final ProductModel? purchasedProducts;
  final VoidCallback? onDelete;

  const ReturnAmountRowWidget({
    super.key,
    this.isHeading = false,
    this.purchasedProducts,
    this.srNo,
    this.onDelete,
  });

  @override
  State<ReturnAmountRowWidget> createState() => _ReturnAmountRowWidgetState();
}

class _ReturnAmountRowWidgetState extends State<ReturnAmountRowWidget> {
  var boxQtyController = TextEditingController();
  final sheetQtyController = TextEditingController();
  String? dropDownValue;
  int boxQuantity = 0;
  int sheetQuantity = 0;
  int counter = 1;
  List<CartItem> cartItems = [];
  String productName = '';
  double totalAmount = 0.0;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        if (widget.purchasedProducts != null) {
          boxQuantity = widget.purchasedProducts!.boxQuantity! -
              widget.purchasedProducts!.returnedBoxQuantity!;
          sheetQuantity = widget.purchasedProducts!.sheetQuantity! -
              widget.purchasedProducts!.returnedSheetQuantity!;
          totalAmount = (boxQuantity * widget.purchasedProducts!.retailPrice!) +
              (sheetQuantity * widget.purchasedProducts!.sheetPrice!);
        }
      });
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
                    : widget.purchasedProducts!.productName.toString(),
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
                        'Previous Quantity',
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${box.tr()}: ${(boxQuantity).toString()}',
                                style: CustomFontStyle.regularText,
                              ),
                              if (sheetQuantity != 0) const SizedBox(width: 10),
                              if (sheetQuantity != 0)
                                Text(
                                  '${sheets.tr()}: ${(sheetQuantity).toString()}',
                                  style: CustomFontStyle.regularText,
                                ),
                            ],
                          ),
                        ],
                      )),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                widget.isHeading
                    ? '${total.tr()} (IQR)'
                    : (totalAmount).toStringAsFixed(2),
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
            child: widget.isHeading
                ? Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Update Qty',
                      style: CustomFontStyle.regularText.copyWith(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Palette.primary,
                      ),
                    ),
                  )
                : Column(
                    children: [
                      SizedBox(
                        height: 30,
                        width: 100,
                        child: TextFieldComponent(
                          hintText: 'Box Qty',
                          onChanged: (value) {
                            if (value.isEmpty) {
                              final productIndex = context
                                  .read<ReturnCubit>()
                                  .returnedProducts
                                  .indexWhere(
                                    (product) =>
                                        product.id ==
                                        widget.purchasedProducts?.id,
                                  );

                              // Check if product exists in returnedProducts
                              final sheetQuantity = (productIndex != -1)
                                  ? context
                                      .read<ReturnCubit>()
                                      .returnedProducts[productIndex]
                                      .sheetQuantity
                                  : 0;

                              context.read<ReturnCubit>().returnQuantities(
                                  widget.purchasedProducts!,
                                  boxQuantity: 0,
                                  sheetQuantity: sheetQuantity);
                            }
                            if (value.isNotEmpty) {
                              final typedQuantity =
                                  double.tryParse(value)?.toInt() ?? 0;
                              if (typedQuantity >
                                  int.parse(widget
                                      .purchasedProducts!.boxQuantity
                                      .toString())) {
                                alert(context,
                                    'Return Quantity is greater then purchase quantity');
                                boxQtyController.text = '0';
                                setState(() {});
                                return;
                              }
                              if (typedQuantity <=
                                  widget.purchasedProducts!.boxQuantity!) {
                                // context.read<ReturnCubit>().returnQuantities(
                                //     widget.purchasedProducts!,
                                //     boxQuantity: typedQuantity,

                                //     sheetQuantity:
                                //     );
                                final productIndex = context
                                    .read<ReturnCubit>()
                                    .returnedProducts
                                    .indexWhere(
                                      (product) =>
                                          product.id ==
                                          widget.purchasedProducts?.id,
                                    );

                                // Check if product exists in returnedProducts
                                final sheetQuantity = (productIndex != -1)
                                    ? context
                                        .read<ReturnCubit>()
                                        .returnedProducts[productIndex]
                                        .sheetQuantity
                                    : 0;

                                // Call the returnQuantities function with the correct sheetQuantity
                                context.read<ReturnCubit>().returnQuantities(
                                      widget.purchasedProducts!,
                                      boxQuantity: typedQuantity,
                                      sheetQuantity: sheetQuantity,
                                    );
                              }
                            }
                          },
                          controller: boxQtyController,
                          verticalPadding: 2,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                      if (sheetQuantity != 0) const SizedBox(height: 5),
                      if (sheetQuantity != 0)
                        SizedBox(
                          height: 30,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 100,
                                child: TextFieldComponent(
                                  hintText: 'Sheet Qty',
                                  onChanged: (value) {
                                    if (value.isEmpty) {
                                      // Check if the product exists in the returned products list
                                      final productIndex = context
                                          .read<ReturnCubit>()
                                          .returnedProducts
                                          .indexWhere((product) =>
                                              product.id ==
                                              widget.purchasedProducts?.id);
                                      // Check if product exists in returnedProducts
                                      final boxQuantity = (productIndex != -1)
                                          ? context
                                              .read<ReturnCubit>()
                                              .returnedProducts[productIndex]
                                              .boxQuantity
                                          : 0;
                                      context
                                          .read<ReturnCubit>()
                                          .returnQuantities(
                                            widget.purchasedProducts!,
                                            sheetQuantity: 0,
                                            boxQuantity: boxQuantity,
                                          );
                                    }
                                    if (value.isNotEmpty) {
                                      final typedQuantity =
                                          int.tryParse(value) ?? 0;

                                      // Check if typedQuantity is greater than the available sheetQuantity
                                      if (typedQuantity >
                                          widget.purchasedProducts!
                                              .sheetQuantity!) {
                                        alert(context,
                                            'Return Quantity is greater than purchase quantity');
                                        sheetQtyController.text =
                                            '0'; // Reset the input to 0
                                        setState(() {});
                                        return;
                                      }

                                      if (typedQuantity <=
                                          widget.purchasedProducts!
                                              .sheetQuantity!) {
                                        // Check if the product exists in the returned products list
                                        final productIndex = context
                                            .read<ReturnCubit>()
                                            .returnedProducts
                                            .indexWhere((product) =>
                                                product.id ==
                                                widget.purchasedProducts?.id);
                                        // Check if product exists in returnedProducts
                                        final boxQuantity = (productIndex != -1)
                                            ? context
                                                .read<ReturnCubit>()
                                                .returnedProducts[productIndex]
                                                .boxQuantity
                                            : 0;
                                        context
                                            .read<ReturnCubit>()
                                            .returnQuantities(
                                              widget.purchasedProducts!,
                                              sheetQuantity: typedQuantity,
                                              boxQuantity: boxQuantity,
                                            );
                                      }
                                    }
                                  },
                                  controller: sheetQtyController,
                                  verticalPadding: 2,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                    ],
                  ),
          )
        ],
      ),
    );
  }
}
/*

/*
                                  setState(() {
                                totalAmount = totalAmount -
                                    (widget.purchasedProducts!.retailPrice! *
                                        int.parse(boxQtyController.text));
                                context
                                    .read<ReturnCubit>()
                                    .totalAmount(totalAmount);
                              });
                                setState(() {
                                totalAmount = (widget
                                            .purchasedProducts!.boxQuantity! *
                                        widget
                                            .purchasedProducts!.retailPrice!) +
                                    (widget.purchasedProducts!.sheetQuantity! *
                                        widget.purchasedProducts!.sheetPrice!);
                              });
                                */

   final typedQuantity =
                                double.tryParse(value)?.toInt() ?? 0;
                            if (typedQuantity <=
                                widget.purchasedProducts!.boxQuantity!) {
                            } else {
                              snack(context, quantityExceedsLimit.tr());
                              boxQtyController.text = widget
                                  .purchasedProducts!.boxQuantity!
                                  .toString();
                              boxQtyController.selection =
                                  TextSelection.fromPosition(
                                TextPosition(
                                    offset: boxQtyController.text.length),
                              );
                            }


                              final typedQuantity =
                                        int.tryParse(value) ?? 0;
                                    if (typedQuantity <=
                                        widget.purchasedProducts!
                                            .sheetQuantity!) {
                                      context
                                          .read<OrderedProductsCubit>()
                                          .updateSheetQuantity(
                                              widget.purchasedProducts!,
                                              typedQuantity);
                                    } else {
                                      sheetQtyController.text = widget
                                          .purchasedProducts!.sheetQuantity!
                                          .toString();
                                      sheetQtyController.selection =
                                          TextSelection.fromPosition(
                                        TextPosition(
                                            offset:
                                                sheetQtyController.text.length),
                                      );
                                    }
*/
