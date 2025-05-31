import 'package:flutter/material.dart';
import '../models/agent_model.dart';

class AgentsPage extends StatelessWidget {
  final List<Agent> agents;

  const AgentsPage({super.key, required this.agents});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Agentes')),
      body: agents.isEmpty
          ? const Center(child: Text('No hay agentes disponibles.'))
          : ListView.builder(
              itemCount: agents.length,
              itemBuilder: (context, index) {
                final agent = agents[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text(agent.name),
                    subtitle: Text('Ruta: ${agent.route}'),
                    trailing: agent.pdfUrl != null
                        ? IconButton(
                            icon: const Icon(Icons.picture_as_pdf),
                            onPressed: () {
                              // Abrir o mostrar el PDF si es necesario
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Abrir PDF de ${agent.name}')),
                              );
                            },
                          )
                        : null,
                  ),
                );
              },
            ),
    );
  }
}