import 'package:flutter/material.dart';
import 'package:goalmemo/DBHelper.dart';
import 'package:goalmemo/InputPage.dart';

class ContentsPage extends StatefulWidget {
  @override
  _ContentsPageState createState() => _ContentsPageState();
}

class _ContentsPageState extends State<ContentsPage> {

  int currentDay;
  int goalDay;



  @override
  Widget build(BuildContext context) {

    DBHelper dbHelper = new DBHelper();

    return Container(
          margin: EdgeInsets.only(top: 100),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 60,
                    height: 100,
                    child: FutureBuilder(
                      future: dbHelper.goalTitle,
                      builder: (context, snapshot){
                        if(snapshot.hasData){
                          return Text(snapshot.data.toString());
                        }
                        else{
                          return Text("널ㄹ");
                        }
                      },
                    ),
                  ),
                  Container(
                    width: 60,
                    height: 100,
                    child: FutureBuilder(
                      future: dbHelper.goalDate,
                      builder: (context, snapshot){
                        if(snapshot.hasData){
                          goalDay = snapshot.data;
                          return Text(snapshot.data.toString());
                        }
                        else{
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                  ),
                  Container(
                    width: 60,
                    height: 100,
                    child: FutureBuilder(
                      future: dbHelper.goalIsComplete,
                      builder: (context, snapshot){
                        if(snapshot.hasData){
                          return Text(snapshot.data.toString());
                        }
                        else{
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                  ),
                  Container(
                    width: 60,
                    height: 100,
                    child: FutureBuilder(
                      future: dbHelper.goalCurrentDate,
                      builder: (context, snapshot){
                        if(snapshot.hasData){
                          return Text(snapshot.data.toString());
                        }
                        else{
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                  ),
                  FutureBuilder(
                    future: dbHelper.goalCurrentDate,
                    builder: (context, snapshot){
                      if(snapshot.hasData){
                        if((goalDay == currentDay)){
                          return Text("끝");
                        }
                        else{
                          return RaisedButton(
                            child: Text("업"),
                            onPressed: (){
                              setState(() {
                                int ups = snapshot.data + 1;
                                currentDay = ups;
                                dbHelper.goalCurrentDate = ups;
                              });
                            },
                          );
                        }
                      }
                      else{
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                ],
              ),
              RaisedButton(
                onPressed: (){
                  currentDay = 0;
                  dbHelper.clearDB();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => InputPage()
                    )
                  );
                },
              )
            ],
          ),
        );
  }
}
