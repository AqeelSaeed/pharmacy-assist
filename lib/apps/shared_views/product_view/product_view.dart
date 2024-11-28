import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_assist/apps/shared_views/product_view/product_desktop_view.dart';
import 'package:pharmacy_assist/apps/shared_views/product_view/product_mobile_view.dart';
import 'package:pharmacy_assist/apps/shared_views/product_view/product_tablet_view.dart';
import '../../../cubits/product_cubit/product_cubit.dart';
import '../../../utils/responsive.dart';
import '../../../utils/shared_pref.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({super.key});

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  final searchController = TextEditingController();
  int selectedIndex = -1;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final productCubit = BlocProvider.of<ProductCubit>(context);
    productCubit.resetCubit();
    productCubit.fetchProducts(SharedPref.getString(key: 'uid'));
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductCubit, ProductState>(
      listener: (context, state) {
        if (state is ProductDeleted) {
          selectedIndex = -1;
        }
      },
      child: BlocBuilder<ProductCubit, ProductState>(
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
              desktop: ProductDesktopView(
                products: state.products,
                currentPage: state.currentPage,
                totalPages: state.totalPages,
                controller: searchController,
                selectedIndex: selectedIndex,
                onChanged: (value) {
                  context.read<ProductCubit>().searchProducts(value);
                },
              ),
              mobile: ProductsMobileView(
                products: state.products,
                currentPage: state.currentPage,
                totalPages: state.totalPages,
                controller: searchController,
                onChanged: (value) {
                  context.read<ProductCubit>().searchProducts(value);
                },
              ),
              tablet: ProductsTabletView(
                products: state.products,
                currentPage: state.currentPage,
                totalPages: state.totalPages,
                controller: searchController,
                onChanged: (value) {
                  context.read<ProductCubit>().searchProducts(value);
                },
              ),
            );
          } else if (state is ProductError) {
            return Center(child: Text(state.error));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
