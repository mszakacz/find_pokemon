import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon/favorites/favorites.dart';

void main() {
  group('FavoritesEvent', () {
    const oldIndex = 1;
    const newIndex = 2;

    group('FetchFavorites', () {
      test('supports value equality', () {
        expect(
          const FetchFavorites(),
          equals(const FetchFavorites()),
        );
      });
    });

    group('ReorderFavorites', () {
      test('supports value equality', () {
        expect(
          const ReorderFavorites(
            oldIndex: oldIndex,
            newIndex: newIndex,
          ),
          equals(
            const ReorderFavorites(
              oldIndex: oldIndex,
              newIndex: newIndex,
            ),
          ),
        );
      });

      test('props are correct', () {
        expect(
          const ReorderFavorites(
            oldIndex: oldIndex,
            newIndex: newIndex,
          ).props,
          equals(<Object?>[
            oldIndex,
            newIndex,
          ]),
        );
      });
    });
  });
}
