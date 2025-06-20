import 'package:agents_app/layout/content_card.dart';
import 'package:agents_app/layout/responsive_sidebar_layout.dart';
import 'package:agents_app/shared/constants/routes.dart';
import 'package:flutter/material.dart';

class ManagePositionScreen extends StatefulWidget {
  const ManagePositionScreen({super.key});

  @override
  ManagePositionScreenState createState() => ManagePositionScreenState();
}

class ManagePositionScreenState extends State<ManagePositionScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return ResponsiveSidebarLayout(
        title: "Posición",
        description: "Gestión de posiciones para clientes",
        currentRoute: RouteConstants.positions,
        userRole: "admin",
        content: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                ContentCard(
                  child: LayoutBuilder(builder: (context, constraints) {
                    return Wrap(
                      spacing: 30, // espacio horizontal entre widgets
                      runSpacing: 20, // espacio vertical entre líneas si se hace wrap
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.spaceBetween,
                      children: [
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            minWidth: 300,
                            maxWidth: 600,
                          ),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: "Nombre de la posición",
                              hintText: "Ingrese el nombre de la posición",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor ingrese un nombre';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          width: 170,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // Aquí puedes manejar el envío del formulario
                                Navigator.pop(context);
                              }
                            },
                            child: const Text("Guardar"),
                          ),
                        )
                      ],
                    );
                  }
                ))
              ],
            ),
          ),
        ));
  }
}
