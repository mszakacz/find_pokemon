import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon/menu/menu.dart';

void main() {
  group('MenuEvent', () {
    const index = 1;
    group('ChangeMenuIndex', () {
      test('supports value equality', () {
        expect(
          const ChangeMenuIndex(index: index),
          equals(
            const ChangeMenuIndex(index: index),
          ),
        );
      });

      test('props are correct', () {
        expect(
          const ChangeMenuIndex(index: index).props,
          equals(<Object?>[
            index,
          ]),
        );
      });
    });
  });
}
