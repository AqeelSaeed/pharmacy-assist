import 'package:flutter/material.dart';

class StaffTabView extends StatefulWidget {
  const StaffTabView({super.key});

  @override
  State<StaffTabView> createState() => _StaffTabViewState();
}

class _StaffTabViewState extends State<StaffTabView> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Staff Tab View'),
    );
  }
}
