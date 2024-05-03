import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haleyora/constants.dart';

class PieChartWidget extends StatelessWidget {
  final List<Sector> sectors;

  const PieChartWidget(this.sectors, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 100,
        height: 100,
        child: PieChart(PieChartData(
          sections: _chartSections(sectors),
          centerSpaceRadius: 40.0,
          startDegreeOffset: -90,
        )));
  }

  List<PieChartSectionData> _chartSections(List<Sector> sectors) {
    final List<PieChartSectionData> list = [];
    for (var sector in sectors) {
      const double radius = 9.0;
      final data = PieChartSectionData(
        color: sector.color,
        value: sector.value,
        radius: radius,
        title: '',
      );
      list.add(data);
    }
    return list;
  }
}

class ProgressPieChart extends StatelessWidget {
  final double progress;

  const ProgressPieChart(this.progress, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          // center
          top: 26,
          left: 30,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Skor",
                style: GoogleFonts.lexend(
                  color: greyText,
                  fontWeight: FontWeight.w600,
                  fontSize: 8,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "${(progress * 100).toInt()}",
                    style: GoogleFonts.lexend(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    "/ 100",
                    style: GoogleFonts.lexend(
                      color: greyText,
                      fontWeight: FontWeight.bold,
                      fontSize: 8,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        PieChartWidget([
          Sector(progress, Colors.green),
          Sector(1 - progress, Colors.grey[200]!),
        ])
      ],
    );
  }
}

class Sector {
  final double value;
  final Color color;

  Sector(this.value, this.color);
}
