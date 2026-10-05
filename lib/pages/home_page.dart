import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:speedometer/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/di/injection.dart';
import '../core/units/app_units_controller.dart';
import '../features/speedometer/presentation/cubit/speedometer_cubit.dart';
import '../features/speedometer/presentation/cubit/speedometer_state.dart';
import '../widgets/speed_gauge.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SpeedometerCubit>()..start(),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatefulWidget {
  const _HomeView();

  @override
  State<_HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<_HomeView> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // Coming back from system settings: re-check service and permission.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state != AppLifecycleState.resumed) return;
    final cubit = context.read<SpeedometerCubit>();
    if (cubit.state.status != SpeedometerStatus.tracking &&
        cubit.state.status != SpeedometerStatus.waitingForFix) {
      cubit.start();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        actions: [
          BlocSelector<SpeedometerCubit, SpeedometerState, bool>(
            selector: (s) => s.status == SpeedometerStatus.tracking,
            builder: (context, tracking) => IconButton(
              tooltip: l10n.speedResetTrip,
              icon: const Icon(Icons.restart_alt_rounded),
              onPressed: tracking
                  ? () {
                      context.read<SpeedometerCubit>().resetTrip();
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(content: Text(l10n.speedResetTripDone)),
                        );
                    }
                  : null,
            ),
          ),
          IconButton(
            tooltip: l10n.settings,
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<SpeedometerCubit, SpeedometerState>(
          buildWhen: (a, b) => a.status != b.status,
          builder: (context, state) {
            final cubit = context.read<SpeedometerCubit>();
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: switch (state.status) {
                SpeedometerStatus.checking => const Center(
                  key: ValueKey('checking'),
                  child: CircularProgressIndicator(),
                ),
                SpeedometerStatus.serviceDisabled => _StatusPanel(
                  key: const ValueKey('service'),
                  icon: Icons.location_off_outlined,
                  title: l10n.locationServiceDisabledTitle,
                  body: l10n.locationServiceDisabledBody,
                  actionLabel: l10n.openLocationSettings,
                  onAction: cubit.openLocationSettings,
                  onRetry: cubit.start,
                ),
                SpeedometerStatus.permissionDenied => _StatusPanel(
                  key: const ValueKey('denied'),
                  icon: Icons.my_location_rounded,
                  title: l10n.permissionDeniedTitle,
                  body: l10n.permissionDeniedBody,
                  actionLabel: l10n.grantPermission,
                  onAction: cubit.start,
                ),
                SpeedometerStatus.permissionDeniedForever => _StatusPanel(
                  key: const ValueKey('forever'),
                  icon: Icons.block_rounded,
                  title: l10n.permissionDeniedForeverTitle,
                  body: l10n.permissionDeniedForeverBody,
                  actionLabel: l10n.openAppSettings,
                  onAction: cubit.openAppSettings,
                  onRetry: cubit.start,
                ),
                SpeedometerStatus.waitingForFix => _StatusPanel(
                  key: const ValueKey('fix'),
                  icon: Icons.satellite_alt_outlined,
                  title: l10n.waitingForGpsTitle,
                  body: l10n.waitingForGpsBody,
                  busy: true,
                ),
                SpeedometerStatus.tracking => const _Dashboard(
                  key: ValueKey('tracking'),
                ),
              },
            );
          },
        ),
      ),
    );
  }
}

class _Dashboard extends StatelessWidget {
  const _Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final units = getIt<AppUnitsController>();

