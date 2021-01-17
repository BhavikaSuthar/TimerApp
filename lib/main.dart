import 'dart:async';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

void main() {
  runApp(TimerApp());
}

class TimerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Timer",
      home: MyTimerApp(),
    );
  }
}

class MyTimerApp extends StatefulWidget {
  @override
  _MyTimerAppState createState() => _MyTimerAppState();
}

class _MyTimerAppState extends State<MyTimerApp> with TickerProviderStateMixin {
  TabController tb;
  int hour = 0;
  int min = 0;
  int sec = 0;
  String timetodisplay = "";
  bool started = true;
  bool stopped = true;
  int timefortimer = 0;
  bool checktimer = true;

  @override
  void initState() {
    tb = TabController(length: 2, vsync: this);
    super.initState();
  }

  void start() {
    setState(() {
      started= false;
      stopped=false;
    });
    timefortimer = ((hour * 3600) + (min * 60) + sec);
    Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        if (timefortimer < 1 || checktimer == false) {
          t.cancel();
          if(timefortimer == 0){
            debugPrint("stopped by Default");
          }
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyTimerApp(),));
        }
        else if(timefortimer < 60) {
          timetodisplay = timefortimer.toString();
          timefortimer = timefortimer - 1;
        }else if (timefortimer < 3600){
          int m = timefortimer ~/ 60;
          int s = timefortimer - (60 * m);
          timetodisplay = m.toString() + ":" + s.toString();
          timefortimer =timefortimer - 1;
        }else{
          int h  = timefortimer ~/ 3600;
          int t = timefortimer - (3600 * h);
          int m = t ~/ 60;
          int s = t - (60 * m);
          timetodisplay = h.toString() + ":" + m.toString() + ":" + s.toString();
          timefortimer = timefortimer -1;
        }
      });

    });
  }

  void stop() {
    setState(() {
      started=true;
      stopped=true;
      checktimer =false;
    });
  }

  Widget timer() {

    return Container(
      color: Colors.blueGrey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        "HH",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                    NumberPicker.integer(
                        initialValue: hour,
                        minValue: 0,
                        maxValue: 23,
                        listViewWidth: 60.0,
                        onChanged: (val) {
                          setState(() {
                            hour = val;
                          });
                        })
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        "MM",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                    NumberPicker.integer(
                        initialValue: min,
                        minValue: 0,
                        maxValue: 23,
                        listViewWidth: 60.0,
                        onChanged: (val) {
                          setState(() {
                            min = val;
                          });
                        })
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        "SS",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                    NumberPicker.integer(
                        initialValue: sec,
                        minValue: 0,
                        maxValue: 23,
                        listViewWidth: 60.0,
                        onChanged: (val) {
                          setState(() {
                            sec = val;
                          });
                        })
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              timetodisplay,
              style: TextStyle(
                fontSize: 40.0,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: RaisedButton(
                    onPressed: started ? start : null,
                    color: Colors.green,
                    padding:
                    EdgeInsets.symmetric(horizontal: 38.0, vertical: 13.0),
                    child: Text(
                      "Start",
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                RaisedButton(
                  onPressed: stopped ? null : stop,
                  color: Colors.red,
                  padding:
                  EdgeInsets.symmetric(horizontal: 38.0, vertical: 13.0),
                  child: Text(
                    "Stop",
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool startispressed = true;
  bool stopispressed = true;
  bool resetispressed = true;
  String stoptimetodisplay = "00:00:00";
  var swatch = Stopwatch();
  final dur = const Duration(seconds: 1);

  void starttimer(){
    Timer(dur, keeprunning);
  }

  void keeprunning(){
    if(swatch.isRunning){
      starttimer();
    }
    setState(() {
      stoptimetodisplay = swatch.elapsed.inHours.toString().padLeft(2, "0") + ":"
          +(swatch.elapsed.inMinutes%60).toString().padLeft(2,"0") + ":"
          +(swatch.elapsed.inSeconds%60).toString().padLeft(2,"0");
    });
  }


  void startstopwatch(){
    setState(() {
      stopispressed = false;
      startispressed = false;
    });
    swatch.start();
    starttimer();
  }
  void stopstopwatch(){
    setState(() {
      stopispressed = true;
      resetispressed= false;
    });
    swatch.stop();
  }
  void resetstopwatch(){
    setState(() {
      startispressed = true;
      resetispressed=true;
    });
    swatch.reset();
    stoptimetodisplay = "00:00:00";
  }

  Widget stopwatch(){
    return Container(
      color: Colors.blueGrey,
      child:  Column(
        children: <Widget>[
          Expanded(
            flex: 6,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                stoptimetodisplay,
                style: TextStyle(
                  fontSize: 50.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              child: Column (
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                    children:<Widget> [
                      RaisedButton(
                        onPressed: stopispressed ? null : stopstopwatch,
                        color: Colors.red,
                        padding: EdgeInsets.symmetric(
                          horizontal: 37.0,
                          vertical: 13.0,
                        ),
                        child: Text(
                          "Stop",
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white
                          ),
                        ),
                      ),
                      RaisedButton(
                        onPressed: resetispressed ? null : resetstopwatch,
                        color: Colors.teal,
                        padding: EdgeInsets.symmetric(
                          horizontal: 37.0,
                          vertical: 13.0,
                        ),
                        child: Text(
                          "Reset",
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white
                          ),
                        ),
                      ),
                    ],
                  ),
                  RaisedButton(
                    onPressed: startispressed ? startstopwatch : null  ,
                    color: Colors.green,
                    padding: EdgeInsets.symmetric(
                      horizontal: 70.0,
                      vertical: 15.0,
                    ),
                    child: Text(
                      "Start",
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text("TimerApp"),
        centerTitle: true,
        bottom: TabBar(
          tabs: <Widget>[
            Text("Timer"),
            Text("StopWatch"),
          ],
          labelStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
          labelPadding: EdgeInsets.only(bottom: 10.0),
          controller: tb,
          unselectedLabelColor: Colors.white60,
        ),
      ),
      body: TabBarView(
        children: <Widget>[
          timer(),
          stopwatch(),
        ],
        controller: tb,
      ),
    );
  }
}
