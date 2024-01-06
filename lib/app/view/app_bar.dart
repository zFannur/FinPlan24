import 'package:auto_route/auto_route.dart';
import 'package:finplan24/app/app.dart';
import 'package:flutter/material.dart';

class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String name;
  final bool? withSettings;

  const AppAppBar({
    super.key,
    required this.name, this.withSettings,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          context.popRoute();
        },
        icon: AppIcons.arrowBack,
      ),
      centerTitle: true,
      title: Text(name),
      actions: (withSettings ?? true) ? [
        IconButton(
          onPressed: () {
            // context.pushRoute(const SettingsRoute());
          },
          icon: AppIcons.settings,
        )
      ] : [],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
