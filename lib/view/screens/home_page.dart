import 'dart:math';

import 'package:flutter/material.dart';

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

  bool _isAnalog = false;
  bool _isStrap = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
            "${d.hour} : ${d.minute} : ${d.second}_Date: ${d.day}_WeekDay: ${d.weekday}"),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
                currentAccountPicture: Image.network(
                    "https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png"),
                accountName: const Text("Smit_Chitroda"),
                accountEmail: const Text("smitchitroda@gmail.com")),
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
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // AnalogWatch
            Visibility(
              visible: _isAnalog,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  //allPoint
                  ...List.generate(
                      60,
                      (index) => Transform.rotate(
                            angle: index * (pi * 2) / 60,
                            child: Divider(
                              endIndent: index % 5 == 0
                                  ? size.width * 0.88
                                  : size.width * 0.9,
                              thickness: 2,
                              color: index % 5 == 0 ? Colors.red : Colors.grey,
                            ),
                          )),
                  //hourHand
                  Transform.rotate(
                    angle: pi / 2,
                    child: Transform.rotate(
                      angle: d.hour * (pi * 2) / 12,
                      child: Divider(
                        indent: 50,
                        endIndent: size.width * 0.5 - 16,
                        color: Colors.black,
                        thickness: 4,
                      ),
                    ),
                  ),
                  //minuteHand
                  Transform.rotate(
                    angle: pi / 2,
                    child: Transform.rotate(
                      angle: d.minute * (pi * 2) / 60,
                      child: Divider(
                        indent: 30,
                        endIndent: size.width * 0.5 - 16,
                        color: Colors.black,
                        thickness: 2,
                      ),
                    ),
                  ),
                  //secondHand
                  Transform.rotate(
                    angle: pi / 2,
                    child: Transform.rotate(
                      angle: d.second * (pi * 2) / 60,
                      child: Divider(
                        indent: 20,
                        endIndent: size.width * 0.5 - 16,
                        color: Colors.red,
                        thickness: 2,
                      ),
                    ),
                  ),
                ],
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
                      value: d.hour.toDouble(),
                      strokeWidth: 1.7,
                    ),
                  ),
                  // Minutes
                  Transform.scale(
                    scale: 5,
                    child: CircularProgressIndicator(
                      value: d.minute.toDouble(),
                      strokeWidth: 1.3,
                    ),
                  ),
                  // Second
                  Transform.scale(
                    scale: 3,
                    child: CircularProgressIndicator(
                      value: d.second.toDouble(),
                      strokeWidth: 1.3,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
