import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_assist/utils/shared_pref.dart';
import '../../../../main_barrel.dart';

// ignore: must_be_immutable
class DrugDepotMobileView extends StatefulWidget {
  final int totalPages;
  final int currentPage;
  List<DrugDepot> drugDeposList;
  final TextEditingController controller;
  int? selectedIndex;
  final void Function(String)? onChanged;
  DrugDepotMobileView(
      {super.key,
      required this.totalPages,
      required this.controller,
      required this.currentPage,
      required this.drugDeposList,
      required this.onChanged,
      required this.selectedIndex});

  @override
  State<DrugDepotMobileView> createState() => _DrugDepotMobileViewState();
}

class _DrugDepotMobileViewState extends State<DrugDepotMobileView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(45, 45, 45, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: Responsive.isMobile(context)
                  ? MediaQuery.sizeOf(context).width * 0.55
                  : 356,
            ),
            child: TextFieldComponent(
                hintText: searchPlaceholder.tr(),
                controller: widget.controller,
                hideShadow: true,
                onChanged: widget.onChanged,
                hideBorder: true,
                prefixIconPath: Assets.searchIcon),
          ),
          const SizedBox(height: 20),
          widget.drugDeposList.isNotEmpty
              ? Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.only(right: 16, bottom: 16),
                    itemCount:
                        widget.drugDeposList.length, // Single item per row
                    shrinkWrap: true,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      return DrugTileWidget(
                        depoModel: widget.drugDeposList[index],
                        onTap: () {
                          setState(() {
                            widget.selectedIndex = index;
                          });
                          context.read<NavigationCubit>().updateNavigation(
                              context,
                              NavigationModel(
                                  'Product Detail',
                                  DrugDepoProductView(
                                    uid: SharedPref.getString(key: 'uid'),
                                  )));
                        },
                      );
                    },
                  ),
                )
              : Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          Assets.noProductsIcon,
                          height: 120,
                        ),
                        Text(
                          noDrugDepotFound.tr(),
                          style: CustomFontStyle.boldText,
                        ),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
