import 'dart:async';

import 'package:flag/provider/country_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:vibration/vibration.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  var score = 0;
  double opacityLevel = 1;

  @override
  Widget build(BuildContext context) {
    print('build');
    final countryProvider = Provider.of<CountryProvider>(context,listen:false);
    return Scaffold(
      backgroundColor: Colors.pink[700],
      body: Stack(children: [
        Container(
          height: 400.h,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.blue[900],
              borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(70),
                      bottomRight: Radius.circular(70))
                  .r),
          child: Padding(
            padding: const EdgeInsets.only(left: 60,top: 100,right: 60).r,
            child: Text(
              'Guess the flag',
              style: TextStyle(
            color: Colors.white,
            fontSize: 32.sp,
            fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top:150, left: 20, right: 20).r,
              child: Container(
                height: 410.h,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(20).w,
                ),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5).w,
                        child: Text(
                          'Tap the flag of',
                          style:
                              TextStyle(color: Colors.grey[700], fontSize: 15.sp),
                        ),
                      ),
                      Consumer<CountryProvider>(
                        builder: (context,value,child) {
                          return Text(
                            countryList[value.correctAnswer],
                            style: TextStyle(
                                fontSize: 40.sp, fontWeight: FontWeight.w500),
                          );
                        },
                      ),
                      Consumer<CountryProvider>(
                        builder: (context,value,child) {
                          return  GestureDetector(
                              onTap: () {
                                // setState(() {
                                //   opacityLevel = opacityLevel == 0 ? 1 : 0;
                                //   Timer(Duration(milliseconds: 800), () {
                                //     setState(() {
                                //       opacityLevel = opacityLevel == 0 ? 1 : 0;
                                //     });
                                //   });
                                // });
                                if (value.correctAnswer == 0) {
                                  score++;
                                  print('correct');
                                  if (score == 7) {
                                    _finalDialog(context);
                                  }
                                  value.changeQuestion();
                                } else {
                                  Vibration.vibrate();
                                  _showDialog(context, 0);
                                }
                              },
                            child: AnimatedOpacity(
                              opacity: opacityLevel,
                              duration: const Duration(milliseconds: 500),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(80).w,
                                  child: Image.asset(
                                  'assets/images/${countryList[0]}.png',
                                  height: 110.h,
                                  width: 200.w,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      Consumer<CountryProvider>(
                        builder: (context,value,child) {
                          return GestureDetector(
                            onTap: () {
                              if (value.correctAnswer == 1) {
                                score++;
                                print('correct');
                                if (score == 7) {
                                  _finalDialog(context);
                                }
                                value.changeQuestion();
                              } else {
                                Vibration.vibrate();
                                _showDialog(context, 1);
                              }
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(80).w,
                              child: Image.asset(
                                'assets/images/${countryList[1]}.png',
                                height: 110.h,
                                width: 200.w,
                              ),
                            ),
                          );
                        },
                      ),
                      Consumer<CountryProvider>(
                        builder: (context,value,child) {
                          return GestureDetector(
                            onTap: () {
                              if (value.correctAnswer == 2) {
                                score++;
                                print('correct');
                                if (score == 7) {
                                  _finalDialog(context);
                                }
                                value.changeQuestion();
                              } else {
                                Vibration.vibrate();
                                _showDialog(context, 2);
                              }
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(80),
                              child: Image.asset(
                                'assets/images/${countryList[2]}.png',
                                height: 110.h,
                                width: 200.w,
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20).r,
              child: Consumer<CountryProvider>(
                builder: (context,value,child) {
                  return Text(
                    'Score: $score',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w700),
                  );
                },
              ),
            ),
          ],
        ),
      ]),
    );
  }

  _showDialog(BuildContext context, int index) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Column(
              children: <Widget>[
                Text("Wrong! That's a flag of ${countryList[index]}"),
              ],
            ),
            content: Text("Your Score is $score"),
            actions: <Widget>[
              Consumer<CountryProvider>(
                builder: (context,value,child) {
                  return CupertinoDialogAction(
                    child: const Text("Continue"),
                    onPressed: () {
                      Navigator.of(context).pop();
                        value.changeQuestion();
                    },
                  );
                },
              ),
            ],
          );
        });
  }

  _finalDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Column(
              children: const <Widget>[
                Text("Final Score"),
              ],
            ),
            content: Text("Your Score is $score"),
            actions: <Widget>[
              Consumer<CountryProvider>(
                builder: (context,value,child) {
                  return CupertinoDialogAction(
                    child: const Text("Restart"),
                    onPressed: () {
                      Navigator.of(context).pop();
                        score = 0;
                        value.changeQuestion();
                    },
                  );
                },
              ),
            ],
          );
        });
  }
}
