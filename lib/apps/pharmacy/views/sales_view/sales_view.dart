import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_assist/cubits/sales_cubit/sales_state.dart';
import '../../../../main_barrel.dart';

class SalesView extends StatefulWidget {
  const SalesView({super.key});

  @override
  State<SalesView> createState() => _SalesViewState();
}

class _SalesViewState extends State<SalesView> {
  final searchController = TextEditingController();
  int selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<SalesCubit>(context).fetchAllSales();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final productCubit = BlocProvider.of<SalesCubit>(context);
    productCubit.resetCubit();
    BlocProvider.of<SalesCubit>(context).fetchAllSales();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SalesCubit, SalesState>(
      listener: (context, state) {},
      child: BlocBuilder<SalesCubit, SalesState>(builder: (context, state) {
        if (state is SalesLoading) {
          return const Center(
              child: CircularProgressIndicator(
            strokeCap: StrokeCap.round,
          ));
        } else if (state is SalesError) {
          return Center(
              child: Text(
            'Failed to load Sales: ${state.message}',
            style: CustomFontStyle.regularText,
          ));
        } else if (state is SalesLoaded) {
          return Responsive(
            desktop: SalesDesktopView(
              controller: searchController,
              currentPage: state.currentPage,
              totalPages: state.totalPages,
              onChanged: (value) {
                context.read<SalesCubit>().searchSales(value);
              },
              salesList: state.paginatedSales,
              selectedIndex: selectedIndex,
            ),
            mobile: SalesMobileView(
              controller: searchController,
              currentPage: state.currentPage,
              totalPages: state.totalPages,
              onChanged: (value) {
                context.read<SalesCubit>().searchSales(value);
              },
              sales: state.paginatedSales,
            ),
            tablet: SalesTabView(
              controller: searchController,
              currentPage: state.currentPage,
              totalPages: state.totalPages,
              selectedIndex: selectedIndex,
              onChanged: (value) {
                context.read<SalesCubit>().searchSales(value);
              },
              sales: state.paginatedSales,
            ),
          );
        } else {
          log('Something went wrong please check');
          return Container();
        }
      }),
    );
  }
}
