import 'package:flutter/material.dart';
import 'package:goalmemo/ContentsPage.dart';
import 'package:goalmemo/DBHelper.dart';
import 'package:goalmemo/InputPage.dart';

void main()  async{

  Future getcureent() {
    DBHelper dbHelper = new DBHelper();
    return dbHelper.goalCurrentDate ?? 0;
  }

  var initcurrentr = await Future.wait([
    getcureent()
  ]);

  runApp(
    MaterialApp(
      home:MyApp(
        currentDate: initcurrentr[0],
      )
    )
  );
}

class MyApp extends StatelessWidget {
  DBHelper dbHelper = new DBHelper();

  int currentDate;
  MyApp({this.currentDate});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: FutureBuilder(
            future: dbHelper.goalTitle,
            builder: (context, snap){
              if(!snap.hasData){
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Text("아직 목표를 입력하지 않았습니다 :)"),
                    ),
                    RaisedButton(
                      child: Text("입력하러가기"),
                      onPressed: (){
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => InputPage()
                            )
                        );
                      },
                    )
                  ],
                );
              }
              else {
                return ContentsPage(
                  currentDate: currentDate
                );
              }
            },
          )
        ),
      )
    );
  }
}
