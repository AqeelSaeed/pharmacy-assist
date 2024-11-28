import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_assist/apps/handle_view.dart';
import 'package:pharmacy_assist/cubits/ordered_products_cubit/ordered_products_cubit.dart';
import 'package:pharmacy_assist/cubits/return_cubit/return_cubit.dart';
import 'package:pharmacy_assist/main_barrel.dart';
import 'package:pharmacy_assist/utils/shared_pref.dart';
import 'package:sizer/sizer.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  SharedPref.init();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar'), Locale('ur')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<NavigationCubit>(
            create: (BuildContext context) =>
                NavigationCubit(NavigationModel('login', const LoginView())),
          ),
          BlocProvider<AuthCubit>(
            create: (BuildContext context) => AuthCubit(),
          ),
          BlocProvider<OtpCubit>(
            create: (BuildContext context) => OtpCubit(),
          ),
          BlocProvider<ForgotCubit>(
            create: (BuildContext context) => ForgotCubit(),
          ),
          BlocProvider<ChangePasswordCubit>(
            create: (BuildContext context) => ChangePasswordCubit(),
          ),
          BlocProvider<ProductCubit>(
            create: (BuildContext context) => ProductCubit(),
          ),
          BlocProvider<DrugDepoCubit>(
            create: (BuildContext context) => DrugDepoCubit(),
          ),
          BlocProvider<SalesCubit>(
            create: (BuildContext context) => SalesCubit(),
          ),
          BlocProvider<POSCubit>(
            create: (BuildContext context) => POSCubit(),
          ),
          BlocProvider<OrderedProductsCubit>(
            create: (BuildContext context) => OrderedProductsCubit(),
          ),
          BlocProvider<ReturnCubit>(
            create: (BuildContext context) => ReturnCubit(),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, child) {
        return MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: themeData(),
          home: const HandleLogin(),
        );
      },
    );
  }
}
