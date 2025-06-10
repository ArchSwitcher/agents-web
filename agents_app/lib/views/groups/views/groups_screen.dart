import 'package:agents_app/layout/content_card.dart';
import 'package:agents_app/layout/responsive_sidebar_layout.dart';
import 'package:agents_app/services/toast_service.dart';
import 'package:agents_app/shared/constants/routes.dart';
import 'package:agents_app/shared/resources/custom_style.dart';
import 'package:agents_app/shared/resources/strings.dart';
import 'package:agents_app/views/groups/controllers/manage_group_controller.dart';
import 'package:agents_app/views/groups/views/manage_group_modal.dart';
import 'package:agents_app/widgets/commons/custom_button.dart';
import 'package:flutter/material.dart';

class GroupsScreen extends StatefulWidget {
  const GroupsScreen({super.key});

  @override
  GroupsScreenState createState() => GroupsScreenState();
}

class GroupsScreenState extends State<GroupsScreen> {
  final ManageGroupController controller = ManageGroupController();
  final _formKeyDeveloper = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ResponsiveSidebarLayout(
        title: 'Grupos',
        description: "Configuración de grupos empresariales",
        currentRoute: RouteConstants.groups,
        userRole: 'admin',
        content: Column(
          children: [
            ContentCard(
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                CustomButton(
                    color: colorScheme.primary,
                    text: Row(
                      children: [
                        Icon(
                          Icons.group_add,
                          color: colorScheme.onPrimary,
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        Text(
                          "Nuevo Grupo",
                          style: CustomStyle.textStyle(context),
                        )
                      ],
                    ),
                    isLoading: false,
                    onPress: () {
                      print('agregar Elemento');
                      showManageGroupModal(
                        context: context,
                        controller: controller,
                        onAccept: () {
                          ToastService.success(
                            title: "!!Grupo agregado",
                            subTitle: Strings.toastSuccessOperation,
                          );
                        },
                        onCancel: () {
                          print('Cancelado');
                        },
                      );
                    }),
              ]),
            ),
          ],
        ));
  }
}


