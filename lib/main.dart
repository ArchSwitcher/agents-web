//import 'package:agents_app/Pages/login.dart';
import 'package:agents_app/controllers/globals.dart';
import 'package:agents_app/controllers/loader_controller.dart';
import 'package:agents_app/controllers/sidebar/menu_sidebar_controller.dart';
import 'package:agents_app/controllers/sidebar/sidebar_controller.dart';
import 'package:agents_app/views/agents/agents_screen.dart';
import 'package:agents_app/views/branches/views/branches_screen.dart';
import 'package:agents_app/views/clients/views/clients_screen.dart';
import 'package:agents_app/views/dashboard/dashboard_screen.dart';
import 'package:agents_app/views/groups/views/groups_screen.dart';
import 'package:agents_app/shared/constants/routes.dart';
import 'package:agents_app/theme/color_pallete.dart';
import 'package:agents_app/views/login/login_screen.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';


// inspiration https://preview.themeon.net/nifty/tables/gridjs/
void main() {
  Get.put(SessionController());
  Get.put(MenuSidebarController()); // nuevo
  Get.put(SidebarController()); // nuevo
  Get.put(LoaderController()); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: GetMaterialApp(
        title: 'El Ebano',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        getPages: [
          GetPage(name: '/', page: () => LoginPage()),
          GetPage(name: RouteConstants.dashboard, page: () => const DashboardScreen()),
          GetPage(name: RouteConstants.agents, page: () => const AgentsScreen()),
          GetPage(name: RouteConstants.clients, page: () => const ClientsScreen()),
          GetPage(name: RouteConstants.groups, page: () => const GroupsScreen()),
          GetPage(name: RouteConstants.branches, page: () => const BranchesScreen()),
        ],
        theme: appTheme,
      ),
    );
  }
}