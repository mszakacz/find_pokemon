import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/l10n/l10n.dart';

import 'package:pokemon/menu/menu.dart';
import 'package:pokemon/theme/theme.dart';

class MenuView extends StatelessWidget {
  const MenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MenuBloc(),
      child: const _Menu(),
    );
  }
}

class _Menu extends StatelessWidget {
  const _Menu();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<MenuBloc, MenuState>(
      builder: (context, state) {
        final selected = state.selectedIndex;
        return Scaffold(
          body: _MenuBody(
            menuIndex: selected,
          ),
          bottomNavigationBar: SizedBox(
            height: 110,
            child: BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: const _BottomIcon(
                    icon: Icons.search_outlined,
                  ),
                  label: l10n.searching,
                ),
                BottomNavigationBarItem(
                  icon: const _BottomIcon(
                    icon: Icons.favorite_outline,
                  ),
                  label: l10n.favorites,
                ),
              ],
              currentIndex: selected,
              selectedItemColor: AppColors.aqua,
              unselectedItemColor: AppColors.white,
              onTap: (index) {
                context.read<MenuBloc>().add(
                      ChangeMenuIndex(
                        index: index,
                      ),
                    );
              },
            ),
          ),
        );
      },
    );
  }
}

class _BottomIcon extends StatelessWidget {
  const _BottomIcon({
    required this.icon,
  });

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: Icon(
        icon,
      ),
    );
  }
}

class _MenuBody extends StatelessWidget {
  const _MenuBody({
    required this.menuIndex,
  });

  final int menuIndex;

  @override
  Widget build(BuildContext context) {
    switch (menuIndex) {
      case 0:
        return const Center(
          child: Text('Searching'),
        );

      case 1:
        return const Center(
          child: Text('Favorites'),
        );

      default:
        return const Center(
          child: Text('Favorites'),
        );
    }
  }
}
