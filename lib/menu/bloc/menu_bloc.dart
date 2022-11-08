import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'menu_event.dart';
part 'menu_state.dart';

const _initialIndex = 0;

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  MenuBloc()
      : super(
          const MenuState(
            selectedIndex: _initialIndex,
          ),
        ) {
    on<ChangeMenuIndex>(_onChangeMenuIndex);
  }

  void _onChangeMenuIndex(
    ChangeMenuIndex event,
    Emitter<MenuState> emit,
  ) {
    emit(
      state.copyWith(
        selectedIndex: event.index,
      ),
    );
  }
}
