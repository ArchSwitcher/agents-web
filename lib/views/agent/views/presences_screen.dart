import 'package:agents_app/layout/responsive_sidebar_layout.dart';
import 'package:agents_app/shared/constants/routes.dart';
import 'package:flutter/material.dart';

class PresencesScreen extends StatefulWidget {
  const PresencesScreen({Key? key}) : super(key: key);

  @override
  _PresencesScreenState createState() => _PresencesScreenState();
}

class _PresencesScreenState extends State<PresencesScreen> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveSidebarLayout(
      title: "Mi posicion",
      currentRoute: RouteConstants.myPresence,
      userRole: "agente",
      content: SingleChildScrollView(
        child: Column(
          children: [
            
          ],
        ),
      ),
    );
  }
}
