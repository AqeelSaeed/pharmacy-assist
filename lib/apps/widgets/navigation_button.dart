// navigation_button.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/navigation_cubit/navigation_states.dart';

import '../../main_barrel.dart';

class NavigationButton extends StatelessWidget {
  final String title;
  final String iconPath;
  final VoidCallback? navigateTo;

  const NavigationButton({
    required this.title,
    required this.iconPath,
    this.navigateTo,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        bool isSelected = state.screens[state.activeIndex].title == title;
        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
          ),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: navigateTo,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Palette.primary.withOpacity(0.5)
                            : Colors.transparent,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: Row(
                        children: [
                          Image.asset(iconPath, width: 26, color: Colors.white),
                          const SizedBox(width: 16),
                          Text(
                            title,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  isSelected
                      ? Container(
                          padding: EdgeInsets.zero,
                          width: 9,
                          height: 60,
                          color: const Color(0xff47A3FF),
                        )
                      : const SizedBox.shrink()
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
