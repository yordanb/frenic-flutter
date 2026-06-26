import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:frenic_mega_dashboard/core/constants/app_constants.dart';
import 'package:frenic_mega_dashboard/data/models/vfd_data.dart';
import '../providers/vfd_provider.dart';
import '../widgets/vfd_gauge_card.dart';
import '../widgets/vfd_chart.dart';
import '../widgets/connection_status_bar.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  final List<FlSpot> _freqSpots = [];
  final List<FlSpot> _currentSpots = [];

  @override
  Widget build(BuildContext context) {
    final vfdAsync = ref.watch(vfdDataProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('FRENIC-MEGA'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: vfdAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.redAccent),
              const SizedBox(height: 16),
              Text('Connection Error', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              Text('$err', style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
        data: (data) => _buildDashboard(context, data),
      ),
    );
  }

  Widget _buildDashboard(BuildContext context, VfdData data) {
    // Keep last N points for chart
    if (data.frequency > 0) {
      _freqSpots.add(FlSpot(_freqSpots.length.toDouble(), data.frequency));
      _currentSpots.add(FlSpot(_currentSpots.length.toDouble(), data.current));
      if (_freqSpots.length > AppConstants.chartPointCount) {
        _freqSpots.removeAt(0);
        _currentSpots.removeAt(0);
      }
    }

    return RefreshIndicator(
      onRefresh: () async => ref.invalidate(vfdDataProvider),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Connection Status
            ConnectionStatusBar(isConnected: data.isConnected),

            const SizedBox(height: 16),

            // Gauge Cards Row
            Row(
              children: [
                Expanded(
                  child: VfdGaugeCard(
                    title: 'Frequency',
                    value: data.frequencyText,
                    icon: Icons.speed,
                    color: Colors.teal,
                    gaugeValue: (data.frequency / 60.0).clamp(0.0, 1.0),
                    subtitle: 'Hz',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: VfdGaugeCard(
                    title: 'Current',
                    value: data.currentText,
                    icon: Icons.electric_bolt,
                    color: Colors.amber,
                    gaugeValue: (data.current / 20.0).clamp(0.0, 1.0),
                    subtitle: 'A',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: VfdGaugeCard(
                    title: 'Voltage',
                    value: data.voltageText,
                    icon: Icons.bolt,
                    color: Colors.indigo,
                    gaugeValue: (data.voltage / 500.0).clamp(0.0, 1.0),
                    subtitle: 'V',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: VfdGaugeCard(
                    title: 'Power',
                    value: data.powerText,
                    icon: Icons.power,
                    color: Colors.orangeAccent,
                    gaugeValue: (data.power / 5.0).clamp(0.0, 1.0),
                    subtitle: 'kW',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Hour meter + Alarm card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    const Icon(Icons.access_time, size: 36, color: Colors.teal),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Operation Time', style: Theme.of(context).textTheme.bodySmall),
                        Text(
                          data.hourText,
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: Colors.teal,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: data.alarmCode == 0
                            ? Colors.green.withOpacity(0.2)
                            : Colors.red.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Status: ${data.alarmText}',
                        style: TextStyle(
                          color: data.alarmCode == 0 ? Colors.green : Colors.red,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Trend Chart
            VfdChart(
              freqSpots: _freqSpots,
              currentSpots: _currentSpots,
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
