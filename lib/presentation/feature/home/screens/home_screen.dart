import 'package:auto_route/auto_route.dart';
import 'package:finplan24/app/app.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [
        OperationRoute(),
        PlanRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          appBar: const AppAppBar(
            name: 'Финансы',
            withSettings: true,
            withAccount: true,
          ),
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: tabsRouter.activeIndex,
            onTap: tabsRouter.setActiveIndex,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.menu, size: 0),
                label: "Операции",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.menu, size: 0),
                label: "План",
              ),
            ],
          ),
        );
      },
    );
  }
}
