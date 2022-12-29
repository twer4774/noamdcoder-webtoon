import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const twentiyFiveMiniutes = 1500;
  int totalSeconds = twentiyFiveMiniutes;
  bool isRunning = false;
  int totalPomodoros = 0;
  late Timer timer;

  void onTick(Timer timer){
    if(totalSeconds == 0){
      setState(() {
        totalPomodoros = totalPomodoros + 1;
        isRunning = false;
        totalSeconds = twentiyFiveMiniutes;
      });
      timer.cancel();
    } else {
      setState(() {
        totalSeconds = totalSeconds - 1;
      });
    }
  }

  void onStartPressed(){
    setState(() {
      isRunning = true;
    });

    timer = Timer.periodic(Duration(seconds: 1), onTick );
  }

  void onPausePressed(){
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void onResetPressed(){
    setState(() {
      isRunning = false;
      totalSeconds = twentiyFiveMiniutes;
    });
    timer.cancel();
  }

  String format(int seconds){
    var duration = Duration(seconds: seconds);
    return duration.toString().split((".")).first.substring(2, 7);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Column(
          children: [
            Flexible(
              flex: 1,
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Text(
                  format(totalSeconds),
                  style: TextStyle(
                    color: Theme.of(context).cardColor,
                    fontSize: 89,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 3,
              child: Row(
                children: [
                  Center(
                    child: IconButton(
                      onPressed: onResetPressed,
                      iconSize: 120,
                      color: Theme.of(context).cardColor,
                      icon: Icon(Icons.stop_circle_outlined),
                    ),
                  ),
                  Center(
                    child: IconButton(
                      onPressed: isRunning ? onPausePressed : onStartPressed,
                      iconSize: 120,
                      color: Theme.of(context).cardColor,
                      icon: Icon(isRunning ? Icons.pause_circle_outline : Icons.play_circle_outlined),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(50)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Pomodoros',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color:
                                  Theme.of(context).textTheme.headline1!.color,
                            ),
                          ),
                          Text('$totalPomodoros',
                            style: TextStyle(
                              fontSize: 60,
                              fontWeight: FontWeight.w600,
                              color:
                              Theme.of(context).textTheme.headline1!.color,
                            ),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
