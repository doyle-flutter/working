import 'package:flutter/material.dart';

class NotePage extends StatelessWidget {
  String noteContents;
  NotePage({this.noteContents});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(" 에러 : ${noteContents.toString()}"),
      ),
    );
  }
}
