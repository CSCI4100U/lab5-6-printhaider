import 'package:flutter/material.dart';
import 'gradeForm.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';



var database;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  database = openDatabase(
      join(await getDatabasesPath(), 'grades.db'),

    onCreate: (db, version){
      return db.execute(
        'CREATE TABLE grades(sid INTEGER PRIMARY KEY, grade TEXT)',
      );
    },

    version: 1
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Forms and SDLite'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(onPressed: (){}, icon: Icon(Icons.edit),
          
        )],
        title: Text(widget.title),
      ),
      body: Center(
        
        child: ListView.builder
            (
              itemCount: grades.length,
              itemBuilder: (BuildContext context, int index) {
                return new ListTile(
                  title: Text(grades[index].sid!),
                  subtitle: Text(grades[index].grade!),
                );
              }
          ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => GradeForm()));
        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ), 
    );
  }
}

class grClass{
  String? sid;
  String? grade;

  grClass({this.sid, this.grade});
}

List<grClass> grades = [
  grClass(sid: "10000001", grade: "A"),
  grClass(sid: "10000002", grade: "A+"),
  grClass(sid: "10000003", grade: "B"),
  grClass(sid: "10000004", grade: "B+"),
  grClass(sid: "10000005", grade: "A-"),
  grClass(sid: "10000006", grade: "D"),
  grClass(sid: "10000007", grade: "C"),
  grClass(sid: "10000008", grade: "A"),
  grClass(sid: "10000009", grade: "D+"),
  grClass(sid: "10000010", grade: "B-"),
];

void _addGrade(grClass value){
    grades.add(value);
  }
  void _editGrade(){
  }
  void _deleteGrade(){
  }