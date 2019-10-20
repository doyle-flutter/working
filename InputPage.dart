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

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "하나의 목표",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold
          ),
        ),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                color: Colors.blueAccent,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                margin: EdgeInsets.only(
                  top: 10.0,
                  bottom: 10.0
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height:60,
                      margin: EdgeInsets.only(
                        right: 10.0
                      ),
                      child: Text(
                        "목표 : ",
                        style: TextStyle(
                            fontSize: 24.0
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      height: 80,
                      child: titleField(),
                    )
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                margin: EdgeInsets.only(
                    top: 10.0,
                    bottom: 10.0
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height:60,
                      margin: EdgeInsets.only(
                          right: 10.0
                      ),
                      child: Text(
                        "회차 : ",
                        style: TextStyle(
                          fontSize: 24.0
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      height: 80,
                      child: dateField(),
                    )
                  ],
                ),
              ),
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    submitBtn(),
                    cancelBtn(),
                  ],
                ),
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
      color: Colors.blue[400],
      child: Text(
        "입력",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18.0
        ),
      ),
    );
  }
  cancelBtn(){
    return RaisedButton(
      onPressed:(){
        dbHelper.clearDB();
        titleController.clear();
        dateController.clear();
      },
      child: Text(
        "취소",
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18.0
        ),
      ),
    );
  }
}
