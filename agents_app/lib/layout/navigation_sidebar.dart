import 'package:agents_app/shared/constants/routes.dart';
import 'package:agents_app/shared/utils/route_selector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/menu_provider.dart';
import '../providers/sidebar_state_provider.dart';

class NavigationSidebar extends StatelessWidget {
  final String userRole;
  final String? currentRoute;

  const NavigationSidebar({
    Key? key,
    required this.userRole,
    this.currentRoute,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final menu = context.watch<MenuProvider>().menu;
    final sidebarState = context.watch<SidebarStateProvider>();
    final colorScheme = Theme.of(context).colorScheme;

    if (menu.isEmpty) {
      // Cargar menú si aún no está cargado
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final provider = Provider.of<MenuProvider>(context, listen: false);
        provider.loadMenu(userRole);
      });
    }

    return Container(
      width: 250,
      color: colorScheme.surfaceVariant.withOpacity(0.2),
      child: menu.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(color: colorScheme.primary),
                  child: Text(
                    "Menú",
                    style: TextStyle(
                      color: colorScheme.onPrimary,
                      fontSize: 24,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.dashboard,
                      color: colorScheme
                          .primary //currentRoute == item.route ? colorScheme.primary : null,
                      ),
                  title: const Text("Dashboard"),
                  selected: currentRoute == RouteConstants.dashboard,
                  selectedTileColor: colorScheme.primary.withOpacity(0.1),
                  onTap: () {
                    context.read<SidebarStateProvider>().setExpandedGroup(null);

                    if (currentRoute != null) {
                      Navigator.of(context).pushReplacement(
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) =>
                              getPageForRoute(RouteConstants.dashboard),
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                        ),
                      );
                    }
                  },
                ),
                for (var group in menu)
                  ExpansionTile(
                    initiallyExpanded:
                        sidebarState.expandedGroup == group.label,
                    onExpansionChanged: (expanded) {
                      context
                          .read<SidebarStateProvider>()
                          .setExpandedGroup(expanded ? group.label : null);
                    },
                    title: Text(
                      group.label,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    children: [
                      for (var item in group.children)
                        ListTile(
                          leading: Icon(
                            item.icon,
                            color: currentRoute == item.route
                                ? colorScheme.primary
                                : null,
                          ),
                          title: Text(item.label),
                          selected: currentRoute == item.route,
                          selectedTileColor:
                              colorScheme.primary.withOpacity(0.1),
                          onTap: () {
                            if (currentRoute != item.route) {
                              Navigator.of(context).pushReplacement(
                                PageRouteBuilder(
                                  pageBuilder: (_, __, ___) =>
                                      getPageForRoute(item.route),
                                  transitionDuration: Duration.zero,
                                  reverseTransitionDuration: Duration.zero,
                                ),
                              );
                            }
                          },
                        ),
                    ],
                  ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text("Cerrar sesión"),
                  onTap: () {
                    // lógica logout
                  },
                ),
              ],
            ),
    );
  }
}
