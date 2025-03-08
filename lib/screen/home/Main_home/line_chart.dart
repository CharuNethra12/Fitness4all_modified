import 'package:fitness4all/common/color_extensions.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class MyLineChart extends StatefulWidget {
  const MyLineChart({super.key});

  @override
  _MyLineChartState createState() => _MyLineChartState();
}

class _MyLineChartState extends State<MyLineChart> {
  List<Color> gradientColors = [
    const Color(0xffFB784E),
    TColor.secondary,
    TColor.secondary,
    const Color(0xffFB784E),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 1.70,
          child: Container(
            child: LineChart(mainData()),
          ),
        )
      ],
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: const FlGridData(show: false),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 22,
            getTitlesWidget: (value, meta) {
              switch (value.toInt()) {
                case 2:
                  return const Text('1 km', style: TextStyle(fontSize: 16.0, color: Colors.black87));
                case 4:
                  return const Text('2 km', style: TextStyle(fontSize: 16.0, color: Colors.black87));
                case 6:
                  return const Text('3 km', style: TextStyle(fontSize: 16.0, color: Colors.black87));
                case 8:
                  return const Text('4 km', style: TextStyle(fontSize: 16.0, color: Colors.black87));
                case 10:
                  return const Text('5 km', style: TextStyle(fontSize: 16.0, color: Colors.black87));
                default:
                  return const SizedBox();
              }
            },
            interval: 2,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(show: false),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: [
            const FlSpot(0, 3),
            const FlSpot(2, 2),
            const FlSpot(4, 5),
            const FlSpot(6, 3.1),
            const FlSpot(8, 4),
            const FlSpot(10, 3),
            const FlSpot(12, 7),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: false,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors.map((color) => color.withOpacity(0.3)).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
