import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/l10n/l10n.dart';
import 'package:pokemon/searching/searching.dart';
import 'package:pokemon/utils/utils.dart';
import 'package:pokemon/widgets/widgets.dart';

class SearchingBody extends StatelessWidget {
  const SearchingBody({super.key});

  @override
  Widget build(BuildContext context) {
    const snackbar = Snackbar();
    final l10n = context.l10n;

    return BlocConsumer<SearchingBloc, SearchingState>(
      listenWhen: (previous, current) => previous != current,
      listener: (context, state) {
        if (state.status == SearchingStatus.error) {
          snackbar.errorSnackbar(
            context: context,
            content: l10n.fetchingPokemonsFailed,
          );
        }
      },
      builder: (context, state) {
        switch (state.status) {
          case SearchingStatus.loading:
            return const Loading();

          case SearchingStatus.error:
            return const ErrorView();

          case SearchingStatus.display:
            return SearchingList(
              pokemons: state.results,
            );
        }
      },
    );
  }
}
