import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../main_barrel.dart';
import '../../../../utils/shared_pref.dart';

// ignore: must_be_immutable
class DrugDepotTabletView extends StatefulWidget {
  final int totalPages;
  final int currentPage;
  List<DrugDepot> drugDeposList;
  final TextEditingController controller;
  int? selectedIndex;
  final void Function(String)? onChanged;
  DrugDepotTabletView(
      {super.key,
      required this.totalPages,
      required this.controller,
      required this.currentPage,
      required this.drugDeposList,
      required this.onChanged,
      required this.selectedIndex});

  @override
  State<DrugDepotTabletView> createState() => _DrugDepotTabletViewState();
}

class _DrugDepotTabletViewState extends State<DrugDepotTabletView> {
  int calculateColumns(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth > 1200) {
      return 2;
    } else if (screenWidth > 800) {
      return 2;
    } else {
      return 1;
    }
  }

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
                  child: GridView.builder(
                    padding: const EdgeInsets.only(right: 16, bottom: 16),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: calculateColumns(context),
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      childAspectRatio:
                          MediaQuery.of(context).size.aspectRatio * 2.3,
                    ),
                    itemCount: widget.drugDeposList.length,
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
                      crossAxisAlignment: CrossAxisAlignment.center,
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
