import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:helworld/MainPage.dart';
import 'package:helworld/InputPage.dart';

void main() => runApp(
  MaterialApp(
    home:CheckPage()
  )
);


class CheckPage extends StatefulWidget {
  @override
  _CheckPageState createState() => _CheckPageState();
}

class _CheckPageState extends State<CheckPage> {
  pageMove(BuildContext context, movePage) async{
    return Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => movePage
        )
    );
  }

  checking(BuildContext context) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    var movePage = (pref.getString("goal") == null && pref.getInt("days") == null)
        ? InputPage()
        : MainPage();
    return Future.delayed(Duration(seconds: 2), () => pageMove(context, movePage));
  }

  @override
  Widget build(BuildContext context) {
    checking(context);

    return Scaffold(
      body: Center(
        child: Text(
            "로딩중"
        ),
      ),
    );
  }
}



