import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  getGoal() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("goal");
  }
  getDays() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    var days = pref.getInt("days");
    var current = pref.getInt("current");
    return [days, current];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            FutureBuilder(
              future: getGoal(),
              builder: (context, snapshot){
                if(!snapshot.hasData){
                  return CircularProgressIndicator();
                }
                else {
                  return Text(snapshot.data.toString());
                }
              },
            ),
            FutureBuilder(
              future: getDays(),
              builder: (context, snapshot){
                if(!snapshot.hasData){
                  return CircularProgressIndicator();
                }
                else {
                  return Container(
                    width: 300,
                    height: 50,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top:0,
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            color: Colors.red,
                            child: Text("목표치"),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          bottom: 0,
                          left: 0,
                          right: 100,
                          child: Container(
                            color: Colors.white,
                            child: Text(snapshot.data[0].toString()),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          bottom: 0,
                          left: 0,
                          right: 100,
                          child: Container(
                            color: Colors.white,
                            child: Text(snapshot.data[1].toString()),
                          ),
                        ),

                      ],
                    ),
                  );
                }
              },
            ),

          ],
        ),
      ),
    );
  }
}
