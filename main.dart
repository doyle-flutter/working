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
      appBar: AppBar(
        title: Text("메인"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              FutureBuilder(
                future: dbHelper.goalTitle,
                builder: (context, snap){
                  if(!snap.hasData){
                    return RaisedButton(
                      child: Text("입력하러가기"),
                      onPressed: (){
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InputPage()
                          )
                        );
                      },
                    );

                  }
                  else {
                    return ContentsPage();
                  }
                },
              )
            ],
          ),
        ),
      )
    );
  }
}
