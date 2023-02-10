import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const twentyfiveminutes = 1500;
  int totalSeconds = twentyfiveminutes;
  bool isRunning = false;
  int totalPomodoros = 0;
  late Timer timer;

  void ontick(Timer timer) {
    if (totalSeconds == 0) {
      setState(
        () {
          totalPomodoros = totalPomodoros + 1;
          totalSeconds = twentyfiveminutes;
          isRunning = false;
        },
      );
      timer.cancel();
    } else {
      setState(
        () {
          totalSeconds = totalSeconds - 1;
        },
      );
    }
  }

  void onStartPressed() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      ontick,
    );
    setState(() {
      isRunning = true;
    });
  }

  void onPausesPressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void TimeReset() {
    timer.cancel();
    setState(() {
      totalSeconds = twentyfiveminutes;
      isRunning = false;
    });
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    // list에서 첫번째 요소 들고오는 first

    return duration.toString().split('.').first.substring(2, 7);
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
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Column(
              children: [
                Center(
                  child: Column(
                    children: [
                      IconButton(
                          iconSize: 110,
                          color: Theme.of(context).cardColor,
                          onPressed:
                              isRunning ? onPausesPressed : onStartPressed,
                          icon: Icon(isRunning
                              ? Icons.pause_circle
                              : Icons.play_circle_fill_outlined)),
                      IconButton(
                          iconSize: 110,
                          color: Theme.of(context).cardColor,
                          onPressed: TimeReset,
                          icon: const Icon(Icons.restore_rounded)),
                    ],
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
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Pomodoros',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            color: Color(
                                0xFF232B55), //Theme.of(context).textTheme.headline1!.color,
                          ),
                        ),
                        Text(
                          '$totalPomodoros',
                          style: const TextStyle(
                            fontSize: 60,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF232B55),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
