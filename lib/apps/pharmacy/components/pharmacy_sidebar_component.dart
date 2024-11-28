import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_assist/apps/pharmacy/views/return_view/return_view.dart';
import '../../../cubits/navigation_cubit/navigation_states.dart';
import '../../../main_barrel.dart';

class PharmacySideBarComponent extends StatelessWidget {
  const PharmacySideBarComponent({super.key});

  @override
  Widget build(BuildContext context) {
    log(context.locale.toString());
    return Material(
      child: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            // width: state.isSidebarExpanded ? 320 : 113,
            child: Drawer(
              elevation: 10,
              backgroundColor: Palette.primary,
              shape: const RoundedRectangleBorder(),
              child: Stack(children: [
                Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                        Palette.loginGradiant1,
                        Palette.loginGradiant2
                      ])),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 60, vertical: 24),
                        child: Image.asset(
                          Assets.assist1,
                        ),
                      ),
                      const SizedBox(height: 25),
                      NavigationButton(
                        title: dashboard.tr(),
                        iconPath: Assets.dashoardIcon,
                        navigateTo: () {
                          BlocProvider.of<NavigationCubit>(context)
                              .updateNavigation(
                            context,
                            NavigationModel(
                              dashboard.tr(),
                              const PharmacyDashboard(),
                            ),
                          );
                        },
                      ),
                      NavigationButton(
                        title: products.tr(),
                        iconPath: Assets.productsIcon,
                        navigateTo: () {
                          BlocProvider.of<NavigationCubit>(context)
                              .updateNavigation(
                            context,
                            NavigationModel(
                              products.tr(),
                              const ProductsView(),
                            ),
                          );
                        },
                      ),
                      NavigationButton(
                        title: drugDepot.tr(),
                        iconPath: Assets.drugDepoIcon,
                        navigateTo: () {
                          BlocProvider.of<NavigationCubit>(context)
                              .updateNavigation(
                            context,
                            NavigationModel(
                                drugDepot.tr(), const DrugDepoViews()),
                          );
                        },
                      ),
                      NavigationButton(
                        title: pos.tr(),
                        iconPath: Assets.posIcon,
                        navigateTo: () {
                          BlocProvider.of<NavigationCubit>(context)
                              .updateNavigation(
                            context,
                            NavigationModel(pos.tr(), const PosViews()),
                          );
                        },
                      ),
                      NavigationButton(
                        title: sales.tr(),
                        iconPath: Assets.salesIcon,
                        navigateTo: () {
                          BlocProvider.of<NavigationCubit>(context)
                              .updateNavigation(
                            context,
                            NavigationModel(
                              sales.tr(),
                              const SalesView(),
                            ),
                          );
                        },
                      ),
                      NavigationButton(
                        title: finance.tr(),
                        iconPath: Assets.financeIcon,
                        navigateTo: () {
                          BlocProvider.of<NavigationCubit>(context)
                              .updateNavigation(
                            context,
                            NavigationModel(
                              finance.tr(),
                              Center(
                                child: Text(finance.tr()),
                              ),
                            ),
                          );
                        },
                      ),
                      NavigationButton(
                        title: orders.tr(),
                        iconPath: Assets.ordersIcon,
                        navigateTo: () {
                          BlocProvider.of<NavigationCubit>(context)
                              .updateNavigation(
                            context,
                            NavigationModel(
                              orders.tr(),
                              Center(
                                child: Text(orders.tr()),
                              ),
                            ),
                          );
                        },
                      ),
                      NavigationButton(
                        title: returns.tr(),
                        iconPath: Assets.returnsIcon,
                        navigateTo: () {
                          BlocProvider.of<NavigationCubit>(context)
                              .updateNavigation(
                            context,
                            NavigationModel(
                              returns.tr(),
                              const ReturnView(),
                            ),
                          );
                        },
                      ),
                      NavigationButton(
                        title: expirations.tr(),
                        iconPath: Assets.expiriesIcon,
                        navigateTo: () {
                          BlocProvider.of<NavigationCubit>(context)
                              .updateNavigation(
                            context,
                            NavigationModel(
                              expirations.tr(),
                              Center(
                                child: Text(expirations.tr()),
                              ),
                            ),
                          );
                        },
                      ),
                      NavigationButton(
                        title: staff.tr(),
                        iconPath: Assets.staffIcon,
                        navigateTo: () {
                          BlocProvider.of<NavigationCubit>(context)
                              .updateNavigation(
                            context,
                            NavigationModel(
                              staff.tr(),
                              const StaffView(),
                            ),
                          );
                        },
                      ),
                      NavigationButton(
                        title: settings.tr(),
                        iconPath: Assets.settingsIcon,
                        navigateTo: () {
                          BlocProvider.of<NavigationCubit>(context)
                              .updateNavigation(
                            context,
                            NavigationModel(
                              settings.tr(),
                              Center(
                                child: Text(settings.tr()),
                              ),
                            ),
                          );
                        },
                      ),
                      NavigationButton(
                        title: logout.tr(),
                        iconPath: Assets.logoutIcon,
                        navigateTo: () {
                          replace(context, const LoginView());
                        },
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          );
        },
      ),
    );
  }
}