    return ListenableBuilder(
      listenable: units,
      builder: (context, _) {
        final u = units.preference;
        final speedUnit = u == AppUnitsPreference.metric
            ? l10n.unitKmh
            : l10n.unitMph;
        final distanceUnit = u == AppUnitsPreference.metric
            ? l10n.unitKm
            : l10n.unitMi;
        final altitudeUnit = u == AppUnitsPreference.metric
            ? l10n.unitMeters
            : l10n.unitFeet;

        return BlocBuilder<SpeedometerCubit, SpeedometerState>(
          builder: (context, state) {
            final gauge = Padding(
              padding: const EdgeInsets.all(16),
              child: SpeedGauge(
                speed: u.speedFromMps(state.speedMps),
                topSpeed: u.speedFromMps(state.topSpeedMps),
                maximum: u.gaugeMaximum,
                unitLabel: speedUnit,
              ),
            );

            final stats = [
              _StatCard(
                icon: Icons.bolt_rounded,
                label: l10n.statTopSpeed,
                value: u.speedFromMps(state.topSpeedMps).toStringAsFixed(1),
                unit: speedUnit,
              ),
              _StatCard(
                icon: Icons.av_timer_rounded,
                label: l10n.statAverageSpeed,
                value: u.speedFromMps(state.averageSpeedMps).toStringAsFixed(1),
                unit: speedUnit,
              ),
              _StatCard(
                icon: Icons.route_rounded,
                label: l10n.statDistance,
                value: u
                    .distanceFromMeters(state.distanceMeters)
                    .toStringAsFixed(2),
                unit: distanceUnit,
              ),
              _StatCard(
                icon: Icons.terrain_rounded,
                label: l10n.statAltitude,
                value: u
                    .altitudeFromMeters(state.position?.altitude ?? 0)
                    .toStringAsFixed(0),
                unit: altitudeUnit,
              ),
            ];

            final details = Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.7,
                  children: stats,
                ),
                const SizedBox(height: 12),
                _LocationCard(state: state),
              ],
            );

            return OrientationBuilder(
              builder: (context, orientation) {
                if (orientation == Orientation.landscape) {
                  return Row(
                    children: [
                      Expanded(child: Center(child: gauge)),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.fromLTRB(0, 16, 24, 16),
                          child: details,
                        ),
                      ),
                    ],
                  );
                }
                return SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                  child: Column(
                    children: [
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 420),
                        child: gauge,
                      ),
                      details,
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.unit,
  });

  final IconData icon;
  final String label;
  final String value;
  final String unit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, size: 18, color: scheme.primary),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: value,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontFeatures: const [FontFeature.tabularFigures()],
                      ),
                    ),
                    TextSpan(
                      text: ' $unit',
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LocationCard extends StatelessWidget {
  const _LocationCard({required this.state});

  final SpeedometerState state;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final p = state.position;
    if (p == null) return const SizedBox.shrink();

    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        contentPadding: const EdgeInsets.fromLTRB(16, 6, 8, 6),
        leading: CircleAvatar(
          backgroundColor: scheme.primaryContainer,
          child: Icon(Icons.place_outlined, color: scheme.onPrimaryContainer),
        ),
        title: Text(l10n.locationTitle),
        subtitle: Text(
          '${p.latitude.toStringAsFixed(5)}, ${p.longitude.toStringAsFixed(5)}'
          '  ·  ${l10n.locationAccuracy(p.accuracy.toStringAsFixed(0))}',
          style: theme.textTheme.bodySmall?.copyWith(
            color: scheme.onSurfaceVariant,
            fontFeatures: const [FontFeature.tabularFigures()],
          ),
        ),
        trailing: IconButton.filledTonal(
          tooltip: l10n.locationOpenInMaps,
          icon: const Icon(Icons.map_outlined),
          onPressed: () => launchUrl(
            Uri.parse(
              'https://www.google.com/maps/search/?api=1&query=${p.latitude},${p.longitude}',
            ),
            mode: LaunchMode.externalApplication,
          ),
        ),
      ),
    );
  }
}

/// Centered illustration + message for the non-tracking states.
class _StatusPanel extends StatelessWidget {
  const _StatusPanel({
    super.key,
    required this.icon,
    required this.title,
    required this.body,
    this.actionLabel,
    this.onAction,
    this.onRetry,
    this.busy = false,
  });

  final IconData icon;
  final String title;
  final String body;
  final String? actionLabel;
  final VoidCallback? onAction;
  final VoidCallback? onRetry;
  final bool busy;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  if (busy)
                    SizedBox(
                      width: 112,
                      height: 112,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        color: scheme.primary,
                      ),
                    ),
                  CircleAvatar(
                    radius: 44,
                    backgroundColor: scheme.primaryContainer,
                    child: Icon(
                      icon,
                      size: 44,
                      color: scheme.onPrimaryContainer,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              Text(
                title,
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                body,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: scheme.onSurfaceVariant,
                  height: 1.35,
                ),
              ),
              if (actionLabel != null) ...[
                const SizedBox(height: 28),
                FilledButton.icon(
                  onPressed: onAction,
                  icon: const Icon(Icons.arrow_forward_rounded),
                  label: Text(actionLabel!),
                ),
              ],
              if (onRetry != null) ...[
                const SizedBox(height: 8),
                TextButton(onPressed: onRetry, child: Text(l10n.retry)),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
