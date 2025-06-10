import 'package:agents_app/controllers/sidebar/menu_sidebar_controller.dart';
import 'package:agents_app/controllers/sidebar/sidebar_controller.dart';
import 'package:agents_app/shared/constants/routes.dart';
import 'package:agents_app/shared/utils/route_selector.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    final MenuSidebarController menuController = Get.find();
    final SidebarController sidebarController = Get.find();
    final colorScheme = Theme.of(context).colorScheme;

    // Cargar menú si está vacío
    if (menuController.menu.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        menuController.loadMenu(userRole);
      });
    }
    return Container(
      width: 250,
      color: colorScheme.surface,
      child: Column(
        children: [
          // AppBar custom
          Container(
            height: kToolbarHeight,
            width: double.infinity,
            color: colorScheme.primary,
            alignment: Alignment.center,
            child: Text(
              "ElEbano",
              style: TextStyle(
                color: colorScheme.surface,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Avatar e información
          Container(
            height: 200,
            width: double.infinity,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: colorScheme.primary,
                ),
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(32),
                  ),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    padding: const EdgeInsets.all(10),
                    color: colorScheme.surface,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircleAvatar(
                          radius: 40,
                          backgroundImage:
                              AssetImage('lib/assets/images/men.png'),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Juan Pérez",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        Text(
                          "Administrador",
                          style: TextStyle(
                            fontSize: 14,
                            color: colorScheme.onSurface.withAlpha(250),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Menú dinámico
          Expanded(
            child: Container(
              decoration: BoxDecoration(color: colorScheme.surface),
              child: Obx(() {
                final menu = menuController.menu;

                if (menu.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                return ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    ListTile(
                      leading: Icon(Icons.dashboard, color: colorScheme.primary),
                      title: const Text("Tablero"),
                      selected: currentRoute == RouteConstants.dashboard,
                      selectedTileColor: colorScheme.primary.withOpacity(0.1),
                      onTap: () {
                        sidebarController.setExpandedGroup(null);
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
                      Obx(() {
                        final isExpanded =
                            sidebarController.expandedGroup.value == group.label;
                        return ExpansionTile(
                          initiallyExpanded: isExpanded,
                          onExpansionChanged: (expanded) {
                            sidebarController
                                .setExpandedGroup(expanded ? group.label : null);
                          },
                          title: Text(
                            group.label,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold),
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
                                        reverseTransitionDuration:
                                            Duration.zero,
                                      ),
                                    );
                                  }
                                },
                              ),
                          ],
                        );
                      }),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.logout),
                      title: const Text("Cerrar sesión"),
                      onTap: () {
                        // lógica logout
                      },
                    ),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
