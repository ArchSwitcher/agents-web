import 'dart:convert';

import 'package:agents_app/layout/content_card.dart';
import 'package:agents_app/layout/responsive_sidebar_layout.dart';
import 'package:agents_app/services/config.dart';
import 'package:agents_app/shared/constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import '../../models/agent_model.dart';

class AgentsDetail extends StatefulWidget {
  final List<Agent> agents;
  final String? agentId;

  const AgentsDetail({super.key, required this.agents, this.agentId});

  @override
  State<AgentsDetail> createState() => _AgentsDetailState();
}

class _AgentsDetailState extends State<AgentsDetail> {
  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, webOnlyWindowName: '_blank');
    } else {
      print("No se pudo abrir el PDF");
    }
  }

  start() async {
    final response = await http
        .get(Uri.parse('${Config.endPointBaseUrl}/agents/cvh/${widget.agentId}'));

    if (response.statusCode == 200) {
      final List<dynamic> agentData = json.decode(response.body);
      print("Agent data: $agentData");
      setState(() {
        widget.agents.addAll(agentData.map((data) => Agent.fromJson(data)).toList());
      });
    } else {
      print('Failed to load agent details');
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.agentId != null) {
        start();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSidebarLayout(
        title: 'Agentes',
        currentRoute: RouteConstants.agents,
        userRole: 'admin',
        content: ContentCard(
          child: widget.agents.isEmpty
              ? const Center(child: Text('No hay agentes disponibles.'))
              : Padding(
                  padding: const EdgeInsets.fromLTRB(200, 0, 200, 20),
                  child: ListView.builder(
                    itemCount: widget.agents.length,
                    itemBuilder: (context, index) {
                      final agent = widget.agents[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: ListTile(
                          title: const Text("Información del Agente"),
                          subtitle: Text(agent.name ?? "data1"),
                          trailing: agent.pdfUrl != null
                              ? IconButton(
                                  icon: const Icon(Icons.picture_as_pdf),
                                  onPressed: () => _launchURL(
                                      "${Config.endPointBaseUrl}/readPDFs3/readS3?filename=${agent.pdfUrl!}"),
                                )
                              : null,
                        ),
                      );
                    },
                  ),
                ),
        ));
  }
}
