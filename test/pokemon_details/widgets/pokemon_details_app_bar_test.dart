import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:pokemon/pokemon_details/pokemon_details.dart';
import 'package:pokemons_repository/pokemons_repository.dart';

import '../../helpers/helpers.dart';

class MockPokemonsRepository extends Mock implements PokemonsRepository {}

class MockPokemonDetailsBloc
    extends MockBloc<PokemonDetailsEvent, PokemonDetailsState>
    implements PokemonDetailsBloc {}

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

  late PokemonsRepository pokemonsRepository;

  late PokemonDetailsBloc pokemonDetailsBloc;

  setUpAll(() {
    pokemonsRepository = MockPokemonsRepository();

    pokemonDetailsBloc = MockPokemonDetailsBloc();

    when(
      () => pokemonsRepository.addPokemonToFavorites(
        pokemonName: pokemon.name,
      ),
    ).thenAnswer((_) async {});

    when(
      () => pokemonsRepository.removePokemonFromFavorites(
        pokemonName: pokemon.name,
      ),
    ).thenAnswer((_) async {});

    when(() => pokemonDetailsBloc.state).thenReturn(
      const PokemonDetailsState(
        status: PokemonDetailsStatus.display,
        pokemon: pokemon,
        isFavorite: true,
      ),
    );
  });

  group('PokemonDetailsAppBar', () {
    Widget buildSubject() {
      return BlocProvider.value(
        value: pokemonDetailsBloc,
        child: const PokemonDetailsAppBar(),
      );
    }

    testWidgets('renders FavoriteIcon', (tester) async {
      await tester.pumpApp(buildSubject());

      expect(find.byType(FavoriteIcon), findsOneWidget);
    });
  });

  group('FavoriteIcon', () {
    Widget buildSubject() {
      return BlocProvider.value(
        value: pokemonDetailsBloc,
        child: const FavoriteIcon(),
      );
    }

    testWidgets(
        'calls AddToFavorite '
        'with false '
        'when state isFavorite is true', (tester) async {
      when(() => pokemonDetailsBloc.state).thenReturn(
        const PokemonDetailsState(
          status: PokemonDetailsStatus.display,
          pokemon: pokemon,
          isFavorite: true,
        ),
      );

      await tester.pumpApp(buildSubject());

      expect(find.byType(IconButton), findsOneWidget);

      final iconButton = tester.widget<IconButton>(
        find.byType(IconButton),
      );

      iconButton.onPressed!();

      verify(
        () => pokemonDetailsBloc.add(const AddToFavorite(isFavorite: false)),
      ).called(1);
    });

    testWidgets(
        'calls AddToFavorite '
        'with true '
        'when state isFavorite is false', (tester) async {
      when(() => pokemonDetailsBloc.state).thenReturn(
        const PokemonDetailsState(
          status: PokemonDetailsStatus.display,
          pokemon: pokemon,
          isFavorite: false,
        ),
      );

      await tester.pumpApp(buildSubject());

      expect(find.byType(IconButton), findsOneWidget);

      final iconButton = tester.widget<IconButton>(
        find.byType(IconButton),
      );

      iconButton.onPressed!();

      verify(
        () => pokemonDetailsBloc.add(const AddToFavorite(isFavorite: true)),
      ).called(1);
    });

    testWidgets(
        'renders PokemonLikedIcon '
        'when state isFavorite is true', (tester) async {
      when(() => pokemonDetailsBloc.state).thenReturn(
        const PokemonDetailsState(
          status: PokemonDetailsStatus.display,
          pokemon: pokemon,
          isFavorite: true,
        ),
      );

      await tester.pumpApp(buildSubject());

      expect(find.byType(PokemonLikedIcon), findsOneWidget);
    });

    testWidgets(
        'renders PokemonNotLikedIcon '
        'when state isFavorite is false', (tester) async {
      when(() => pokemonDetailsBloc.state).thenReturn(
        const PokemonDetailsState(
          status: PokemonDetailsStatus.display,
          pokemon: pokemon,
          isFavorite: false,
        ),
      );

      await tester.pumpApp(buildSubject());

      expect(find.byType(PokemonNotLikedIcon), findsOneWidget);
    });
  });
}
