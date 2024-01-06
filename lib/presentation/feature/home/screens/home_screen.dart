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
          appBar: const AppAppBar(name: 'Финансы'),
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: tabsRouter.activeIndex,
            onTap: (index) {
              tabsRouter.setActiveIndex(index);
            },
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

List<Widget> _actions() {
  return [
    Stack(
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.downloading),
        ),
        Positioned(
          left: 25,
          top: 5,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            height: 18,
            width: 18,
            child: const Text(
              '9',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    ),
  ];
}
