import 'package:flutter/material.dart';
import 'package:goalmemo/ContentsPage.dart';
import 'package:goalmemo/DBHelper.dart';
import 'package:goalmemo/InputPage.dart';

void main()  async{
  runApp(
    MaterialApp(
      home:MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  DBHelper dbHelper = new DBHelper();

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
                return ContentsPage();
              }
            },
          )
        ),
      )
    );
  }
}
