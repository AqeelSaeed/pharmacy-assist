import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../main_barrel.dart';
import '../../../../utils/shared_pref.dart';

class PosViews extends StatefulWidget {
  const PosViews({super.key});

  @override
  State<PosViews> createState() => _PosViewsState();
}

class _PosViewsState extends State<PosViews> {
  final searchController = TextEditingController();

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
    return Responsive(
      desktop: PosDesktopView(
        controller: searchController,
        onChanged: (value) {
          context.read<ProductCubit>().searchProducts(value);
        },
      ),
      mobile: const PosMobileView(),
      tablet: PosTabletView(
          controller: searchController,
          onChanged: (value) {
            context.read<ProductCubit>().searchProducts(value);
          }),
    );
  }
}
