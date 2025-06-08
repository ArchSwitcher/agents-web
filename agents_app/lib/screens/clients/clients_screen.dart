import 'package:agents_app/layout/responsive_sidebar_layout.dart';
import 'package:agents_app/shared/constants/routes.dart';
import 'package:flutter/material.dart';

class ClientsScreen extends StatefulWidget {
  const ClientsScreen({super.key});

  @override
  _ClientsScreenState createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {
  @override
  Widget build(BuildContext context) {
    return const ResponsiveSidebarLayout(
      title: 'Agentes',
      currentRoute: RouteConstants.clients,
      userRole: 'admin',
      content: Text("Generate list edit clients and groups")
      );
    
    
  }
}
