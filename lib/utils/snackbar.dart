import 'package:flutter/material.dart';
import 'package:pokemon/l10n/l10n.dart';
import 'package:pokemon/theme/theme.dart';

class Snackbar {
  const Snackbar();

  void errorSnackbar({
    required BuildContext context,
    String? content,
  }) {
    final l10n = context.l10n;

    final text = content ?? l10n.sthWentWrong;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: AppColors.red,
          content: Text(
            text,
            style: Theme.of(context).textTheme.headline5?.copyWith(
                  color: AppColors.black,
                ),
          ),
        ),
      );
  }
}
