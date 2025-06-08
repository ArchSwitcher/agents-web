import 'package:agents_app/shared/utils/route_selector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/menu_provider.dart';

class NavigationSidebar extends StatefulWidget {
  final String userRole;
  final String? currentRoute;

  const NavigationSidebar({
    Key? key,
    required this.userRole,
    this.currentRoute,
  }) : super(key: key);

  @override
  State<NavigationSidebar> createState() => _NavigationSidebarState();
}

class _NavigationSidebarState extends State<NavigationSidebar> {
  String? _expandedParent;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<MenuProvider>(context, listen: false);
      provider.loadMenu(widget.userRole);
    });
  }

  @override
  Widget build(BuildContext context) {
    final menu = context.watch<MenuProvider>().menu;
    final colorScheme = Theme.of(context).colorScheme;

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
                for (var group in menu)
                  ExpansionTile(
                    key: PageStorageKey(group.label), // ← mantiene expansión
                    initiallyExpanded: _expandedParent == group.label,
                    onExpansionChanged: (expanded) {
                      setState(() {
                        _expandedParent = expanded ? group.label : null;
                      });
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
                            color: widget.currentRoute == item.route
                                ? colorScheme.primary
                                : null,
                          ),
                          title: Text(item.label),
                          selected: widget.currentRoute == item.route,
                          selectedTileColor: colorScheme.primary.withOpacity(0.1),
                          onTap: () {
                            if (widget.currentRoute != item.route) {
                              Navigator.of(context).pushReplacement(
                                PageRouteBuilder(
                                  pageBuilder: (_, __, ___) => getPageForRoute(item.route),
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
