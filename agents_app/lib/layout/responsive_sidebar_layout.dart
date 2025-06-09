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

        Widget backgroundWave = SizedBox(
          height: constraints.maxHeight * 0.4,
          width: double.infinity,
          child: CustomPaint(
            painter: WavePainter(color: colorScheme.primary),
          ),
        );

        Widget stackedContent = Stack(
          children: [
            Positioned.fill(
              child: Column(
                children: [
                  backgroundWave,
                  Expanded(child: Container()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0),
              child: content,
            ),
          ],
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
                      Expanded(child: stackedContent),
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
            body: stackedContent,
          );
        }
      },
    );
  }
}


class WavePainter extends CustomPainter {

  final Color color;

  WavePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    path.lineTo(0, size.height * 0.8);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height * 0.8);
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
