import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:pokemon/pokemon_details/pokemon_details.dart';
import 'package:pokemon/widgets/widgets.dart';
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

  late MockNavigator navigator;

  setUpAll(() {
    navigator = MockNavigator();
  });

  group('PokemonCard', () {
    Widget buildSubject() {
      return const PokemonCard(
        pokemon: pokemon,
      );
    }

    testWidgets('renders Avatar with proper pokemon', (tester) async {
      await tester.pumpApp(buildSubject());

      expect(find.byType(Avatar), findsOneWidget);

      final avatar = tester.widget<Avatar>(
        find.byType(Avatar),
      );

      expect(avatar.pokemon, pokemon);
    });
  });

  group('Avatar', () {
    Widget buildSubject() {
      return MockNavigatorProvider(
        navigator: navigator,
        child: const Avatar(
          pokemon: pokemon,
        ),
      );
    }

    testWidgets('renders CachedImg with proper pictureUrl', (tester) async {
      await tester.pumpApp(buildSubject());

      expect(find.byType(CachedImg), findsOneWidget);

      final cachedImg = tester.widget<CachedImg>(
        find.byType(CachedImg),
      );

      expect(cachedImg.pictureUrl, pokemon.pictures.first);
    });

    testWidgets('navigates to PokemonImagesPage onTap', (tester) async {
      when(() => navigator.push<void>(any())).thenAnswer((_) async {});

      await tester.pumpApp(buildSubject());

      expect(find.byType(GestureDetector), findsOneWidget);

      final gestureDetector = tester.widget<GestureDetector>(
        find.byType(GestureDetector),
      );

      gestureDetector.onTap!();

      verify(
        () => navigator.push<void>(any(that: isRoute<void>())),
      ).called(1);
    });
  });
}
