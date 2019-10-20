import 'package:flutter/material.dart';
import 'package:goalmemo/ContentsPage.dart';
import 'package:goalmemo/DBHelper.dart';
import 'package:goalmemo/main.dart';
import 'package:shared_preferences/shared_preferences.dart';


class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {

  String contents;
  int currentDate;
  int date;
  bool isComplete;

  TextEditingController titleController;
  TextEditingController dateController;

  @override
  void initState() {
    isComplete = false;
    currentDate = 0;
    titleController = TextEditingController();
    dateController = TextEditingController();
    super.initState();
  }

  movePage(){
    return Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => MyApp(),
      )
    );
  }
  movePop(){
    return Navigator.of(context).pop();
  }

  DBHelper dbHelper = new DBHelper();


  @override
  Widget build(BuildContext context) {

//    titleField(),
//    dateField(),
//    submitBtn(),
//    cancelBtn()

    return Scaffold(
      appBar: AppBar(
        title: Text("입력"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                width: ,
                child: ,
              )
            ],
          ),
        ),
      ),
    );
  }

  titleField(){
    return Container(
      width: 200,
      height: 100,
      child: TextField(
        controller: titleController,
        onChanged: (v) => contents = v,
      ),
    );
  }
  dateField(){
    return Container(
      width: 200,
      height: 100,
      child: TextField(
        controller: dateController,
        onChanged: (v) => date = int.parse(v),
      ),
    );
  }
  submitBtn(){
    return RaisedButton(
      onPressed: (){
        dbHelper.goalTitle = contents;
        dbHelper.goalDate = date;
        dbHelper.goalIsComplete = isComplete;
        dbHelper.goalCurrentDate = currentDate;
        movePage();
      },
      child: Text("입력"),
    );
  }
  cancelBtn(){
    return RaisedButton(
      onPressed:(){
        dbHelper.clearDB();
        titleController.clear();
        dateController.clear();
      },
      child: Text("db삭제"),
    );
  }
}
