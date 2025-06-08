//import 'package:agents_app/Pages/login.dart';
import 'package:agents_app/controllers/globals.dart';
import 'package:agents_app/pages/agents.dart';
import 'package:agents_app/pages/dashboard.dart';
import 'package:agents_app/pages/login.dart';
import 'package:agents_app/providers/menu_provider.dart';
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
        ],
        child: MaterialApp(
            title: 'El Ebano',
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            routes: {
              '/': (context) => LoginPage(),
              RouteConstants.home : (context) => Dashboard(),
              RouteConstants.agents : (context) => const Agents(),
            },
            theme: appTheme
            ));
    //home: const SidebarWidget(body: Text("data")));
  }
}
