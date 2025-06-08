import 'package:agents_app/pages/agents.dart';
import 'package:agents_app/pages/dashboard.dart';
import 'package:agents_app/shared/constants/routes.dart';
import 'package:flutter/material.dart';

Widget getPageForRoute(String route) {
  switch (route) {
    case RouteConstants.home:
      return const Dashboard();
    case RouteConstants.agents:
      return const Agents();
    // ... otras rutas
    default:
      return const Dashboard(); // fallback
  }
}
