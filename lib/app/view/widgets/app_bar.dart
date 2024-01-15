import 'package:auto_route/auto_route.dart';
import 'package:finplan24/app/app.dart';
import 'package:flutter/material.dart';

class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AppAppBar({
    required this.name,
    super.key,
    this.withSettings = false,
    this.withArrowBack = false,
    this.withAccount = false,
  });

  final String name;
  final bool withSettings;
  final bool withArrowBack;
  final bool withAccount;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Visibility(
        visible: withArrowBack,
        child: IconButton(
          onPressed: () {
            context.popRoute();
          },
          icon: AppIcons.arrowBack,
        ),
      ),
      centerTitle: true,
      title: Text(name),
      actions: [
        Visibility(
          visible: withAccount,
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.person,
              color: AppColors.orange,
            ),
          ),
        ),
        Visibility(
          visible: withSettings,
          child: IconButton(
            onPressed: () {
              context.pushRoute(const SettingsRoute());
            },
            icon: AppIcons.settings,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
