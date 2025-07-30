import 'package:agents_app/layout/responsive_sidebar_layout.dart';
import 'package:agents_app/shared/constants/routes.dart';
import 'package:flutter/material.dart';

class AgentRecordsScreen extends StatefulWidget {
  const AgentRecordsScreen({ super.key });

  @override
  AgentRecordsScreenState createState() => AgentRecordsScreenState();
}

class AgentRecordsScreenState extends State<AgentRecordsScreen> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveSidebarLayout(
      title: 'Expedientes de Agentes',
      currentRoute: RouteConstants.agentRecords,
      userRole: 'admin',
      content: Center(
        child: Text(
          'Expedientes de Agentes',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
    );
  }
}