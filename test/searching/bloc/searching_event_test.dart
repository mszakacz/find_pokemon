import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon/searching/searching.dart';

void main() {
  group('SearchingEvent', () {
    const phrase = 'phrase';
    group('FetchPokemons', () {
      test('supports value equality', () {
        expect(
          const FetchPokemons(phrase: phrase),
          equals(
            const FetchPokemons(phrase: phrase),
          ),
        );
      });
    });

    test('props are correct', () {
      expect(
        const FetchPokemons(phrase: phrase).props,
        equals(<Object?>[
          phrase,
        ]),
      );
    });
  });
}
