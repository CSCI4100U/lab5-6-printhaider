import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'main.dart'; // Import to access the Grade class

class GradeDistributionScreen extends StatelessWidget {
  final List<Grade> grades;

  GradeDistributionScreen({Key? key, required this.grades}) : super(key: key);

  double _gradeToPoint(String grade) {
    switch (grade) {
      case 'A+': return 4.3;
      case 'A':  return 4.0;
      case 'A-': return 3.7;
      case 'B+': return 3.3;
      case 'B':  return 3.0;
      case 'B-': return 2.7;
      case 'C+': return 2.3;
      case 'C':  return 2.0;
      case 'C-': return 1.7;
      case 'D+': return 1.3;
      case 'D':  return 1.0;
      case 'D-': return 0.7;
      case 'F':  return 0.0;
      default:   return 0.0; // Default for unrecognized grades
    }
  }

  List<ScatterSpot> _getScatterSpots() {
    return grades.asMap().entries.map((entry) {
      int index = entry.key; // Sequential index of the grade in the list
      Grade grade = entry.value;
      double x = index.toDouble(); // Use sequential index as x value
      double y = _gradeToPoint(grade.grade); // Convert grade to a numeric value for y value
      return ScatterSpot(x, y);
    }).toList();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Grade Distribution"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ScatterChart(
          ScatterChartData(
            scatterSpots: _getScatterSpots(),
            // Additional chart configuration goes here
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context); // Exit the scatter plot screen
        },
        child: Icon(Icons.exit_to_app),
      ),
    );
  }
}
