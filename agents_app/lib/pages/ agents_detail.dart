import 'package:agents_app/pages/modal_pdf.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/agent_model.dart';

class AgentsDetail extends StatelessWidget {
  final List<Agent> agents;

  const AgentsDetail({super.key, required this.agents});

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, webOnlyWindowName: '_blank');
    } else {
      print("No se pudo abrir el PDF");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Agentes')),
      body: agents.isEmpty
          ? const Center(child: Text('No hay agentes disponibles.'))
          : Padding(
              padding: const EdgeInsets.fromLTRB(200, 0, 200, 20),
              child: ListView.builder(
                itemCount: agents.length,
                itemBuilder: (context, index) {
                  final agent = agents[index];
                  return Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(
                      title: const Text("Información del Agente"),
                      subtitle: Text(agent?.name ?? "data1"),
                      trailing: agent.pdfUrl != null
                          ? IconButton(
                              icon: const Icon(Icons.picture_as_pdf),
                              onPressed: () => _launchURL("http://localhost:80/readPDFs3/readS3?filename=${agent.pdfUrl!}"),
                            )
                          : null,
                    ),
                  );
                },
              ),
            ),
    );
  }
}
