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
      color: colorScheme.surfaceContainerHighest,
      child: Column(
        children: [
          // Sección 1: Encabezado tipo AppBar
          Container(
            height: kToolbarHeight, // Altura igual a AppBar
            width: double.infinity,
            color: colorScheme.primary,
            alignment: Alignment.center,
            child: Text(
              "ElEbano",
              style: TextStyle(
                color: colorScheme.onPrimary,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Sección 2: Imagen + título + subtítulo con fondo parche para el espacio vacío
          Container(
            height: 200,
            width: double.infinity,
            child: Stack(
              children: [
                // Fondo que rellena el espacio fuera del borde redondeado
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: colorScheme.primary,
                ),

                // Contenedor con borde redondeado encima, ocupa todo el ancho
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(32),
                  ),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    padding: const EdgeInsets.all(10),
                    color: colorScheme.surfaceVariant,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
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
                            color: colorScheme.onSurface.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Sección 3: Cuerpo del sidebar con borde redondeado
          Expanded(
            child: Container(
              decoration: BoxDecoration(color: colorScheme.surface),
              child: menu.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        // Remueve el DrawerHeader, ya no se necesita
                        ListTile(
                          leading:
                              Icon(Icons.dashboard, color: colorScheme.primary),
                          title: const Text("Tablero"),
                          selected: currentRoute == RouteConstants.dashboard,
                          selectedTileColor:
                              colorScheme.primary.withOpacity(0.1),
                          onTap: () {
                            context
                                .read<SidebarStateProvider>()
                                .setExpandedGroup(null);
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
                                  .setExpandedGroup(
                                      expanded ? group.label : null);
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
            ),
          ),
        ],
      ),
    );
  }
}
