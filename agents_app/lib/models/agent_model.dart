class AgentData {
  final int id;
  final List<AgentCode> agentCodes;

  AgentData({required this.id, required this.agentCodes});

  factory AgentData.fromJson(Map<String, dynamic> json) {
    return AgentData(
      id: json['id'],
      agentCodes: (json['agent_codes'] as List)
          .map((e) => AgentCode.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'agent_codes': agentCodes.map((e) => e.toJson()).toList(),
      };
}

class AgentCode {
  final int id;
  final String name;
  final List<Agent> agents;

  AgentCode({required this.id, required this.name, required this.agents});

  factory AgentCode.fromJson(Map<String, dynamic> json) {
    return AgentCode(
      id: json['id'],
      name: json['name'],
      agents: (json['agents'] as List)
          .map((e) => Agent.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'agents': agents.map((e) => e.toJson()).toList(),
      };
}

class Agent {
  final int id;
  final String name;
  final String route;
  final int agentCodeId;
  final String? pdfUrl;

  Agent({
    required this.id,
    required this.name,
    required this.route,
    required this.agentCodeId,
    this.pdfUrl,
  });

  factory Agent.fromJson(Map<String, dynamic> json) {
    return Agent(
      id: json['id'],
      name: json['name'],
      route: json['route'],
      agentCodeId: json['agent_code_id'],
      pdfUrl: json['pdf_url'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'route': route,
        'agent_code_id': agentCodeId,
        'pdf_url': pdfUrl,
      };
}