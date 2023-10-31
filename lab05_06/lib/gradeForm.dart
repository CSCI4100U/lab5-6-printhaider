import 'package:flutter/material.dart';
import 'main.dart';
import 'GradesModel.dart';

class GradeForm extends StatefulWidget {
  @override
  _GradeFormState createState() => _GradeFormState();
}

class _GradeFormState extends State<GradeForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController idController = TextEditingController();
  final TextEditingController gradeController = TextEditingController();
  bool isSaving = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Grade")),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(10.0)),
                  Text('SID: '),
                  Flexible(
                    child: TextField(
                      controller: idController,
                      decoration: InputDecoration(
                        hintText: 'Enter your ID',
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(10.0)),
                  Text('Grade: '),
                  Flexible(
                    child: TextField(
                      controller: gradeController,
                      decoration: InputDecoration(
                        hintText: 'Enter your Grade',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            setState(() {
              isSaving = true;
            });

            await insertGrade({
              'sid': int.parse(idController.text),
              'grade': gradeController.text,
            });

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Record inserted successfully')),
            );

            setState(() {
              isSaving = false;
            });

            Navigator.pop(context); // Navigate back to the list screen.
          }
        },
        tooltip: 'Save',
        child: Icon(Icons.save),
      ),
    );
  }
}
