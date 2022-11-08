part of 'menu_bloc.dart';

class MenuState extends Equatable {
  const MenuState({
    required this.selectedIndex,
  });
  final int selectedIndex;

  @override
  List<Object> get props => [
        selectedIndex,
      ];

  MenuState copyWith({
    int? selectedIndex,
  }) {
    return MenuState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }
}
