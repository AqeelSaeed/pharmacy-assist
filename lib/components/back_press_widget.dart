import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../main_barrel.dart';

class BackPressWidget extends StatelessWidget {
  final String title;
  const BackPressWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Row(
        children: [
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                context.read<NavigationCubit>().navigateBack(context);
              },
              child: Container(
                height: 40,
                width: 40,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Palette.backButonColor,
                ),
                child: Image.asset(Assets.backIcon),
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Text(
            title,
            style: CustomFontStyle.regularText.copyWith(fontSize: 25),
          )
        ],
      ),
    );
  }
}
