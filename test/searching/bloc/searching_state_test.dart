// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon/searching/searching.dart';

void main() {
  const pokemonName = 'pokemonName';
  const mockPokemons = <String>[pokemonName];
  const mockPokemons2 = <String>['name1', 'name2'];

  group('SearchingState', () {
    SearchingState createSubject({
      List<String>? results,
      SearchingStatus status = SearchingStatus.loading,
    }) {
      return SearchingState(
        status: status,
        results: results ?? mockPokemons,
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
        createSubject(
          results: mockPokemons,
          status: SearchingStatus.display,
        ).props,
        equals(<Object?>[
          SearchingStatus.display, // status
          mockPokemons, // results
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
            results: null,
            status: null,
          ),
          equals(createSubject()),
        );
      });

      test('replaces every non-null parameter', () {
        expect(
          createSubject().copyWith(
            results: mockPokemons2,
            status: SearchingStatus.error,
          ),
          equals(
            createSubject(
              results: mockPokemons2,
              status: SearchingStatus.error,
            ),
          ),
        );
      });
    });
  });
}
