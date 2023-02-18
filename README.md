# Find Pokemon

Mobile app created with Flutter.



<img height="500" alt="Screenshot 2022-11-10 at 00 42 39" src="https://user-images.githubusercontent.com/38291070/200965878-065d1838-5675-4a7d-a5d9-debb6db3c7f3.png">     &nbsp;&nbsp;&nbsp;&nbsp;    <img height="500" alt="Screenshot 2022-11-10 at 02 19 24" src="https://user-images.githubusercontent.com/38291070/200976957-3c6a23fe-f1b0-4d9e-adf4-aacaa3c27317.png">

&nbsp;&nbsp;&nbsp;&nbsp;  
<img height="500" alt="Screenshot 2022-11-10 at 00 43 34" src="https://user-images.githubusercontent.com/38291070/200965869-d1dbf54f-6880-46bb-89dc-c36dc81f3978.png">    &nbsp;&nbsp;&nbsp;&nbsp;     <img height="500" alt="Screenshot 2022-11-10 at 09 13 16" src="https://user-images.githubusercontent.com/38291070/201038100-47e2957e-db8c-44bd-b1c4-7da00ef037f9.png">






Web App is available at [this link](https://find-pokemon-72d09.web.app)

### Functionalities:
- pokemons searching
- displaying pokemon pictures, statistics and other details
- adding pokemon to favorites
- sorting list of favorites (by dragging)

### Tools / packages:
- Flutter
- pokeapi.co
- BLoC
- Very good CLI
- l10n (translations)
- Serialization (json_annotation)
- Http
- REST API
- App Splash screen
- App Launcher Icon
- Saving data in device memory
- Debounce when searching
- Cached image
- Unit tests
- widget tests


### Development info:
App supports very good standards of writing code. Project is divided into 3 layers:
- Data Layer (Pokemons API CLient)
- Domain Layer (Pokemons Repository)
- Presentations Layer (widgets + BLoC)

Presentation Layer is divider into features folders like:
- Searching
- PokemonDetails
- Favorites
- PokemonImages

Feature folder contains:
- BLoC (state management)
- View (e.g: SearchingPage)
- Widgets (widgets that are used in this feature)

There are also some general widgets that are used in many features. These are located in lib/widgets.

I provided all needed tests: PokemonsApiCLient, api models, PokemonsRepository, repository models, unit tests of the functions, BLoC tests, widget tests.



<img width="652" alt="Screenshot 2022-11-11 at 17 41 58" src="https://user-images.githubusercontent.com/38291070/201388271-58cb57dd-150a-43e2-a44d-2a6cbc98f5cc.png">






