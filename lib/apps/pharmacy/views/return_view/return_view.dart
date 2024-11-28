import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_assist/apps/pharmacy/views/return_view/return_desktop_view.dart';
import 'package:pharmacy_assist/apps/pharmacy/views/return_view/return_mobile_view.dart';
import 'package:pharmacy_assist/apps/pharmacy/views/return_view/return_tab_view.dart';
import 'package:pharmacy_assist/cubits/return_cubit/return_cubit.dart';
import 'package:pharmacy_assist/cubits/return_cubit/return_state.dart';
import '../../../../main_barrel.dart';

class ReturnView extends StatefulWidget {
  const ReturnView({super.key});

  @override
  State<ReturnView> createState() => _ReturnViewState();
}

class _ReturnViewState extends State<ReturnView> {
  final searchController = TextEditingController();
  int selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<ReturnCubit>(context).initializeTransactions();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final productCubit = BlocProvider.of<ReturnCubit>(context);
    productCubit.resetCubit();
    BlocProvider.of<ReturnCubit>(context).initializeTransactions();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReturnCubit, ReturnState>(
      listener: (context, state) {},
      child: BlocBuilder<ReturnCubit, ReturnState>(builder: (context, state) {
        if (state is ReturnLoading) {
          return const Center(
              child: CircularProgressIndicator(
            strokeCap: StrokeCap.round,
          ));
        } else if (state is ReturnError) {
          log('returnError: ${state.message}');
          return const Center(
              child: Text(
            'Failed to load Returns',
            style: CustomFontStyle.regularText,
          ));
        } else if (state is ReturnLoaded) {
          return Responsive(
            desktop: ReturnDesktopView(
              controller: searchController,
              currentPage: state.currentPage,
              totalPages: state.totalPages,
              onChanged: (value) {
                context.read<ReturnCubit>().searchTransactions(value);
              },
              retunsList: state.paginatedReturns,
              selectedIndex: selectedIndex,
            ),
            mobile: ReturnMobileView(
              controller: searchController,
              currentPage: state.currentPage,
              totalPages: state.totalPages,
              onChanged: (value) {
                context.read<ReturnCubit>().searchTransactions(value);
              },
              returns: state.paginatedReturns,
            ),
            tablet: ReturnTabView(
              controller: searchController,
              currentPage: state.currentPage,
              totalPages: state.totalPages,
              selectedIndex: selectedIndex,
              onChanged: (value) {
                context.read<ReturnCubit>().searchTransactions(value);
              },
              returns: state.paginatedReturns,
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
