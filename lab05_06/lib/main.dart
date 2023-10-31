import 'package:flutter/material.dart';

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

  TextEditingController idController = TextEditingController();
  TextEditingController gradeController = TextEditingController();

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
  Container(
  width: 200, // Adjust the width as needed
  child: Align(
  alignment: Alignment.bottomCenter,
  child: ElevatedButton(
  onPressed: _openForm, // Open the form on button click
  child: Text('Add Grade'),
  style: ElevatedButton.styleFrom(primary: Colors.blue),
  ),
  ),
  ),
  ],
  ),
  );
  }
}
