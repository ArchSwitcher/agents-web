import 'package:agents_app/layout/content_card.dart';
import 'package:flutter/material.dart';
import 'navigation_sidebar.dart';

class ResponsiveSidebarLayout extends StatelessWidget {
  final Widget content;
  final String title;
  final String currentRoute;
  final String userRole;

  const ResponsiveSidebarLayout({
    Key? key,
    required this.content,
    required this.title,
    required this.currentRoute,
    required this.userRole,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        final appBar = AppBar(
          title: Text(
            title,
            style: TextStyle(color: colorScheme.onPrimary),
          ),
          backgroundColor: colorScheme.primary,
          elevation: 0.5,
          automaticallyImplyLeading: constraints.maxWidth <= 600,
          iconTheme: IconThemeData(color: colorScheme.onPrimary),
        );

        if (constraints.maxWidth > 600) {
          return Scaffold(
            body: Row(
              children: [
                NavigationSidebar(
                  userRole: userRole,
                  currentRoute: currentRoute,
                ),
                Expanded(
                  child: Column(
                    children: [
                      appBar,
                      Expanded(child: ContentCard(child: content)),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return Scaffold(
            appBar: appBar,
            drawer: Drawer(
              child: NavigationSidebar(
                userRole: userRole,
                currentRoute: currentRoute,
              ),
            ),
            body: ContentCard(child: content),
          );
        }
      },
    );
  }
}
