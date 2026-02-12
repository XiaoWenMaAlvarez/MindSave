import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mindsave/auth/presentation/providers/auth_provider.dart';
import 'package:mindsave/config/menu/menu_items.dart';
import 'package:mindsave/home/presentation/providers/providers.dart';

class SideMenu extends ConsumerStatefulWidget {

  final GlobalKey<ScaffoldState> scaffoldKey;

  const SideMenu({
    super.key,
    required this.scaffoldKey
  });

  @override
  SideMenuState createState() => SideMenuState();
}

class SideMenuState extends ConsumerState<SideMenu> {

  int navDrawerIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(themeProvider).isDarkMode;
    navDrawerIndex = ref.watch(selectedMenuItemProvider);

    final paddingTop = MediaQuery.of(context).viewPadding.top;
    final hasNotch = paddingTop > 35;

    return NavigationDrawer(
      selectedIndex: navDrawerIndex,
      onDestinationSelected: (value) {
        final selectedItem = appMenuItems[value];
        widget.scaffoldKey.currentState?.closeEndDrawer();
        ref.read(selectedMenuItemProvider.notifier).state = value;
        context.go(selectedItem.link);
      },
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(28, hasNotch ? 0 : 0, 16, 10)
        ),

        const Padding(
          padding: EdgeInsets.fromLTRB(28, 10, 16, 10),
          child: Text("Herramientas")
        ),

        ...appMenuItems.map((item) {
          return NavigationDrawerDestination(
            icon: Icon(item.icon), 
            label: Text(item.title)
          );
        }),

        const Padding(
          padding: EdgeInsets.fromLTRB(28, 10, 16, 10),
          child: Divider(),
        ),

        const Padding(
          padding: EdgeInsets.fromLTRB(28, 10, 16, 10),
          child: Text("Configuración")
        ),

        SwitchListTile(
          title: Row(
            children: [
              Icon(isDarkMode ? Icons.dark_mode_outlined : Icons.light_mode_outlined),
              SizedBox(width: 5),
              Text("Modo oscuro")
            ],
          ),
          value: isDarkMode,
          onChanged: (value) {
            ref.read(themeProvider.notifier).toggleDarkMode();
          },
        ),
        ListTile(
          leading: Icon(Icons.logout_outlined),
          title: Text("Cerrar sesión"),
          onTap: ref.read(authProvider.notifier).logout,
          horizontalTitleGap: 5,
        )
      ],
    );
  }
}