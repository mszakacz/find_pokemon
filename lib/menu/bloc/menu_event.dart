part of 'menu_bloc.dart';

@immutable
abstract class MenuEvent {
  const MenuEvent();
}

class ChangeMenuIndex extends MenuEvent {
  const ChangeMenuIndex({
    required this.index,
  });
  final int index;
}
