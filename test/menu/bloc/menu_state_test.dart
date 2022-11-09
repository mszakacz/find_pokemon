// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon/menu/menu.dart';

void main() {
  group('MenuState', () {
    const index = 1;
    const index2 = 2;

    MenuState createSubject({
      int selectedIndex = index,
    }) {
      return MenuState(
        selectedIndex: selectedIndex,
      );
    }

    test('supports value equality', () {
      expect(
        createSubject(),
        equals(createSubject()),
      );
    });

    test('props are correct', () {
      expect(
        createSubject().props,
        equals(<Object?>[
          index, // selectedIndex
        ]),
      );
    });

    group('copyWith', () {
      test('returns the same object if not arguments are provided', () {
        expect(
          createSubject().copyWith(),
          equals(createSubject()),
        );
      });

      test('retains the old value for every parameter if null is provided', () {
        expect(
          createSubject().copyWith(
            selectedIndex: null,
          ),
          equals(createSubject()),
        );
      });

      test('replaces every non-null parameter', () {
        expect(
          createSubject().copyWith(
            selectedIndex: index2,
          ),
          equals(
            createSubject(
              selectedIndex: index2,
            ),
          ),
        );
      });
    });
  });
}
