import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:pokemon/pokemon_details/pokemon_details.dart';
import 'package:pokemon/widgets/widgets.dart';
import 'package:pokemons_repository/pokemons_repository.dart';

import '../../helpers/helpers.dart';

class MockPokemonsRepository extends Mock implements PokemonsRepository {}

class MockPokemonDetailsBloc
    extends MockBloc<PokemonDetailsEvent, PokemonDetailsState>
    implements PokemonDetailsBloc {}

void main() {
  const pokemonName = 'pokemonName';

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
  late MockNavigator navigator;
  late PokemonDetailsBloc pokemonDetailsBloc;

  setUp(() {
    pokemonsRepository = MockPokemonsRepository();
    when(
      () => pokemonsRepository.getPokemon(name: any<String>(named: 'name')),
    ).thenAnswer((_) async => pokemon);

    navigator = MockNavigator();
    pokemonDetailsBloc = MockPokemonDetailsBloc();
  });

  group('PokemonDetailsPage', () {
    Widget buildSubject() {
      return const PokemonDetailsPage(pokemonName: pokemonName);
    }

    group('route', () {
      testWidgets('renders PokemonDetailsPage', (tester) async {
        await tester.pumpRoute(
          PokemonDetailsPage.route(
            pokemonName: pokemonName,
          ),
        );
        expect(find.byType(PokemonDetailsPage), findsOneWidget);
      });

      testWidgets('supports providing a pokemon name', (tester) async {
        await tester.pumpRoute(
          PokemonDetailsPage.route(
            pokemonName: pokemonName,
          ),
        );

        final page = tester.widget<PokemonDetailsPage>(
          find.byType(PokemonDetailsPage),
        );

        expect(page.pokemonName, pokemonName);
      });
    });

    testWidgets(
      'fetch pokemon from repository on initialization',
      (tester) async {
        await tester.pumpApp(
          buildSubject(),
          pokemonsRepository: pokemonsRepository,
        );

        verify(() => pokemonsRepository.getPokemon(name: pokemonName))
            .called(1);
      },
    );

    testWidgets(
      'renders PokemonDetailsAppBar',
      (tester) async {
        await tester.pumpApp(buildSubject());

        expect(find.byType(PokemonDetailsAppBar), findsOneWidget);
      },
    );

    testWidgets(
      'renders PokemonDetailsView',
      (tester) async {
        await tester.pumpApp(buildSubject());

        expect(find.byType(PokemonDetailsView), findsOneWidget);
      },
    );
  });

  group('PokemonDetailsView', () {
    Widget buildSubject() {
      return MockNavigatorProvider(
        navigator: navigator,
        child: BlocProvider.value(
          value: pokemonDetailsBloc,
          child: const PokemonDetailsView(),
        ),
      );
    }

    testWidgets('renders Loading when status is loading', (tester) async {
      when(() => pokemonDetailsBloc.state).thenReturn(
        const PokemonDetailsState(
          pokemon: Pokemon.empty,
          status: PokemonDetailsStatus.loading,
          isFavorite: false,
        ),
      );
      await tester.pumpApp(buildSubject());

      expect(find.byType(Loading), findsOneWidget);
    });

    testWidgets('renders ErrorView when status is error', (tester) async {
      when(() => pokemonDetailsBloc.state).thenReturn(
        const PokemonDetailsState(
          pokemon: Pokemon.empty,
          status: PokemonDetailsStatus.error,
          isFavorite: false,
        ),
      );
      await tester.pumpApp(buildSubject());

      expect(find.byType(ErrorView), findsOneWidget);
    });

    testWidgets('renders PokemonCard when status is display', (tester) async {
      when(() => pokemonDetailsBloc.state).thenReturn(
        const PokemonDetailsState(
          pokemon: pokemon,
          status: PokemonDetailsStatus.display,
          isFavorite: false,
        ),
      );
      await tester.pumpApp(buildSubject());

      expect(find.byType(PokemonCard), findsOneWidget);
    });

    testWidgets(
        'renders PokemonCard '
        'with proper pokemon', (tester) async {
      when(() => pokemonDetailsBloc.state).thenReturn(
        const PokemonDetailsState(
          pokemon: pokemon,
          status: PokemonDetailsStatus.display,
          isFavorite: false,
        ),
      );
      await tester.pumpApp(buildSubject());

      final pokemonCard = tester.widget<PokemonCard>(
        find.byType(PokemonCard),
      );

      expect(pokemonCard.pokemon, pokemon);
    });
  });
}
