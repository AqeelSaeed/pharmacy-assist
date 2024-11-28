import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../main_barrel.dart';
import 'product_form.dart';

class AddUpdateProductView extends StatefulWidget {
  final ProductModel? product;
  final bool showImage;

  const AddUpdateProductView({super.key, this.product, this.showImage = true});

  @override
  State<AddUpdateProductView> createState() => _AddUpdateProductViewState();
}

class _AddUpdateProductViewState extends State<AddUpdateProductView> {
  String? selectedShop;
  var nameController = TextEditingController();
  var barCodeController = TextEditingController();
  var boxQuantityController = TextEditingController();
  var boxRetailPriceController = TextEditingController();
  var costPriceController = TextEditingController();
  var sheetInBoxController = TextEditingController();
  var tableInSheetController = TextEditingController();
  var scientificNameController = TextEditingController();
  var descriptionController = TextEditingController();
  var expiryDateController = TextEditingController();
  var orderNumberController = TextEditingController();
  var sourceController = TextEditingController();
  DateTime? date;
  String? imageUrl;
  Uint8List? uintImage;

  @override
  void initState() {
    if (widget.product != null) {
      imageUrl = widget.product?.productImage;
      nameController.text = widget.product!.productName ?? '';
      barCodeController.text = widget.product!.barcode ?? '';
      boxQuantityController.text = widget.product!.boxQuantity.toString();
      boxRetailPriceController.text = widget.product!.retailPrice.toString();
      costPriceController.text = widget.product!.costPrice.toString();
      sheetInBoxController.text = widget.product!.sheetInBox.toString();
      tableInSheetController.text = widget.product!.tabletInSheet.toString();
      expiryDateController.text = widget.product!.expiryDate.toString();
      scientificNameController.text = widget.product!.scientificName.toString();
      descriptionController.text = widget.product!.description.toString();
      expiryDateController.text =
          formatDateByString(widget.product!.expiryDate.toString());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.locale.languageCode;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: BackPressWidget(
                title: widget.product != null
                    ? updateProduct.tr()
                    : addProduct.tr(),
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 35, horizontal: 25),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      if (widget.showImage) ...[
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () async {
                              uintImage = await pickImageWeb();
                              if (uintImage != null) {
                                widget.product!.productImage = null;
                                log('productImage: ${widget.product!.productImage}');
                                setState(() {});
                              }
                            },
                            child: Container(
                              height: 130,
                              width: 130,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Palette.secondary,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    blurRadius: 14,
                                    offset: const Offset(1, 3),
                                  ),
                                ],
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: widget.product?.productImage != null
                                        ? NetworkImage(
                                            'https://assist-iq.com/storage/app/public/${widget.product?.productImage}')
                                        : uintImage != null
                                            ? MemoryImage(
                                                uintImage ?? Uint8List(0))
                                            : const AssetImage(
                                                Assets.uploadIcon),
                                    fit: BoxFit.scaleDown),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          uploadPhoto.tr(),
                          style:
                              CustomFontStyle.boldText.copyWith(fontSize: 20),
                        ),
                        const SizedBox(height: 20),
                      ],
                      ProductForm(
                          nameController: nameController,
                          barCodeController: barCodeController,
                          boxQuantityController: boxQuantityController,
                          boxRetailPriceController: boxRetailPriceController,
                          costPriceController: costPriceController,
                          sheetInBoxController: sheetInBoxController,
                          tableInSheetController: tableInSheetController,
                          scientificNameController: scientificNameController,
                          descriptionController: descriptionController,
                          expiryDateController: expiryDateController,
                          orderNumberController: orderNumberController,
                          sourceController: sourceController),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          BlocConsumer<ProductCubit, ProductState>(
                              listener: (context, state) {
                            if (state is ProductError) {
                              alert(info: false, context, state.error);
                            }
                            if (state is ProductAdded) {
                              alert(info: true, context, state.message,
                                  onTap: () {
                                Navigator.pop(context);
                                context
                                    .read<NavigationCubit>()
                                    .updateNavigation(
                                        context,
                                        NavigationModel('ProductView',
                                            const ProductsView()));
                              });
                            }
                          }, builder: (context, state) {
                            return ButtonComponent(
                              isLoading: state is AddingProduct,
                              maxWidth: 170,
                              text: widget.product?.id != null
                                  ? updateProduct.tr()
                                  : addProduct.tr(),
                              fontWeight: FontWeight.w400,
                              onPressed: () {
                                submitProduct();
                              },
                            );
                          })
                        ],
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void submitProduct() {
    if (nameController.text.isEmpty) {
      alert(info: false, context, productNameCannotBeEmpty.tr());
      return;
    }
    if (barCodeController.text.isEmpty) {
      alert(info: false, context, barcodeCannotBeEmpty.tr());
      return;
    }
    if (boxQuantityController.text.isEmpty ||
        double.tryParse(boxQuantityController.text) == null) {
      alert(info: false, context, invalidBoxQuantity.tr());
      return;
    }
    if (costPriceController.text.isEmpty ||
        double.tryParse(costPriceController.text) == null) {
      alert(info: false, context, invalidCostPrice.tr());
      return;
    }
    if (boxRetailPriceController.text.isEmpty ||
        double.tryParse(boxRetailPriceController.text) == null) {
      alert(info: false, context, invalidRetailPrice.tr());
      return;
    }
    if (expiryDateController.text.isEmpty) {
      alert(info: false, context, expiryDateCannotBeEmpty.tr());
      return;
    }
    if (scientificNameController.text.isEmpty) {
      alert(info: false, context, scientificNameCannotBeEmpty.tr());
      return;
    } else {
      if (widget.product != null) {
        log('Product ID is not null: ${widget.product!.id} and edit products here');
        context
            .read<ProductCubit>()
            .updateProdcut(
              isPaid: widget.product!.isPaid ?? false,
              isBuldImport: widget.product!.isBulkImport ?? false,
              productId: widget.product!.id ?? '',
              productName: nameController.text,
              barcode: barCodeController.text,
              boxQuantity: double.parse(boxQuantityController.text),
              sheetInBox: int.parse(sheetInBoxController.text),
              costPrice: double.parse(costPriceController.text),
              retailPrice: double.parse(boxRetailPriceController.text),
              expiryDate: expiryDateController.text,
              description: descriptionController.text,
              scientificName: scientificNameController.text,
              source: sourceController.text,
              orderNo: orderNumberController.text,
              tableInSheet: int.parse(tableInSheetController.text),
              image: uintImage ?? Uint8List(0),
            )
            .then((result) {
          // if (result['success'] == true) {
          //   context.read<NavigationCubit>().updateNavigation(
          //       context, NavigationModel('ProductView', const ProductsView()));
          // }
        });
      } else {
        context.read<ProductCubit>().addProduct(
              productName: nameController.text,
              barcode: barCodeController.text,
              boxQuantity: int.parse(boxQuantityController.text),
              sheetInBox: int.parse(sheetInBoxController.text),
              costPrice: double.parse(costPriceController.text),
              retailPrice: double.parse(boxRetailPriceController.text),
              expiryDate: expiryDateController.text,
              description: descriptionController.text,
              scientificName: scientificNameController.text,
              source: sourceController.text,
              orderNo: orderNumberController.text,
              tableInSheet: int.parse(tableInSheetController.text),
              productImage: uintImage ?? Uint8List(0),
            );
      }
    }
  }
}
