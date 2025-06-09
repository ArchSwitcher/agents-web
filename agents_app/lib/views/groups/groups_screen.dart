import 'package:agents_app/layout/responsive_sidebar_layout.dart';
import 'package:agents_app/services/toast_service.dart';
import 'package:agents_app/shared/constants/routes.dart';
import 'package:agents_app/widgets/commons/custom_button.dart';
import 'package:flutter/material.dart';

class GroupsScreen extends StatefulWidget {
  const GroupsScreen({super.key});

  @override
  GroupsScreenState createState() => GroupsScreenState();
}

class GroupsScreenState extends State<GroupsScreen> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveSidebarLayout(
        title: 'Grupos',
        currentRoute: RouteConstants.groups,
        userRole: 'admin',
        content: Column(children: [
          CustomButton(
              color: Color(0xffeaeaea),
              text: "text",
              isLoading: false,
              onPress: () {
                ToastService.success(
                  title: "Éxito",
                  subTitle: "Operación completada correctamente",
                );
              }),
        ]));
  }
}
