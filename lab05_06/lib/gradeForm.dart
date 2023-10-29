import 'package:flutter/material.dart';
import 'main.dart';
import 'GradesModel.dart';

String id = " ";
String grade = " ";


class GradeForm extends StatefulWidget {
  @override
  _GradeFormState createState() => _GradeFormState();
}

class _GradeFormState extends State<GradeForm> {

  final _formKey = GlobalKey<FormState>();
  bool isSaving = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Grade")),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Row(
              
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Padding(padding: new EdgeInsets.all(10.0)),
                Text('SID: '),

                Flexible(
                  child:TextField(
                    onSubmitted: (text){
                      id = text;
                    },
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
                new Padding(padding: new EdgeInsets.all(10.0)),
                Text('Grade: '),

                Flexible(
                  child:TextField(
                    onSubmitted: (text){
                      grade = text;
                    },
                    decoration: InputDecoration(
                        hintText: 'Enter your Grade'
                    ),
                  ),
                ),

              ],
            ),
          ],
        ),


      ),

      
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          if(_formKey.currentState == null) return;

            if(_formKey.currentState!.validate()){
              setState(() {
                isSaving = true;
              });
              await insertGrade({
                'sid' : int.parse(id),
                'grade' : grade,
              });
              const snackBar = SnackBar(content: Text('Record inserted successfully'));

              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              setState(() {
                isSaving = false;
              });}
         Navigator.pop(context);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.save),
      )
    )
    ;
  }
}

