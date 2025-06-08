import 'package:agents_app/layout/responsive_sidebar_layout.dart';
import 'package:agents_app/shared/constants/routes.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    //final screenWidth = MediaQuery.of(context).size.width;

    return const ResponsiveSidebarLayout(
      title: 'Usuarios',
      currentRoute: RouteConstants.home,
      userRole: 'admin',
      content: Text("data"),
    );
  }
}
