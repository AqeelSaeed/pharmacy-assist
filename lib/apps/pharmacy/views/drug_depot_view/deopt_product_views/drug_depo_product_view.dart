import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../main_barrel.dart';

class DrugDepoProductView extends StatefulWidget {
  final String uid;
  const DrugDepoProductView({super.key, required this.uid});

  @override
  State<DrugDepoProductView> createState() => _DrugDepoProductViewState();
}

class _DrugDepoProductViewState extends State<DrugDepoProductView> {
  final searchController = TextEditingController();
  int selectedIndex = -1;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final productCubit = BlocProvider.of<ProductCubit>(context);
    productCubit.resetCubit();
    productCubit.fetchProducts(widget.uid);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
        buildWhen: (previous, current) =>
            current is! DeletingProduct &&
            current is! UploadingFile &&
            current is! PosProductList &&
            current is! FileUploaded,
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductLoaded) {
            return Responsive(
              desktop: DepotProductDesktopView(
                uid: widget.uid,
                controller: searchController,
                currentPage: state.currentPage,
                productList: state.products,
                selectedIndex: selectedIndex,
                totalPages: state.totalPages,
                onChanged: (value) {
                  context.read<ProductCubit>().searchProducts(value);
                },
              ),
              mobile: DepotProductMobileView(
                controller: searchController,
                currentPage: state.currentPage,
                productList: state.products,
                selectedIndex: selectedIndex,
                totalPages: state.totalPages,
                onChanged: (value) {
                  context.read<ProductCubit>().searchProducts(value);
                },
              ),
              tablet: DepotProductTabView(
                controller: searchController,
                currentPage: state.currentPage,
                productList: state.products,
                selectedIndex: selectedIndex,
                totalPages: state.totalPages,
                onChanged: (value) {
                  context.read<ProductCubit>().searchProducts(value);
                },
              ),
            );
          } else if (state is ProductError) {
            return Center(child: Text('${error.tr()}: ${state.error}'));
          } else {
            log('product desktop viewssss');
            return Container();
          }
        });
  }
}
