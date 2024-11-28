import 'package:flutter/material.dart';
import 'package:pharmacy_assist/apps/pharmacy/views/pharmacy_base_navigation.dart';
import '../main_barrel.dart';

class HandleLogin extends StatefulWidget {
  const HandleLogin({super.key});

  @override
  State<HandleLogin> createState() => _HandleLoginState();
}

class _HandleLoginState extends State<HandleLogin> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: AuthRepo.instance.getAuthUser(),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return getLoader();
        } else if (snap.hasError || !snap.hasData) {
          return const LoginView();
        } else {
          final String role = snap.data!['role'];
          switch (role) {
            case 'admin':
              return Container();
            case 'pharmacy':
              return const PharmacyBaseNavigation();
            case 'drugDepot':
              return Container();
            default:
              return const LoginView();
          }
        }
      },
    );
  }
}
