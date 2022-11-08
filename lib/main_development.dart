import 'package:api_client/api_client.dart';
import 'package:pokemon/app/app.dart';
import 'package:pokemon/bootstrap.dart';

Future<void> main() async {
  final apiClient = ApiClient();

  final pokemonName = await apiClient.searchPokemons(phrase: 'ditto');
  print('pokemon name: ${pokemonName}');

  await bootstrap(
    () => const App(),
  );
}
