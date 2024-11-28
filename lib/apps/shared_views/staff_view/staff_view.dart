import 'package:flutter/material.dart';
import 'package:pharmacy_assist/main_barrel.dart';

class StaffView extends StatefulWidget {
  const StaffView({super.key});

  @override
  State<StaffView> createState() => _StaffViewState();
}

class _StaffViewState extends State<StaffView> {
  final searchController = TextEditingController();
  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Responsive(
      desktop: StaffDesktopView(
        controller: searchController,
        currentPage: 1,
        selectedIndex: 1,
        totalPages: 3,
        onChanged: (value) {},
      ),
      tablet: const StaffTabView(),
      mobile: const StaffMobileView(),
    );
  }
}
