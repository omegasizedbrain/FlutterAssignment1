import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    backgroundColor: Color(0xFF147CD3),
    foregroundColor: Colors.white,
    fixedSize: Size(400, 2),
    shape: LinearBorder());


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter 4',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        elevatedButtonTheme: ElevatedButtonThemeData(style: buttonStyle)
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  Timer? timer;
  int displayedNumber = 0;
  static var stats = <int>[0,0,0,0,0,0,0,0,0];

  @override
  void initState(){
    super.initState();
    _controller = AnimationController(duration: Duration(milliseconds: 5000), vsync: this);
  }
  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xFF147CD3),
          leading: Icon(Icons.home_outlined, color: Colors.white),
          title: Text("Random Number Generator", style: TextStyle(color: Colors.white),)
      ),
      backgroundColor: Color(0xFF2196F3),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            RotationTransition(
              turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
              child: Text(displayedNumber.toString(), style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                SizedBox(height: 300, width: 30),
                ElevatedButton(onPressed: (){_controller.forward(); startTimer();}, child: Text("Generate")),
                ElevatedButton(onPressed: ()=>Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => StatScreen())
                ), child: Text("View Statistics")),
                SizedBox(height: 20, width: 30),
              ],
            )
          ],
        ),
      ),
    );
  }
  void startTimer(){
    timer = Timer.periodic(Duration(milliseconds: 200), (timer) {
      setState(() {
        displayedNumber = Random().nextInt(9)+1;
        if(_controller.isCompleted){
          stopTimer();
        }
      });
    });
  }
  void stopTimer(){
    if (timer != null) {
      timer!.cancel();
      _controller.reset();
      stats[displayedNumber-1]+=1;
    }
  }
  static void resetList(){
    stats = <int>[0,0,0,0,0,0,0,0,0];
  }
}

class StatScreen extends StatefulWidget {
  const StatScreen({super.key});
  @override
  State<StatScreen> createState() => _StatScreenState();
}


class _StatScreenState extends State<StatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xFF147CD3),
          leading: IconButton(onPressed: ()=>Navigator.pop(context), icon: Icon(Icons.arrow_back_sharp, color: Colors.white,)),
          title: Text("Statistics", style: TextStyle(color: Colors.white),)
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            for(var (i, item) in _MyHomePageState.stats.indexed) Text("Number ${i+1} \t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t$item\n", style: TextStyle(color: Colors.white, fontSize: 18),),
            SizedBox(height: 50, width: 30),
            ElevatedButton(
                onPressed: (){
                  setState(() {
                    _MyHomePageState.resetList();
                  });
                }, child: Text("Reset")
            ),
            ElevatedButton(
                onPressed: (){
                  Navigator.pop(context);
                }, child: Text("Back to Home")
            ),
            SizedBox(height: 20, width: 30),
          ],
        )

      ),
        backgroundColor: Color(0xFF2196F3)
    );
  }
}
