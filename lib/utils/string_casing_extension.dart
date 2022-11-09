extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String asPokemonName() {
    var name = this;
    if (name.contains('-')) {
      name = name.replaceFirst('-', ' (');
      name = '$name)';
      name = name.replaceAll('-', ' ');
    }
    return name.toCapitalized();
  }
}
