// ignore_for_file: library_private_types_in_public_api

import 'package:agents_app/controllers/loader_controller.dart';
import 'package:agents_app/layout/responsive_sidebar_layout.dart';
import 'package:agents_app/shared/constants/routes.dart';
import 'package:agents_app/views/branches/controller/branch_controller.dart';
import 'package:agents_app/views/branches/views/branches_screen.dart';
import 'package:agents_app/views/branches/views/contacts_screen.dart';
import 'package:agents_app/views/branches/views/social_reasons_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BranchMain extends StatefulWidget {
  const BranchMain({super.key});

  @override
  _BranchMainState createState() => _BranchMainState();
}

class _BranchMainState extends State<BranchMain> {
  final BranchController controller = Get.put(BranchController());
  final loader = Get.find<LoaderController>();


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ResponsiveSidebarLayout(
        title: "Sucursales",
        description: "Administración de sucursales por cliente",
        currentRoute: RouteConstants.branch,
        userRole: "admin",
        content: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    width: 600,
                    child: TabBar(
                      physics: const NeverScrollableScrollPhysics(),
                      // controller: _tabController,
                      dividerColor: Colors.transparent,
                      isScrollable: false,
                      indicator: BoxDecoration(
                        color: colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelColor: Colors.white,
                      labelPadding:
                          const EdgeInsets.symmetric(horizontal: 12),
                      tabs: [
                        Tab(
                          child: Container(
                            decoration: BoxDecoration(
                              color: colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.gite, color: Colors.white),
                                SizedBox(width: 8),
                                Text(
                                  "Sucursales",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            decoration: BoxDecoration(
                              color: colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.contact_phone,
                                    color: Colors.white),
                                SizedBox(width: 8),
                                Text(
                                  "Contactos",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            decoration: BoxDecoration(
                              color: colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.business, color: Colors.white),
                                SizedBox(width: 8),
                                Text(
                                  "Razón social",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: Get.height - 200,
                child: TabBarView(
                  children: [
                    BranchesScreen(),
                    ContactsScreen(),
                    SocialReasonsScreen()
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
