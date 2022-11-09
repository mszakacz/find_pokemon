part of 'menu_bloc.dart';

@immutable
abstract class MenuEvent extends Equatable {
  const MenuEvent();
}

class ChangeMenuIndex extends MenuEvent {
  const ChangeMenuIndex({
    required this.index,
  });
  final int index;

  @override
  List<Object?> get props => [
        index,
      ];
}
