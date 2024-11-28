import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_assist/apps/pharmacy/components/pharmacy_sidebar_component.dart';
import '../../../cubits/navigation_cubit/navigation_states.dart';
import '../../../main_barrel.dart';

class PharmacyBaseNavigation extends StatefulWidget {
  const PharmacyBaseNavigation({super.key});

  @override
  State<PharmacyBaseNavigation> createState() => _PharmacyBaseNavigationState();
}

class _PharmacyBaseNavigationState extends State<PharmacyBaseNavigation> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final initialNavv = NavigationModel(
      dashboard.tr(),
      const PharmacyDashboard(),
    );

    return BlocProvider(
      create: (context) => NavigationCubit(initialNavv),
      child: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
          return Row(
            children: [
              if (Responsive.isDesktop(context))
                const PharmacySideBarComponent(),
              Expanded(
                child: Scaffold(
                  key: _scaffoldKey,
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    shadowColor: Colors.black26,
                    backgroundColor: Colors.white,
                    surfaceTintColor: Colors.white,
                    elevation: 8,
                    toolbarHeight: 86,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (!Responsive.isDesktop(context))
                          IconButton(
                            onPressed: () {
                              if (!Responsive.isDesktop(context)) {
                                _scaffoldKey.currentState?.openDrawer();
                              }
                            },
                            style: IconButton.styleFrom(
                                splashFactory: NoSplash.splashFactory,
                                backgroundColor: Palette.lightGreen),
                            icon: const Padding(
                              padding: EdgeInsets.all(3),
                              child: Icon(Icons.menu,
                                  color: Palette.green, size: 40),
                            ),
                          ),
                        const Spacer(),
                        if (Responsive.isDesktop(context))
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                height: 54,
                                width: 54,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xff9CCDFF),
                                ),
                                child: const Icon(
                                  Icons.notifications_rounded,
                                  color: Palette.primary,
                                ),
                              ),
                            ),
                          ),
                        const SizedBox(
                          width: 50,
                        ),
                        PopupMenuButton(
                          tooltip: changeLanguages.tr(),
                          onSelected: (locale) {
                            setState(() {
                              context.setLocale(locale);
                            });
                          },
                          itemBuilder: (BuildContext context) {
                            return const [
                              PopupMenuItem(
                                value: Locale('en'),
                                child: Text('English'),
                              ),
                              PopupMenuItem(
                                value: Locale('ar'),
                                child: Text('Arabic'),
                              ),
                              // PopupMenuItem(
                              //   value: Locale('ur'),
                              //   child: Text('Kurdish'),
                              // ),
                            ];
                          },
                          child: Image.asset(
                            Assets.translationIcon,
                            height: 30,
                            color: Palette.primary,
                          ),
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Mr. Herald',
                              style: CustomFontStyle.regularText.copyWith(
                                  color: Palette.primary,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Life Care Pharmacy',
                              style: CustomFontStyle.regularText
                                  .copyWith(fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 60,
                              width: 60,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: AssetImage(Assets.dummyParmacy))),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  drawer: !Responsive.isDesktop(context)
                      ? const PharmacySideBarComponent()
                      : null,
                  body: state.screens[state.activeIndex]
                      .widget, // Active widget based on state
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
