import '../../models/navigation_model.dart';

class NavigationState {
  final List<NavigationModel> screens;
  final int activeIndex;

  NavigationState(this.screens, this.activeIndex);

  NavigationState copyWith({List<NavigationModel>? screens, int? activeIndex}) {
    return NavigationState(
      screens ?? this.screens,
      activeIndex ?? this.activeIndex,
    );
  }
}
