import 'package:flutter/material.dart';
import 'package:pokemon/l10n/l10n.dart';
import 'package:pokemon/theme/theme.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.wifi_off,
            color: AppColors.white,
            size: 30,
          ),
          const SizedBox(height: 20),
          Text(
            l10n.sthWentWrong,
            style: Theme.of(context).textTheme.headline4,
          ),
          Text(
            l10n.checkInternetConnection,
            style: Theme.of(context).textTheme.headline4,
          ),
        ],
      ),
    );
  }
}
