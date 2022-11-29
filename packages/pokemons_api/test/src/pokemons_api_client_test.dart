import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:pokemons_api/pokemons_api.dart';
import 'package:test/test.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  group('PokemonsApiClient', () {
    const pokemonName = 'pokemonName';

    const id = 1;
    const name = 'name';
    const weight = 1;
    const height = 1;

    const sprites = SpritesData(
      backDefault: 'backDefault.url',
      backFemale: 'backFemale.url',
      backShiny: 'backShiny.url',
      backShinyFemale: 'backShinyFemale.url',
      frontDefault: 'frontDefault.url',
      frontFemale: 'frontFemale.url',
      frontShiny: 'frontShiny.url',
      frontShinyFemale: 'frontShinyFemale.url',
    );

    final spritesJson = jsonEncode(
      <String, dynamic>{
        'back_default': 'backDefault.url',
        'back_female': 'backFemale.url',
        'back_shiny': 'backShiny.url',
        'back_shiny_female': 'backShinyFemale.url',
        'front_default': 'frontDefault.url',
        'front_female': 'frontFemale.url',
        'front_shiny': 'frontShiny.url',
        'front_shiny_female': 'frontShinyFemale.url',
      },
    );

    const stats = [
      PokemonStatData(
        value: 1,
        effort: 1,
        stat: StatData(
          name: 'statName',
          url: 'stat.url',
        ),
      ),
    ];

    final statsJson = jsonEncode(
      [
        <String, dynamic>{
          'base_stat': 1,
          'effort': 1,
          'stat': <String, dynamic>{
            'name': 'statName',
            'url': 'stat.url',
          },
        },
      ],
    );

    late MockHttpClient mockHttpClient;
    late PokemonsApiClient apiClient;

    setUpAll(() {
      registerFallbackValue(FakeUri());
    });

    setUp(() {
      mockHttpClient = MockHttpClient();
      apiClient = PokemonsApiClient(httpClient: mockHttpClient);
    });

    group('constructor', () {
      test('does not require an httpClient', () {
        expect(PokemonsApiClient(), isNotNull);
      });
    });

    group('getPokemon', () {
      test('makes correct https request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => mockHttpClient.get(any())).thenAnswer((_) async => response);
        try {
          await apiClient.getPokemon(
            pokemonName: pokemonName,
          );
        } catch (_) {}
        verify(
          () => mockHttpClient.get(
            Uri.https(
              'pokeapi.co',
              '/api/v2/pokemon/$pokemonName',
            ),
          ),
        ).called(1);
      });

      test(
        'throws GetPokemonRequestFailure on non-200 response',
        () async {
          final response = MockResponse();

          when(() => response.statusCode).thenReturn(400);
          when(() => mockHttpClient.get(any()))
              .thenAnswer((_) async => response);
          expect(
            () async => apiClient.getPokemon(pokemonName: pokemonName),
            throwsA(isA<GetPokemonRequestFailure>()),
          );
        },
      );

      test(
        'throws PokemonDeserializationFailure',
        () async {
          final response = MockResponse();
          when(() => response.statusCode).thenReturn(200);
          when(() => response.body).thenReturn(
            '''
          {
            'name': $name,
          }
        ''',
          ); // some properties are missing

          when(() => mockHttpClient.get(any()))
              .thenAnswer((_) async => response);

          final actual = apiClient.getPokemon(
            pokemonName: name,
          );
          expect(
            actual,
            throwsA(
              isA<PokemonDeserializationFailure>(),
            ),
          );
        },
      );

      test('returns pokemon on valid response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);

        when(() => response.body).thenReturn(
          '''
            {
              "id":$id,
              "name": "$name",
              "sprites": $spritesJson,
              "stats": $statsJson,
              "weight": $weight,
              "height": $height
            }
        ''',
        );
        when(
          () => mockHttpClient.get(any()),
        ).thenAnswer((_) async => response);

        final actual = await apiClient.getPokemon(
          pokemonName: name,
        );

        expect(
          actual,
          const PokemonData(
            id: id,
            name: name,
            sprites: sprites,
            stats: stats,
            weight: weight,
            height: height,
          ),
        );
      });
    });

    group('searchPokemons', () {
      const phrase = 'dit';
      const queryParameters = {
        'limit': '100000',
        'offset': '0',
      };
      test('makes correct https request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => mockHttpClient.get(any())).thenAnswer((_) async => response);
        try {
          await apiClient.searchPokemons(
            phrase: phrase,
          );
        } catch (_) {}
        verify(
          () => mockHttpClient.get(
            Uri.https(
              'pokeapi.co',
              '/api/v2/pokemon',
              queryParameters,
            ),
          ),
        ).called(1);
      });

      test(
        'throws SearchPokemonsRequestFailure on non-200 response',
        () async {
          final response = MockResponse();

          when(() => response.statusCode).thenReturn(400);
          when(() => mockHttpClient.get(any()))
              .thenAnswer((_) async => response);
          expect(
            () async => apiClient.searchPokemons(phrase: phrase),
            throwsA(isA<SearchPokemonsRequestFailure>()),
          );
        },
      );

      test(
        'throws PokemonSearchingResultDeserializationFailure',
        () async {
          final response = MockResponse();
          when(() => response.statusCode).thenReturn(200);
          when(() => response.body).thenReturn(
            '''
          {
            'name': $name,
          }
        ''',
          ); // some properties are missing

          when(() => mockHttpClient.get(any()))
              .thenAnswer((_) async => response);

          final actual = apiClient.searchPokemons(
            phrase: phrase,
          );
          expect(
            actual,
            throwsA(
              isA<PokemonSearchingResultDeserializationFailure>(),
            ),
          );
        },
      );

      test('returns names of pokemons on valid response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);

        when(() => response.body).thenReturn(
          '''
          {
            "results": [
              {
                "name":"$name",
                "url":"url"
              }
            ]
          }
        ''',
        );
        when(
          () => mockHttpClient.get(any()),
        ).thenAnswer((_) async => response);

        final actual = await apiClient.searchPokemons(
          phrase: name,
        );

        expect(
          actual,
          const <String>[
            name,
          ],
        );
      });
    });
  });
}
