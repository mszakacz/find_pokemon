import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon/pokemon_images/pokemon_images.dart';
import 'package:pokemon/utils/utils.dart';
import '../../helpers/helpers.dart';

void main() {
  const pokemonName = 'name';

  group('PokemonImagesAppBar', () {
    Widget buildSubject() {
      return const PokemonImagesAppBar(pokemonName: pokemonName);
    }

    testWidgets('renders AppBar with correct title', (tester) async {
      await tester.pumpApp(buildSubject());

      expect(find.byType(AppBar), findsOneWidget);

      expect(find.byType(Text), findsOneWidget);

      final title = tester.widget<Text>(find.byType(Text)).data;

      expect(title, pokemonName.asPokemonName());
    });
  });
}
