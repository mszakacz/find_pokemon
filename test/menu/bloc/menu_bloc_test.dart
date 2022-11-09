import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon/menu/menu.dart';

void main() {
  group('MenuBloc', () {
    MenuBloc buildBloc() {
      return MenuBloc();
    }

    group('constructor', () {
      test('works properly', () {
        expect(buildBloc, returnsNormally);
      });

      test('has correct initial state', () {
        expect(
          buildBloc().state,
          equals(
            const MenuState(
              selectedIndex: 0,
            ),
          ),
        );
      });
    });

    group('ChangeMenuIndex', () {
      blocTest<MenuBloc, MenuState>(
        'emits new state with new index',
        build: buildBloc,
        seed: () => const MenuState(
          selectedIndex: 0,
        ),
        act: (bloc) => bloc.add(
          const ChangeMenuIndex(index: 1),
        ),
        expect: () => const [
          MenuState(
            selectedIndex: 1,
          ),
        ],
      );
    });
  });
}
