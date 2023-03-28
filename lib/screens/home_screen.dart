import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var element = 'Germany';
  var correctAnswer = 1;
  var score = 0;
  List<String> countryList = [
    'Estonia',
    'France',
    'Germany',
    'Ireland',
    'Italy',
    'Monaco',
    'Nigeria',
    'Poland',
    'Russia',
    'Spain',
    'UK',
    'US'
  ];

  void changeQuestion() {
    //TO get three flag including correct flag with different Index
    Random random = new Random();
    int min = 0, max = 3;
    correctAnswer = (min + random.nextInt(max - min));
    print(correctAnswer);

    //for three item shuffled list
    countryList.shuffle();
    // Iterable<String> shuffledList = countryList.take(3);
    print(countryList.take(3));

    //for question item
    element = countryList.elementAt(0);
  }

  @override
  Widget build(BuildContext context) {
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
                      Text(
                        countryList[correctAnswer],
                        style: TextStyle(
                            fontSize: 40.sp, fontWeight: FontWeight.w500),
                      ),
                      GestureDetector(
                        onTap: () => setState(() {
                          if (correctAnswer == 0) {
                            score++;
                            print('correct');
                            if (score == 7) {
                              _finalDialog(context);
                            }
                            changeQuestion();
                          } else {
                            _showDialog(context, 0);
                          }
                        }),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(80).w,
                          child: Image.asset(
                            'assets/images/${countryList[0]}.png',
                            height: 110.h,
                            width: 200.w,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => setState(() {
                          if (correctAnswer == 1) {
                            score++;
                            print('correct');
                            if (score == 7) {
                              _finalDialog(context);
                            }
                            changeQuestion();
                          } else {
                            _showDialog(context, 1);
                          }
                        }),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(80).w,
                          child: Image.asset(
                            'assets/images/${countryList[1]}.png',
                            height: 110.h,
                            width: 200.w,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => setState(() {
                          if (correctAnswer == 2) {
                            score++;
                            print('correct');
                            if (score == 7) {
                              _finalDialog(context);
                            }
                            changeQuestion();
                          } else {
                            _showDialog(context, 2);
                          }
                        }),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(80),
                          child: Image.asset(
                            'assets/images/${countryList[2]}.png',
                            height: 110.h,
                            width: 200.w,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20).r,
              child: InkWell(
                  child: Text(
                'Score: $score',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w700),
              )),
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
            content: new Text("Your Score is $score"),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text("Continue"),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    changeQuestion();
                  });
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
              children: <Widget>[
                Text("Final Score"),
              ],
            ),
            content: new Text("Your Score is $score"),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text("Restart"),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    score = 0;
                    changeQuestion();
                  });
                },
              ),
            ],
          );
        });
  }
}
