import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_assist/cubits/drug_depo_cubit/drug_state.dart';

import '../../../../main_barrel.dart';

class DrugDepoViews extends StatefulWidget {
  const DrugDepoViews({super.key});

  @override
  State<DrugDepoViews> createState() => _DrugDepoViewsState();
}

class _DrugDepoViewsState extends State<DrugDepoViews> {
  final searchController = TextEditingController();
  int selectedIndex = -1;
  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      context.read<DrugDepoCubit>().searchDepos(searchController.text);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<DrugDepoCubit>(context).fetchDepots();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final depoCubit = BlocProvider.of<DrugDepoCubit>(context);
    depoCubit.resetCubit();
    depoCubit.fetchDepots();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DrugDepoCubit, DrugDepoState>(builder: (context, state) {
      if (state is DrugDepoLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is DrugDepoLoaded) {
        return Responsive(
          desktop: DrugDepotDesktopView(
            controller: searchController,
            currentPage: state.currentPage,
            totalPages: state.totalPages,
            drugDeposList: state.drugDepos,
            onChanged: (value) {
              context.read<DrugDepoCubit>().searchDepos(value);
            },
            selectedIndex: selectedIndex,
          ),
          mobile: DrugDepotMobileView(
            controller: searchController,
            currentPage: state.currentPage,
            totalPages: state.totalPages,
            drugDeposList: state.drugDepos,
            onChanged: (value) {
              context.read<DrugDepoCubit>().searchDepos(value);
            },
            selectedIndex: selectedIndex,
          ),
          tablet: DrugDepotTabletView(
            controller: searchController,
            currentPage: state.currentPage,
            totalPages: state.totalPages,
            drugDeposList: state.drugDepos,
            onChanged: (value) {
              context.read<DrugDepoCubit>().searchDepos(value);
            },
            selectedIndex: selectedIndex,
          ),
        );
      } else if (state is DrugDepoError) {
        return const Center(
            child: Text(
          'Failed to load Drug depos',
          style: CustomFontStyle.boldText,
        ));
      } else {
        return const Center(
            child: Text(
          'Failed to load Drug depos',
          style: CustomFontStyle.boldText,
        ));
      }
    });
  }
}
