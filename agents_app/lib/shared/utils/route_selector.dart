import 'package:agents_app/views/agents/agents_screen.dart';
import 'package:agents_app/views/clients/clients_screen.dart';
import 'package:agents_app/views/dashboard/dashboard_screen.dart';
import 'package:agents_app/shared/constants/routes.dart';
import 'package:agents_app/views/groups/views/groups_screen.dart';
import 'package:agents_app/views/login_screen.dart';
import 'package:flutter/material.dart';

Widget getPageForRoute(String route) {
  switch (route) {
    case RouteConstants.dashboard:
      return const DashboardScreen();
    case RouteConstants.agents:
      return const AgentsScreen();
    case RouteConstants.clients:
      return const ClientsScreen();
    case RouteConstants.groups:
    return const GroupsScreen();
    default:
      return LoginPage();
  }
}
