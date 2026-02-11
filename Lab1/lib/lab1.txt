import 'dart:async';

import 'package:flutter/material.dart';
void main() {
  runApp(const MyApp());
}


ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
    backgroundColor:Colors.blue[700],
    foregroundColor: Colors.white,
    textStyle: TextStyle(fontSize: 16),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(1))
);

TextStyle textStyle = TextStyle(fontSize: 40, );


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
      theme: ThemeData(
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: elevatedButtonStyle,
          )
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Lab N1", style: TextStyle(color: Colors.white,
              backgroundColor: Colors.blue),),
        ),
        body: Center(
          child: MyScreen()
        ),
      ),
    );
  }
}

class MyScreen extends StatefulWidget {
  const MyScreen({super.key});

  @override
  State<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  bool _btnPressed = false;
  Icon icon = Icon(Icons.play_circle_outline, color: Colors.blue, size: 60);
  int time = 0;
  Timer? timer;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height:300),
          Text("Timer:", style: textStyle),
          Text(time.toString(), style: textStyle),
          SizedBox(height:250),
          IconButton(
            onPressed:(){
              _btnPressed = !_btnPressed;
              setState(() {
                icon = _btnPressed ?
                Icon(Icons.stop_circle, color: Colors.red, size: 60):
                Icon(Icons.play_circle_outline, color: Colors.blue, size: 60);
                if(_btnPressed){
                  startTimer();
                }else{
                  stopTimer();
                }
              });
            }
            ,
            icon: icon
        )]
    );
  }
  void startTimer(){
    time = 0;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        time++;
      });
    });
  }
  void stopTimer(){
    if (timer != null) {
      timer!.cancel();
    }
  }
}
