import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:helworld/NotePage.dart';
import 'package:helworld/MainPage.dart';


class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}
class _InputPageState extends State<InputPage> {

  viewContents(String value) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> contents = [];
    contents.add(value);
    return prefs.setStringList("contents", contents);
  }

  int days;
  String goal;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(
          top: 50.0
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Text(
                  "우리는 하나의 목표를 하나씩. \n테스트 중"
              ),
            ),
            Form(
              child: Column(
                children: <Widget>[
                  RaisedButton(
                    onPressed: () async{
                      print(" 결과 ${goal.toString()} 는 ${days.toString()}일");
                      SharedPreferences pref = await SharedPreferences.getInstance();
                      if(goal != null && days != null){
                        pref.setString("goal",goal);
                        pref.setInt("days",days);
                        pref.setInt("current",1);
                        return Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => MainPage()
                          )
                        );
                      }
                      else{
                        return NotePage(
                          noteContents: "다시 입력해주세요",
                        );
                      }

                    },
                  ),
                  Container(
                    width: 200,
                    alignment: Alignment.center,
                    child: TextField(
                      onChanged: (v){
                        setState(() {
                          goal = v;
                        });
                      },
                      decoration: InputDecoration(
                          icon: Icon(Icons.add),
                          hintText: "하나의 목표"
                      ),
                    ),
                  ),
                  Container(
                    width: 200,
                    alignment: Alignment.center,
                    child: TextField(
                      onChanged: (i){
                        setState(() {
                          days = int.parse(i);
                        });
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          icon: Icon(Icons.add),
                          hintText: "목표 일수"
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
