import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../main_barrel.dart';

// ignore: must_be_immutable
class ProductForm extends StatefulWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController barCodeController = TextEditingController();
  TextEditingController boxQuantityController = TextEditingController();
  TextEditingController boxRetailPriceController = TextEditingController();
  TextEditingController costPriceController = TextEditingController();
  TextEditingController sheetInBoxController = TextEditingController();
  TextEditingController tableInSheetController = TextEditingController();
  TextEditingController scientificNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController orderNumberController = TextEditingController();
  TextEditingController sourceController = TextEditingController();

  ProductForm({
    super.key,
    required this.nameController,
    required this.barCodeController,
    required this.boxQuantityController,
    required this.boxRetailPriceController,
    required this.costPriceController,
    required this.sheetInBoxController,
    required this.tableInSheetController,
    required this.scientificNameController,
    required this.descriptionController,
    required this.expiryDateController,
    required this.orderNumberController,
    required this.sourceController,
  });

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  DateTime? date;

  @override
  Widget build(BuildContext context) {
    context.locale.languageCode;
    return Column(
      children: [
        ResponsiveAligner(
          children: [
            TextFieldComponent(
              infoLabel: productName.tr(),
              prefixIconPath: Assets.productIcon,
              hintText: name.tr(),
              keyboardType: TextInputType.text,
              hideBorder: true,
              hideShadow: false,
              controller: widget.nameController,
              onChanged: (value) {},
            ),
            TextFieldComponent(
              infoLabel: barcodeNumber.tr(),
              prefixIconPath: Assets.barCodeIcon,
              hintText: number.tr(),
              keyboardType: TextInputType.number,
              hideBorder: true,
              hideShadow: false,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              controller: widget.barCodeController,
              onChanged: (value) {},
            ),
            TextFieldComponent(
              infoLabel: quantityOfBox.tr(),
              prefixIconPath: Assets.barCodeIcon,
              hintText: boxQuantity.tr(),
              keyboardType: TextInputType.number,
              hideBorder: true,
              hideShadow: false,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              controller: widget.boxQuantityController,
              onChanged: (value) {},
            ),
          ],
        ),
        ResponsiveAligner(
          children: [
            TextFieldComponent(
              infoLabel: boxRetailPrice.tr(),
              prefixIconPath: Assets.dollarIcon,
              hintText: retailPrice.tr(),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              controller: widget.boxRetailPriceController,
              keyboardType: TextInputType.number,
              onChanged: (value) {},
              hideBorder: true,
              hideShadow: false,
            ),
            TextFieldComponent(
              infoLabel: costPrice.tr(),
              prefixIconPath: Assets.dollarIcon,
              hintText: price.tr(),
              controller: widget.costPriceController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              onChanged: (value) {},
              hideBorder: true,
              hideShadow: false,
            ),
            TextFieldComponent(
              infoLabel: sheetIn1Box.tr(),
              prefixIconPath: Assets.boxSheetIcon,
              hintText: sheetIn1Box.tr(),
              controller: widget.sheetInBoxController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              onChanged: (value) {},
              hideBorder: true,
              hideShadow: false,
            )
          ],
        ),
        ResponsiveAligner(
          children: [
            TextFieldComponent(
              infoLabel: tabletIn1Sheet.tr(),
              prefixIconPath: Assets.tableSheetIcon,
              hintText: sheetTable.tr(),
              controller: widget.tableInSheetController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              onChanged: (value) {},
              hideBorder: true,
              hideShadow: false,
            ),
            TextFieldComponent(
              infoLabel: expiryDate.tr(),
              prefixIconPath: Assets.calendarIcon,
              controller: widget.expiryDateController,
              keyboardType: TextInputType.datetime,
              hideBorder: true,
              hideShadow: false,
              prefixIconColor: Palette.black,
              forceEnableTextColor: true,
              hintText: widget.expiryDateController.text.isEmpty
                  ? selectDate.tr()
                  : widget.expiryDateController.text,
              onTap: () async {
                date = await showDateDialog(context, date: date);
                if (date != null) {
                  widget.expiryDateController.text = formatDate(date!);
                }
              },
            ),
            TextFieldComponent(
              infoLabel: scientificName.tr(),
              prefixIconPath: Assets.scientifiNameIcon,
              hintText: scientificName.tr(),
              controller: widget.scientificNameController,
              keyboardType: TextInputType.text,
              onChanged: (value) {},
              hideBorder: true,
              hideShadow: false,
            ),
          ],
        ),
        ResponsiveAligner(
          children: [
            TextFieldComponent(
              infoLabel: orderNumber.tr(),
              prefixIconPath: Assets.tableSheetIcon,
              hintText: orderNumber.tr(),
              controller: widget.orderNumberController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              onChanged: (value) {},
              hideBorder: true,
              hideShadow: false,
            ),
            TextFieldComponent(
              infoLabel: source.tr(),
              prefixIconPath: Assets.scientifiNameIcon,
              hintText: source.tr(),
              controller: widget.sourceController,
              keyboardType: TextInputType.text,
              onChanged: (value) {},
              hideBorder: true,
              hideShadow: false,
            ),
            const SizedBox(),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        TextFieldComponent(
          controller: widget.descriptionController,
          prefixIconPath: Assets.descriptionIcon,
          maxLines: 7,
          minLines: 7,
          borderColor: Colors.transparent,
          hideBorder: true,
          hideShadow: false,
        ),
      ],
    );
  }
}
