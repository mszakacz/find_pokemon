// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:pokemons_repository/pokemons_repository.dart';

void main() {
  group('PokemonsRepository', () {
    test('can be instantiated', () {
      expect(PokemonsRepository(), isNotNull);
    });
  });
}
