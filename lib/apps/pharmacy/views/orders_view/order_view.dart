import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../cubits/sales_cubit/sales_state.dart';
import '../../../../main_barrel.dart';

class OrderView extends StatefulWidget {
  const OrderView({super.key});

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
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
          return const Center(
              child: Text(
            'Failed to load Sales',
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
