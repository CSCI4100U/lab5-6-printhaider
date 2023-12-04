import 'package:flutter/material.dart';
import 'grade_distribution_screen.dart'; // Import the new screen

void main() {
  runApp(MyApp());
}

class Grade {
  int sid;
  String grade;

  Grade(this.sid, this.grade);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grade List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Grade List'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Grade> grades = [Grade(1, 'A'), Grade(2, 'B'), Grade(3, 'C')];
  bool isSortedAscending = true;

  TextEditingController idController = TextEditingController();
  TextEditingController gradeController = TextEditingController();

  String _calculateClassAverage() {
    double total = 0;
    for (var grade in grades) {
      total += _gradeToPoint(grade.grade);
    }
    double avg = grades.isNotEmpty ? total / grades.length : 0;
    return _pointToGrade(avg);
  }

  double _gradeToPoint(String grade) {
    switch (grade) {
      case 'A+': return 4.3;
      case 'A': return 4.0;
      case 'A-': return 3.7;
    // Add cases for B+, B, B-, C+, etc.
      default: return 0;
    }
  }
  String _pointToGrade(double point) {
    // Example grading scale; adjust as per your system
    if (point >= 4.0) return 'A';
    if (point >= 3.7) return 'A-';
    if (point >= 3.3) return 'B+';
    if (point >= 3.0) return 'B';
    if (point >= 2.7) return 'B-';
    if (point >= 2.3) return 'C+';
    if (point >= 2.0) return 'C';
    if (point >= 1.7) return 'C-';
    if (point >= 1.3) return 'D+';
    if (point >= 1.0) return 'D';
    return 'F'; // Default for points below 1.0
  }

  // Method to edit a grade
  _editGrade(int index) {
    // Display a dialog for editing the grade
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newGrade = grades[index].grade;

        return AlertDialog(
          title: Text('Edit Grade'),
          content: TextField(
            controller: TextEditingController(text: newGrade),
            onChanged: (value) {
              newGrade = value;
            },
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Save'),
              onPressed: () {
                setState(() {
                  grades[index].grade = newGrade;
                });
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Method to delete a grade
  _deleteGrade(int index) {
    // Display a confirmation dialog for deleting the grade
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Grade'),
          content: Text('Are you sure you want to delete this grade?'),
          actions: <Widget>[
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                setState(() {
                  grades.removeAt(index);
                });
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Method to open the form for entering a new grade
  _openForm() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Grade'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: idController,
                decoration: InputDecoration(hintText: 'Enter your SID'),
              ),
              TextField(
                controller: gradeController,
                decoration: InputDecoration(hintText: 'Enter your Grade'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Add'),
              onPressed: () {
                setState(() {
                  grades.add(Grade(int.parse(idController.text), gradeController.text));
                  idController.clear();
                  gradeController.clear();
                });
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  void _sortGrades() {
    grades.sort((a, b) => isSortedAscending
        ? _gradeToPoint(a.grade).compareTo(_gradeToPoint(b.grade))
        : _gradeToPoint(b.grade).compareTo(_gradeToPoint(a.grade)));
    isSortedAscending = !isSortedAscending;
  }
  @override
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: grades.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(grades[index].sid.toString()),
                  subtitle: Text(grades[index].grade),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => _editGrade(index),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deleteGrade(index),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _openForm();
                    });
                  },
                  child: Text('Add Grade'),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Class Average: ${_calculateClassAverage()}',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _sortGrades();
                        });
                      },
                      child: Text(isSortedAscending ? 'Sort: High to Low' : 'Sort: Low to High'),
                    ),
                    SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => GradeDistributionScreen(grades: grades),
                        ));
                       },
                      child: Text('Show Grade Distribution'),
                     ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
