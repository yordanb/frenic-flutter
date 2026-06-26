import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class VfdChart extends StatelessWidget {
  final List<FlSpot> freqSpots;
  final List<FlSpot> currentSpots;

  const VfdChart({
    super.key,
    required this.freqSpots,
    required this.currentSpots,
  });

  @override
  Widget build(BuildContext context) {
    final hasData = freqSpots.isNotEmpty;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Trend',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 220,
              child: hasData
                  ? LineChart(
                      LineChartData(
                        gridData: FlGridData(
                          show: true,
                          drawHorizontalLine: true,
                          drawVerticalLine: false,
                          horizontalInterval: 10,
                          getDrawingHorizontalLine: (value) => FlLine(
                            color: Colors.white.withOpacity(0.05),
                            strokeWidth: 1,
                          ),
                        ),
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            axisNameWidget: Text(
                              'Freq (Hz) / Cur (A)',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey[500],
                              ),
                            ),
                            axisNameSize: 22,
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 32,
                              getTitlesWidget: (value, meta) {
                                return Text(
                                  '${value.toInt()}',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey[600],
                                  ),
                                );
                              },
                            ),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          rightTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                        ),
                        borderData: FlBorderData(show: false),
                        lineBarsData: [
                          // Frequency line
                          LineChartBarData(
                            spots: freqSpots,
                            isCurved: true,
                            color: Colors.teal,
                            barWidth: 2.5,
                            dotData: FlDotData(show: false),
                            belowBarData: BarAreaData(
                              show: true,
                              color: Colors.teal.withOpacity(0.1),
                            ),
                          ),
                          // Current line
                          LineChartBarData(
                            spots: currentSpots,
                            isCurved: true,
                            color: Colors.amber,
                            barWidth: 2.5,
                            dotData: FlDotData(show: false),
                            belowBarData: BarAreaData(
                              show: true,
                              color: Colors.amber.withOpacity(0.08),
                            ),
                          ),
                        ],
                        lineTouchData: LineTouchData(
                          touchTooltipData: LineTouchTooltipData(
                            getTooltipItems: (touchedSpots) {
                              return touchedSpots.map((spot) {
                                final label = spot.barIndex == 0 ? 'Freq' : 'Curr';
                                return LineTooltipItem(
                                  '$label: ${spot.y.toStringAsFixed(1)}',
                                  TextStyle(
                                    color: spot.barIndex == 0
                                        ? Colors.teal
                                        : Colors.amber,
                                    fontWeight: FontWeight.w600,
                                  ),
                                );
                              }).toList();
                            },
                          ),
                        ),
                      ),
                    )
                  : const Center(
                      child: Text(
                        'No data yet.\nConnect to VFD to see trend.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
            ),
            // Legend
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _legendDot(Colors.teal, 'Frequency'),
                const SizedBox(width: 24),
                _legendDot(Colors.amber, 'Current'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _legendDot(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[400],
          ),
        ),
      ],
    );
  }
}
