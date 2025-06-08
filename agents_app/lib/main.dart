//import 'package:agents_app/Pages/login.dart';
import 'package:agents_app/controllers/globals.dart';
import 'package:agents_app/screens/agents/agents_screen.dart';
import 'package:agents_app/screens/clients/clients_screen.dart';
import 'package:agents_app/screens/dashboard/dashboard_screen.dart';
import 'package:agents_app/screens/login_screen.dart';
import 'package:agents_app/providers/menu_provider.dart';
import 'package:agents_app/providers/sidebar_state_provider.dart';
import 'package:agents_app/shared/constants/routes.dart';
import 'package:agents_app/theme/color_pallete.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() {
  Get.put(SessionController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => MenuProvider()),
          ChangeNotifierProvider(create: (_) => SidebarStateProvider()),
        ],
        child: MaterialApp(
            title: 'El Ebano',
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            routes: {
              '/': (context) => LoginPage(),
              RouteConstants.dashboard : (context) => const DashboardScreen(),
              RouteConstants.agents : (context) => const AgentsScreen(),
              RouteConstants.clients : (context) => const ClientsScreen(),
            },
            theme: appTheme
            ));
    //dashboard: const SidebarWidget(body: Text("data")));
  }
}
