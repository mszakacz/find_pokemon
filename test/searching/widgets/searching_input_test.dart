import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:pokemon/searching/searching.dart';
import 'package:pokemons_repository/pokemons_repository.dart';

import '../../helpers/helpers.dart';

class MockPokemonsRepository extends Mock implements PokemonsRepository {}

class MockSearchingBloc extends MockBloc<SearchingEvent, SearchingState>
    implements SearchingBloc {}

void main() {
  const phrase = 'name';

  late SearchingBloc searchingBloc;

  setUp(() {
    searchingBloc = MockSearchingBloc();
  });

  group('SearchingInput', () {
    Widget buildSubject() {
      return BlocProvider.value(
        value: searchingBloc,
        child: const SearchingInput(),
      );
    }

    testWidgets('renders TextField', (tester) async {
      await tester.pumpApp(buildSubject());

      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('calls FetchPokemons onChanged', (tester) async {
      await tester.pumpApp(buildSubject());

      final textField = tester.widget<TextField>(
        find.byType(TextField),
      );

      textField.onChanged!(phrase);

      verify(
        () => searchingBloc.add(
          FetchPokemons(
            phrase: phrase.toLowerCase(),
          ),
        ),
      ).called(1);
    });

    testWidgets('calls FetchPokemons with empty string on clear icon tap',
        (tester) async {
      await tester.pumpApp(buildSubject());

      await tester.tap(find.byIcon(Icons.clear));

      verify(
        () => searchingBloc.add(
          const FetchPokemons(
            phrase: '',
          ),
        ),
      ).called(1);
    });
  });
}
