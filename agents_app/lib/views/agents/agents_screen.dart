import 'package:agents_app/controllers/globals.dart';
import 'package:agents_app/layout/responsive_sidebar_layout.dart';
import 'package:agents_app/models/agent_model.dart';
import 'package:agents_app/views/agents/agents_detail.dart';
import 'package:agents_app/services/agent_service.dart';
import 'package:agents_app/shared/constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AgentsScreen extends StatefulWidget {
  const AgentsScreen({ Key? key }) : super(key: key);

  @override
  _AgentsScreenState createState() => _AgentsScreenState();
}

class _AgentsScreenState extends State<AgentsScreen> {

  late Future<AgentData?> _agentDataFuture;

  final global = Get.find<SessionController>();
  @override
  void initState() {
    super.initState();
    _agentDataFuture = AgentService.fetchAgentData(global.getUserId);
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSidebarLayout(
      title: 'Agentes',
      currentRoute: RouteConstants.agents,
      userRole: 'admin',
      content: FutureBuilder<AgentData?>(
        future: _agentDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('Error al cargar datos.'));
          }

          final agentCodes = snapshot.data!.agentCodes?? [];

          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Center(
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Nombre')),
                  DataColumn(label: Text('Acción')),
                ],
                rows: agentCodes.map((code) {
                  return DataRow(cells: [
                    DataCell(Text(code.id.toString())),
                    DataCell(Text(code.name ?? "name")),
                    DataCell(
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AgentsDetail(agents: code.agents ?? []),
                            ),
                          );
                        },
                        child: const Text('Ir'),
                      ),
                    ),
                  ]);
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}