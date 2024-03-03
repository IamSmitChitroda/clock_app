import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_analog_clock/flutter_analog_clock.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime d = DateTime.now();

  void startClock() {
    Future.delayed(const Duration(seconds: 1), () {
      d = DateTime.now();
      setState(() {});
      startClock();
    });
  }

  @override
  void initState() {
    super.initState();
    startClock();
  }

  bool _isAnalog = true;
  bool _isStrap = false;
  bool _isImage = false;
  bool _isDigital = false;
  bool _isStopwatch = false;

  int sec = 0;
  int min = 0;
  int hou = 0;
  String sSec = "00";
  String sMin = "00";
  String sHou = "00";
  Timer? timer;
  bool started = false;
  List laps = [];

  void start() {
    started = true;

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      sec++;
      if (sec > 59) {
        if (min > 59) {
          hou++;
          min = 0;
        } else {
          min++;
          sec = 0;
        }
      }
      setState(() {
        min = min;
        hou = hou;

        sSec = (sec >= 10) ? "$sec" : "0$sec";
        sHou = (sec >= 10) ? "$hou" : "0$hou";
        sMin = (min >= 10) ? "$min" : "0$min";
      });
    });
  }

  void resetStopWatch() {
    timer!.cancel();
    setState(() {
      started = false;
      sec = 0;
      min = 0;
      hou = 0;

      sSec = "00";
      sMin = "00";
      sHou = "00";
    });
  }

  List imageUrl = [
    "https://i.pinimg.com/564x/cc/7a/08/cc7a0805fd91dd8c5ad6457f861b7d66.jpg",
    "https://i.pinimg.com/736x/69/6a/99/696a9941174f4fdf94b5733193e85a16.jpg",
    "https://i.pinimg.com/236x/49/a3/83/49a3839928419e360a0f7b6f91699ef5.jpg",
    "https://i.pinimg.com/236x/ff/67/80/ff6780d95db1821b44f64003bcb4c50b.jpg",
    "https://i.pinimg.com/236x/74/9e/58/749e583b1f9648d693c1941670c6e82f.jpg",
    "https://i.pinimg.com/236x/68/d0/75/68d07525cca9adab599d3c03c58ffd40.jpg",
    "https://i.pinimg.com/236x/40/67/aa/4067aa9e6340a8f1acbaf6de5e8491b8.jpg",
    "https://i.pinimg.com/236x/84/ab/f3/84abf3609b65fe76ff977aeaf655c126.jpg",
    "https://i.pinimg.com/564x/87/ed/12/87ed1246e7a498f051e7d81b7670fa77.jpg",
    "https://i.pinimg.com/564x/13/83/9d/13839d0df89247a95bf5b66efea41e6e.jpg",
  ];

  String bgImage = "";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        foregroundColor: Colors.white60,
        title: const Text("Clock app"),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
                currentAccountPicture: Image.network(
                    "https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png"),
                accountName: const Text("Smit_Chitroda"),
                accountEmail: const Text("smitchitroda@gmail.com")),
            // AnalogWatch
            Container(
              margin: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Analog clock"),
                  Switch(
                    value: _isAnalog,
                    onChanged: (val) => _isAnalog = !_isAnalog,
                  ),
                ],
              ),
            ),
            // DigitalWatch
            Container(
              margin: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Digital clock"),
                  Switch(
                    value: _isDigital,
                    onChanged: (val) => _isDigital = !_isDigital,
                  ),
                ],
              ),
            ),
            // StopWatch
            Container(
              margin: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Stop Watch"),
                  Switch(
                    value: _isStopwatch,
                    onChanged: (val) => _isStopwatch = !_isStopwatch,
                  ),
                ],
              ),
            ),
            // StrapWatch
            Container(
              margin: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Strap clock"),
                  Switch(
                    value: _isStrap,
                    onChanged: (val) => _isStrap = !_isStrap,
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Image"),
                  Switch(
                    value: _isImage,
                    onChanged: (val) => _isImage = !_isImage,
                  ),
                ],
              ),
            ),
            Visibility(
              visible: _isImage,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: imageUrl
                      .map(
                        (e) => GestureDetector(
                          onTap: () {
                            bgImage = e;
                            setState(() {});
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                                left: 10, right: 5, bottom: 10),
                            height: size.height * 0.15,
                            width: size.width * 0.25,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(5, 5),
                                  blurRadius: 7,
                                ),
                              ],
                              image: DecorationImage(
                                  image: NetworkImage(e), fit: BoxFit.fill),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: _isImage
                  ? NetworkImage(bgImage)
                  : const NetworkImage(
                      "https://i.pinimg.com/1200x/84/2a/d6/842ad68b315b0f586c30b465221da609.jpg",
                    ),
              fit: BoxFit.fill),
        ),
        padding: const EdgeInsets.all(16),
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // AnalogWatch
            Visibility(
              visible: _isAnalog,
              child: const Stack(
                alignment: Alignment.center,
                children: [
                  AnalogClock(
                    markingRadiusFactor: 0,
                    hourNumberRadiusFactor: 1,
                    hourHandLengthFactor: 0.85,
                    minuteHandLengthFactor: 0.9,
                    secondHandLengthFactor: 0.8,
                  ),
                ],
              ),
            ),
            // Digital
            Visibility(
              visible: _isDigital,
              child: Transform.scale(
                scale: 5,
                child: DigitalClock(
                  is24HourTimeFormat: true,
                  secondDigitTextStyle:
                      const TextStyle(fontSize: 10, color: Colors.red),
                  hourMinuteDigitTextStyle:
                      const TextStyle(fontSize: 14, color: Colors.red),
                ),
              ),
            ),
            // StrapWatch
            Visibility(
              visible: _isStrap,
              child: Stack(
                children: [
                  // Hour
                  Transform.scale(
                    scale: 7,
                    child: CircularProgressIndicator(
                      value: (d.hour / 24).toDouble(),
                      strokeWidth: 1.7,
                    ),
                  ),
                  // Minutes
                  Transform.scale(
                    scale: 5,
                    child: CircularProgressIndicator(
                      value: d.minute / 60,
                      strokeWidth: 1.3,
                    ),
                  ),
                  // Second
                  Transform.scale(
                    scale: 3,
                    child: CircularProgressIndicator(
                      value: d.second / 60,
                      strokeWidth: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: _isStopwatch,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "$sHou : $sMin : $sSec",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 56,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      start();
                    },
                    child: Text(started ? "Started" : "Start"),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        resetStopWatch();
                      },
                      child: const Text("reset"))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
