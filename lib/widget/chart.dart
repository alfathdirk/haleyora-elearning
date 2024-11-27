import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haleyora/constants.dart';

class PieChartWidget extends StatelessWidget {
  final List<Sector> sectors;

  const PieChartWidget(this.sectors, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 120,
        height: 120,
        child: PieChart(PieChartData(
          sections: _chartSections(sectors),
          centerSpaceRadius: 50.0,
          startDegreeOffset: -90,
        )));
  }

  List<PieChartSectionData> _chartSections(List<Sector> sectors) {
    final List<PieChartSectionData> list = [];
    for (var sector in sectors) {
      const double radius = 7.0;
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
  final double? examScores;
  final double? employeeScore;

  const ProgressPieChart({super.key, this.examScores, this.employeeScore});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          // center
          top: 40,
          left: 26,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Skor",
                style: GoogleFonts.lexend(
                  color: greyText,
                  fontWeight: FontWeight.w600,
                  fontSize: 8.sp,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    employeeScore!.toStringAsFixed(2),
                    style: GoogleFonts.lexend(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 10.sp,
                    ),
                  ),
                  Text(
                    "/ ${examScores.toString()}",
                    style: GoogleFonts.lexend(
                      color: greyText,
                      fontWeight: FontWeight.bold,
                      fontSize: 7.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        PieChartWidget([
          Sector(employeeScore! / examScores!, Colors.green),
          Sector(
              1 - (employeeScore! / examScores!).toDouble(), Colors.grey[200]!),
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
