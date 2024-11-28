import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../main_barrel.dart';
import 'navigation_states.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit(NavigationModel initialNav)
      : super(NavigationState([initialNav], 0));

  // Navigate to a new screen using the custom push method
  void updateNavigation(BuildContext context, NavigationModel newNav) {
    final newScreens = List<NavigationModel>.from(state.screens);

    // Check if the new screen is already in the stack
    if (newScreens.isEmpty || newScreens.last != newNav) {
      newScreens.add(newNav);
      emit(state.copyWith(
          screens: newScreens, activeIndex: newScreens.length - 1));
    }
  }

  // Replace the current screen with a new one
  void replaceNavigation(BuildContext context, NavigationModel newNav) {
    final newScreens = List<NavigationModel>.from(state.screens);

    if (newScreens.isEmpty || newScreens.last != newNav) {
      newScreens[state.activeIndex] = newNav;
      emit(state.copyWith(
          screens: newScreens, activeIndex: newScreens.length - 1));

      // Use your custom replace method to navigate
      replace(context, newNav.widget);
      emit(state);
    }
  }

  // Navigate back to the previous screen
  void navigateBack(BuildContext context) {
    if (state.activeIndex > 0) {
      final updatedScreens = List<NavigationModel>.from(state.screens);

      // Remove the current screen from the stack when navigating back
      updatedScreens.removeLast();

      emit(state.copyWith(
        screens: updatedScreens,
        activeIndex: updatedScreens.length - 1,
      ));
    } else {
      emit(state.copyWith(
          activeIndex:
              0)); // Stay at the first screen if no more screens are in the stack
    }
  }
}
