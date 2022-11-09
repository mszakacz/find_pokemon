import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/l10n/l10n.dart';
import 'package:pokemon/searching/searching.dart';
import 'package:pokemon/theme/theme.dart';

class SearchingInput extends StatelessWidget {
  const SearchingInput({super.key});

  static const _inputBorderRadius = 10.0;
  static const _sideMargin = 5.0;

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    final l10n = context.l10n;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: _sideMargin,
      ),
      child: TextField(
        controller: controller,
        onChanged: (input) {
          context.read<SearchingBloc>().add(
                FetchPokemons(
                  phrase: input.toLowerCase(),
                ),
              );
        },
        style: Theme.of(context).textTheme.headline3,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.dark,
          contentPadding: const EdgeInsets.all(15),
          prefixIcon: const IconButton(
            icon: Icon(
              Icons.search,
              color: AppColors.white,
            ),
            onPressed: null,
          ),
          suffixIcon: IconButton(
            icon: const Icon(
              Icons.clear,
              color: AppColors.white,
            ),
            onPressed: () {
              controller.clear();
              context.read<SearchingBloc>().add(
                    const FetchPokemons(
                      phrase: '',
                    ),
                  );
            },
          ),
          hintText: l10n.typePokemonName,
          hintStyle: Theme.of(context).textTheme.headline4?.copyWith(
                fontStyle: FontStyle.italic,
              ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(_inputBorderRadius),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(_inputBorderRadius),
          ),
        ),
      ),
    );
  }
}
