import 'package:flutter/material.dart';
import 'package:goalmemo/DBHelper.dart';
import 'package:goalmemo/InputPage.dart';
import 'package:firebase_admob/firebase_admob.dart';


//ca-app-pub-3097190294747532/9413119693
//<meta-data
//android:name="com.google.android.gms.ads.APPLICATION_ID"
//android:value="ADS ID"/>

class ContentsPage extends StatefulWidget {
  int currentDate;
  ContentsPage({this.currentDate});

  @override
  _ContentsPageState createState() => _ContentsPageState();
}

class _ContentsPageState extends State<ContentsPage> {

  int currentDay;
  int goalDay;

  increaseCurrentDate({snapshot, dbHelper}){
    setState(() {
      int ups = snapshot.data + 1;
      currentDay = ups;
      dbHelper.goalCurrentDate = ups;
    });
  }


  MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>['flutterio', 'beautiful apps'],
    contentUrl: 'https://flutter.io',
    childDirected: false,
    testDevices: <String>[], // Android emulators are considered test devices
  );




  @override
  void initState(){
    currentDay = widget.currentDate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    DBHelper dbHelper = new DBHelper();

    InterstitialAd myInterstitial = InterstitialAd(
      adUnitId: InterstitialAd.testAdUnitId,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("InterstitialAd event is $event");
      },
    );
    BannerAd myBanner = BannerAd(
      adUnitId: BannerAd.testAdUnitId,
      size: AdSize.smartBanner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd event is $event");
      },
    );
    myBanner
      ..load()
      ..show(anchorType: AnchorType.bottom,);

    return Container(
      margin: EdgeInsets.only(top: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(
              top: 20.0,
              left: 30.0,
              right: 30.0,
              bottom: 10.0
            ),
            child: Text(
              "목표",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 35.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(50.0),
                bottomLeft: Radius.circular(50.0),
              )
            ),
            margin: EdgeInsets.only(
              left: 30.0,
              right: 30.0
            ),
            height: 80,
            alignment: Alignment.center,
            child: FutureBuilder(
              future: dbHelper.goalTitle,
              builder: (context, snapshot){
                if(snapshot.hasData){
                  return Text(
                    snapshot.data.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold
                    ),
                  );
                }
                else{
                  return CircularProgressIndicator();
                }
              },
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 100,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width/10,
                  alignment: Alignment.center,
                  child: FutureBuilder(
                    future: dbHelper.goalCurrentDate,
                    builder: (context, snapshot){
                      if(snapshot.hasData){
                        return Text(
                          snapshot.data.toString(),
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold
                          ),
                        );
                      }
                      else{
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width/10,
                  alignment: Alignment.center,
                  child: Text(
                    "/",
                    style: TextStyle(
                      fontSize: 30.0,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width/10,
                  alignment: Alignment.center,
                  child: FutureBuilder(
                    future: dbHelper.goalDate,
                    builder: (context, snapshot){
                      if(snapshot.hasData){
                        goalDay = snapshot.data;
                        return Text(
                          snapshot.data.toString(),
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold
                          ),
                        );
                      }
                      else{
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: 100,
            child: FutureBuilder(
              future: dbHelper.goalCurrentDate,
              builder: (context, snapshot){
                if(snapshot.hasData){
                  if((goalDay == currentDay)){
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: Text(
                        "완료! 새로운 목표를 작성해 주세요 :) ",
                        style: TextStyle(
                          fontSize:24.0
                        ),
                      ),
                    );
                  }
                  else{
                    return RaisedButton(
                      onPressed: () => increaseCurrentDate(
                          dbHelper: dbHelper,
                          snapshot: snapshot
                      ),
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.blueAccent,
                        size: 30.0,
                      ),
                    );
                  }
                }
                else{
                  return CircularProgressIndicator();
                }
              },
            ),
          ),
          Column(
            children: <Widget>[
              RaisedButton(
                onPressed: (){
                  currentDay = 0;
                  dbHelper.clearDB();
                  myInterstitial
                    ..load()
                    ..show(
                      anchorType: AnchorType.bottom,
                      anchorOffset: 0.0,
                      horizontalCenterOffset: 0.0,
                      );
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) => InputPage()
                      )
                  );
                },
                color: Colors.red[200],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
