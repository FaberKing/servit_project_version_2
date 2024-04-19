import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:go_router/go_router.dart';

enum ScaffoldTab {
  home,
  favorite,
  notifikasi,
  profile,
}

class NavigationScaffold extends StatefulWidget {
  final ScaffoldTab selectedTab;
  final Widget child;
  const NavigationScaffold({
    super.key,
    required this.selectedTab,
    required this.child,
  });

  @override
  State<NavigationScaffold> createState() => _NavigationScaffoldState();
}

class _NavigationScaffoldState extends State<NavigationScaffold> {
  @override
  Widget build(BuildContext context) {
    TextDirection directionalityOverride = TextDirection.ltr;

    List<NavigationDestination> navigationDestinationItems = <NavigationDestination>[
      // NavigationDestination(
      //   icon: Icon(Icons.home_outlined),
      //   label: 'Home',
      //   selectedIcon: Icon(Icons.home),
      // ),
      // NavigationDestination(
      //   icon: Icon(Icons.favorite_outline),
      //   label: 'Favorite',
      //   selectedIcon: Icon(Icons.favorite),
      // ),
      // NavigationDestination(
      //   icon: Icon(Icons.notifications_outlined),
      //   label: 'Pesanan',
      //   selectedIcon: Icon(Icons.notifications),
      // ),
      // NavigationDestination(
      //   icon: Icon(Icons.person_outline_rounded),
      //   label: 'Profile',
      //   selectedIcon: Icon(Icons.person_rounded),
      // ),
    ];

    return Directionality(
      textDirection: directionalityOverride,
      child: Scaffold(
        body: AdaptiveLayout(
          body: SlotLayout(
            config: <Breakpoint, SlotLayoutConfig?>{
              Breakpoints.standard: SlotLayout.from(
                key: const Key('body'),
                builder: (_) => widget.child,
              ),
            },
          ),
          bottomNavigation: SlotLayout(
            config: <Breakpoint, SlotLayoutConfig?>{
              Breakpoints.small: SlotLayout.from(
                key: const Key('bottomNavigation'),
                builder: (_) => AdaptiveScaffold.standardBottomNavigationBar(
                  iconSize: 26,
                  onDestinationSelected: (int index) {
                    switch (ScaffoldTab.values[index]) {
                      case ScaffoldTab.home:
                        context.go('/home');
                      case ScaffoldTab.favorite:
                        context.go('/favorite');
                      case ScaffoldTab.notifikasi:
                        context.go('/notifikasi');
                      case ScaffoldTab.profile:
                        context.go('/profile');
                    }
                  },
                  currentIndex: widget.selectedTab.index,
                  destinations: const [
                    NavigationDestination(
                      icon: Icon(Icons.home_outlined),
                      label: 'Home',
                      selectedIcon: Icon(Icons.home),
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.favorite_outline),
                      label: 'Favorite',
                      selectedIcon: Icon(Icons.favorite),
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.notifications_outlined),
                      label: 'Aktivitas',
                      selectedIcon: Icon(Icons.notifications),
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.person_outline_rounded),
                      label: 'Profile',
                      selectedIcon: Icon(Icons.person_rounded),
                    ),
                  ],
                ),
              ),
            },
          ),
        ),
      ),
    );
  }
}
