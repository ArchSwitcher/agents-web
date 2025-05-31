import 'package:flutter/material.dart';
import '../services/agent_service.dart';
import '../models/agent_model.dart';

class Agents extends StatefulWidget {
  const Agents({Key? key}) : super(key: key);

  @override
  _AgentsState createState() => _AgentsState();
}

class _AgentsState extends State<Agents> {
  late Future<AgentData?> _agentDataFuture;

  @override
  void initState() {
    super.initState();
    _agentDataFuture = AgentService.fetchAgentData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Códigos de Agente')),
      body: FutureBuilder<AgentData?>(
        future: _agentDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('Error al cargar datos.'));
          }

          final agentCodes = snapshot.data!.agentCodes;

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
                    DataCell(Text(code.name)),
                    DataCell(
                      ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Clic en ${code.name}')),
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
