import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon/pokemon_images/pokemon_images.dart';
import 'package:pokemons_repository/pokemons_repository.dart';

import '../../helpers/helpers.dart';

void main() {
  const pokemon = Pokemon(
    id: 1,
    name: 'pokemonName',
    pictures: [
      'frontDefault.jpg',
    ],
    stats: [
      Stat(
        value: 1,
        effort: 1,
        name: 'statName',
      ),
    ],
    weight: 1,
    height: 1,
  );

  group('PokemonImagesPage', () {
    Widget buildSubject() {
      return const PokemonImagesPage(pokemon: pokemon);
    }

    group('route', () {
      testWidgets('renders PokemonImagesPage', (tester) async {
        await tester.pumpRoute(
          PokemonImagesPage.route(
            pokemon: pokemon,
          ),
        );
        expect(find.byType(PokemonImagesPage), findsOneWidget);
      });

      testWidgets('supports providing a pokemon', (tester) async {
        await tester.pumpRoute(
          PokemonImagesPage.route(
            pokemon: pokemon,
          ),
        );

        final page = tester.widget<PokemonImagesPage>(
          find.byType(PokemonImagesPage),
        );

        expect(page.pokemon, pokemon);
      });
    });

    testWidgets('renders PokemonImagesAppBar', (tester) async {
      await tester.pumpApp(buildSubject());

      expect(find.byType(PokemonImagesAppBar), findsOneWidget);
    });

    testWidgets('renders ImagesSlider', (tester) async {
      await tester.pumpApp(buildSubject());

      expect(find.byType(ImagesSlider), findsOneWidget);
    });
  });
}
