import 'package:api_client/api_client.dart';
import 'package:pokemon/app/app.dart';
import 'package:pokemon/bootstrap.dart';

Future<void> main() async {
  final apiClient = ApiClient();

  await bootstrap(
    () => const App(),
  );
}
