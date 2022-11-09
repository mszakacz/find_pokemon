import 'package:flutter/material.dart';
import 'package:pokemon/theme/theme.dart';

class Snackbar {
  const Snackbar();

  void errorSnackbar({
    required BuildContext context,
    required String content,
  }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: AppColors.red,
          content: Text(
            content,
            style: Theme.of(context).textTheme.headline5?.copyWith(
                  color: AppColors.black,
                ),
          ),
        ),
      );
  }
}
