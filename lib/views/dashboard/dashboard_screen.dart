import 'package:agents_app/layout/content_card.dart';
import 'package:agents_app/layout/responsive_sidebar_layout.dart';
import 'package:agents_app/shared/constants/routes.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSidebarLayout(
      title: 'Tablero',
      description: "resumen de acciones y estadísticas",
      currentRoute: RouteConstants.dashboard,
      userRole: 'admin',
      content: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            resumeCards(context),
            const SizedBox(height: 32),
            userReport(context)
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 2,
      color: colorScheme.primaryContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SizedBox(
        width: 140,
        height: 125,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 32, color: colorScheme.onPrimary),
              const SizedBox(height: 8),
              Text(
                value,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onPrimary,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: colorScheme.onPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActivityItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _ActivityItem({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ListTile(
      leading: Icon(icon, color: colorScheme.onPrimary),
      title: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurface,
            ),
      ),
    );
  }
}

Widget resumeCards(BuildContext context) {
  final textTheme = Theme.of(context).textTheme;
  final colorScheme = Theme.of(context).colorScheme;

  return ContentCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Bienvenido de nuevo 👋',
          style: textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Aquí tienes un resumen del sistema.',
          style: textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurface.withOpacity(0.8),
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 24),
        const Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            _InfoCard(
              icon: Icons.people,
              label: 'Clientes',
              value: '215',
            ),
            _InfoCard(
              icon: Icons.person,
              label: 'Usuarios',
              value: '130',
            ),
            _InfoCard(
              icon: Icons.shield,
              label: 'Agentes',
              value: '34',
            ),
            _InfoCard(
              icon: Icons.settings,
              label: 'Parámetros',
              value: '12',
            ),
          ],
        ),
      ],
    ),
  );
}

Widget userReport(BuildContext context) {
  final textTheme = Theme.of(context).textTheme;
  // final colorScheme = Theme.of(context).colorScheme;

  return ContentCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Actividades recientes',
          style: textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 12),
        const _ActivityItem(
          icon: Icons.login,
          text: 'Usuario Juan Pérez inició sesión',
        ),
        const _ActivityItem(
          icon: Icons.edit,
          text: 'Se modificó el perfil de un agente',
        ),
        const _ActivityItem(
          icon: Icons.person_add,
          text: 'Nuevo cliente registrado',
        ),
      ],
    ),
  );
}
